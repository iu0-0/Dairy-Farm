import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/breed_model.dart';
import '../models/animal_model.dart';
import '../models/farm_model.dart';
import '../models/gallery_model.dart';
import '../models/user_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ApiService — central HTTP client for Krishna Dairy Farm Laravel API
// Base URL: http://127.0.0.1:8000/api
// ─────────────────────────────────────────────────────────────────────────────
class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // ── Singleton ──────────────────────────────────────────────────────────────
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // ── Token Management ───────────────────────────────────────────────────────
  String? _token;

  Future<String?> get token async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    return _token;
  }

  Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }

  Future<Map<String, String>> get _authHeaders async {
    final t = await token;
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (t != null) 'Authorization': 'Bearer $t',
    };
  }

  // ── Helper ─────────────────────────────────────────────────────────────────
  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<dynamic> _get(String path) async {
    final headers = await _authHeaders;
    final res = await http.get(_uri(path), headers: headers);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      debugPrint('GET $path → ${res.statusCode}: ${res.body}');
      throw Exception('GET $path failed (${res.statusCode})');
    }
  }

  Future<dynamic> _post(String path, Map<String, dynamic> body,
      {bool withAuth = true}) async {
    final headers = withAuth
        ? await _authHeaders
        : {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final res = await http.post(_uri(path),
        headers: headers, body: jsonEncode(body));
    return _handleResponse(path, 'POST', res);
  }

  Future<dynamic> _put(String path, Map<String, dynamic> body) async {
    final headers = await _authHeaders;
    final res = await http.put(_uri(path),
        headers: headers, body: jsonEncode(body));
    return _handleResponse(path, 'PUT', res);
  }

  Future<void> _delete(String path) async {
    final headers = await _authHeaders;
    final res = await http.delete(_uri(path), headers: headers);
    if (res.statusCode != 200 && res.statusCode != 204) {
      debugPrint('DELETE $path → ${res.statusCode}: ${res.body}');
      final err = _tryDecodeError(res.body);
      throw Exception(err ?? 'DELETE $path failed (${res.statusCode})');
    }
  }

  dynamic _handleResponse(String path, String method, http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return {};
      return jsonDecode(res.body);
    } else {
      debugPrint('$method $path → ${res.statusCode}: ${res.body}');
      final err = _tryDecodeError(res.body);
      throw Exception(err ?? '$method $path failed (${res.statusCode})');
    }
  }

  String? _tryDecodeError(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        return decoded['message']?.toString() ??
            decoded['error']?.toString();
      }
    } catch (_) {}
    return null;
  }

  // ── Auth ───────────────────────────────────────────────────────────────────

  /// POST /api/register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? farmName,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    final data = await _post('/register', body, withAuth: false)
        as Map<String, dynamic>;
    final t = data['token']?.toString() ?? data['access_token']?.toString();
    if (t != null) await saveToken(t);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(data['user'] ?? {}));
    
    // Create farm after registration if a farm name was provided
    if (farmName != null && farmName.isNotEmpty) {
      try {
        await createFarm({'name': farmName});
      } catch (e) {
        debugPrint('Failed to create farm during registration: $e');
        // We don't throw here so the user is still logged in
      }
    }

    return data;
  }

  /// POST /api/login — Returns the user map on success, throws on failure.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      _uri('/login'),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final t = body['token']?.toString() ?? body['access_token']?.toString();
      if (t != null) await saveToken(t);

      // Persist user role
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(body['user'] ?? {}));
      return body;
    } else {
      final err = jsonDecode(res.body);
      throw Exception(err['message'] ?? 'Login failed');
    }
  }

  /// POST /api/logout
  Future<void> logout() async {
    try {
      final headers = await _authHeaders;
      await http.post(_uri('/logout'), headers: headers);
    } catch (_) {}
    await clearToken();
  }

  Future<bool> get isLoggedIn async => (await token) != null;

  Future<String?> get savedUserRole async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_data');
    if (raw == null) return null;
    final data = jsonDecode(raw) as Map<String, dynamic>;
    return data['role']?.toString();
  }

  // ── Profile ────────────────────────────────────────────────────────────────

  /// GET /api/profile
  Future<UserModel> getProfile() async {
    final data = await _get('/profile');
    final userJson = data is Map<String, dynamic>
        ? (data['user'] as Map<String, dynamic>? ?? data)
        : data as Map<String, dynamic>;
    return UserModel.fromJson(userJson);
  }

  /// PUT /api/profile
  Future<UserModel> updateProfile(Map<String, dynamic> payload) async {
    final data = await _put('/profile', payload) as Map<String, dynamic>;
    final userJson = data['user'] as Map<String, dynamic>? ?? data;
    // Refresh cached user data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(userJson));
    return UserModel.fromJson(userJson);
  }

  // ── Dashboard / Reports ────────────────────────────────────────────────────
  Future<Map<String, dynamic>> getDashboard() async {
    final data = await _get('/reports/dashboard');
    return data as Map<String, dynamic>;
  }

  // ── Farms ──────────────────────────────────────────────────────────────────

  /// GET /api/farms
  Future<List<Farm>> getFarms() async {
    final data = await _get('/farms');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List)
        .map((j) => Farm.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// POST /api/farms
  Future<Farm> createFarm(Map<String, dynamic> payload) async {
    final data = await _post('/farms', payload) as Map<String, dynamic>;
    final farmJson = data['farm'] as Map<String, dynamic>? ??
        data['data'] as Map<String, dynamic>? ??
        data;
    return Farm.fromJson(farmJson);
  }

  /// GET /api/farms/{id}
  Future<Farm> getFarm(int id) async {
    final data = await _get('/farms/$id');
    final farmJson = data['farm'] as Map<String, dynamic>? ??
        data['data'] as Map<String, dynamic>? ??
        data as Map<String, dynamic>;
    return Farm.fromJson(farmJson);
  }

  /// PUT /api/farms/{id}
  Future<Farm> updateFarm(int id, Map<String, dynamic> payload) async {
    final data = await _put('/farms/$id', payload) as Map<String, dynamic>;
    final farmJson = data['farm'] as Map<String, dynamic>? ??
        data['data'] as Map<String, dynamic>? ??
        data;
    return Farm.fromJson(farmJson);
  }

  /// DELETE /api/farms/{id}
  Future<void> deleteFarm(int id) async {
    await _delete('/farms/$id');
  }

  // ── Breeds ─────────────────────────────────────────────────────────────────
  Future<List<Breed>> getBreeds() async {
    final data = await _get('/breeds');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List)
        .map((j) => Breed.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  // ── Animals ────────────────────────────────────────────────────────────────
  Future<List<AnimalModel>> getAnimals() async {
    final data = await _get('/animals');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List)
        .map((j) => AnimalModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  // ── Animal Types ───────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getAnimalTypes() async {
    final data = await _get('/animal-types');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List).cast<Map<String, dynamic>>();
  }

  // ── Milk Records ───────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getMilkRecords() async {
    final data = await _get('/milk');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List).cast<Map<String, dynamic>>();
  }

  // ── Animal Gallery ─────────────────────────────────────────────────────────
  Future<List<GalleryItemModel>> getAnimalGallery() async {
    final data = await _get('/animal-gallery');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List)
        .map((j) => GalleryItemModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  // ── Farm Gallery ───────────────────────────────────────────────────────────
  Future<List<GalleryItemModel>> getFarmGallery() async {
    final data = await _get('/farm-gallery');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List)
        .map((j) => GalleryItemModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  // ── Feeds ──────────────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getFeeds() async {
    final data = await _get('/feeds');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List).cast<Map<String, dynamic>>();
  }

  // ── Health Records ─────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getHealthRecords() async {
    final data = await _get('/health');
    final list = data is List ? data : (data['data'] ?? []);
    return (list as List).cast<Map<String, dynamic>>();
  }
}

// ── Global singleton ──────────────────────────────────────────────────────────
final apiService = ApiService();

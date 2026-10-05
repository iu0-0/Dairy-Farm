import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// CowHeadIcon — Custom Scalable Vector Cow Head Icon
// ─────────────────────────────────────────────────────────────
class CowHeadIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CowHeadIcon({
    super.key,
    this.size = 24.0,
    this.color = const Color(0xFF0C3823),
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color == Colors.transparent ? const Color(0xFF0C3823) : color;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _CowHeadPainter(color: iconColor),
      ),
    );
  }
}

class _CowHeadPainter extends CustomPainter {
  final Color color;

  _CowHeadPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;

    // ── 1. Curved Horns ──
    final leftHorn = Path()
      ..moveTo(w * 0.36, h * 0.28)
      ..cubicTo(w * 0.24, h * 0.18, w * 0.14, h * 0.08, w * 0.22, h * 0.02)
      ..cubicTo(w * 0.30, h * 0.02, w * 0.38, h * 0.14, w * 0.42, h * 0.26)
      ..close();
    canvas.drawPath(leftHorn, paint);

    final rightHorn = Path()
      ..moveTo(w * 0.64, h * 0.28)
      ..cubicTo(w * 0.76, h * 0.18, w * 0.86, h * 0.08, w * 0.78, h * 0.02)
      ..cubicTo(w * 0.70, h * 0.02, w * 0.62, h * 0.14, w * 0.58, h * 0.26)
      ..close();
    canvas.drawPath(rightHorn, paint);

    // ── 2. Ears ──
    final leftEar = Path()
      ..moveTo(w * 0.32, h * 0.36)
      ..cubicTo(w * 0.15, h * 0.34, w * 0.02, h * 0.44, w * 0.06, h * 0.52)
      ..cubicTo(w * 0.15, h * 0.54, w * 0.28, h * 0.48, w * 0.32, h * 0.42)
      ..close();
    canvas.drawPath(leftEar, paint);

    final rightEar = Path()
      ..moveTo(w * 0.68, h * 0.36)
      ..cubicTo(w * 0.85, h * 0.34, w * 0.98, h * 0.44, w * 0.94, h * 0.52)
      ..cubicTo(w * 0.85, h * 0.54, w * 0.72, h * 0.48, w * 0.68, h * 0.42)
      ..close();
    canvas.drawPath(rightEar, paint);

    // ── 3. Head & Face Outline ──
    final facePath = Path()
      ..moveTo(w * 0.34, h * 0.26)
      ..quadraticBezierTo(w * 0.50, h * 0.23, w * 0.66, h * 0.26)
      ..cubicTo(w * 0.74, h * 0.38, w * 0.76, h * 0.62, w * 0.68, h * 0.82)
      ..cubicTo(w * 0.60, h * 0.96, w * 0.40, h * 0.96, w * 0.32, h * 0.82)
      ..cubicTo(w * 0.24, h * 0.62, w * 0.26, h * 0.38, w * 0.34, h * 0.26)
      ..close();
    canvas.drawPath(facePath, paint);

    // ── 4. Cutout Snout / Muzzle ──
    final bgCutoutPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final snoutRect = RRect.fromLTRBR(
      w * 0.33,
      h * 0.65,
      w * 0.67,
      h * 0.88,
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(snoutRect, bgCutoutPaint);

    // ── 5. Nostrils ──
    final nostrilPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.42, h * 0.76), w * 0.045, nostrilPaint);
    canvas.drawCircle(Offset(w * 0.58, h * 0.76), w * 0.045, nostrilPaint);

    // ── 6. Eyes (Small subtle dots) ──
    canvas.drawCircle(Offset(w * 0.40, h * 0.45), w * 0.035, bgCutoutPaint);
    canvas.drawCircle(Offset(w * 0.60, h * 0.45), w * 0.035, bgCutoutPaint);
  }

  @override
  bool shouldRepaint(covariant _CowHeadPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

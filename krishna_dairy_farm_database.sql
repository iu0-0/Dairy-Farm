CREATE DATABASE IF NOT EXISTS krishna_dairy_farm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE krishna_dairy_farm;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS activity_logs,payments,subscriptions,subscription_plans,notifications,inventory,income,expenses,feed_transactions,feed_stock,feed_types,animal_weights,breeding_records,pregnancy_records,vaccinations,health_records,milk_records,animal_gallery,animals,breeds,animal_types,users,farms,roles;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE roles(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(50) UNIQUE NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE farms(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(150) NOT NULL,owner_name VARCHAR(150),phone VARCHAR(20),email VARCHAR(150),address TEXT,city VARCHAR(100),state VARCHAR(100),country VARCHAR(100) DEFAULT 'India',logo VARCHAR(255),status ENUM('active','inactive','trial','expired') DEFAULT 'trial',trial_started_at DATETIME,trial_ends_at DATETIME,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE users(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NULL,role_id BIGINT UNSIGNED NOT NULL,name VARCHAR(150) NOT NULL,email VARCHAR(150) UNIQUE,mobile VARCHAR(20) UNIQUE,password VARCHAR(255) NOT NULL,profile_image VARCHAR(255),status ENUM('active','inactive') DEFAULT 'active',email_verified_at DATETIME,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE SET NULL,FOREIGN KEY(role_id) REFERENCES roles(id)) ENGINE=InnoDB;
CREATE TABLE animal_types(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) UNIQUE NOT NULL,description TEXT,image VARCHAR(255),status BOOLEAN DEFAULT TRUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE breeds(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,animal_type_id BIGINT UNSIGNED NOT NULL,name VARCHAR(100) NOT NULL,origin VARCHAR(100),average_milk DECIMAL(8,2) DEFAULT 0,average_fat DECIMAL(5,2) DEFAULT 0,description TEXT,image VARCHAR(255),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,UNIQUE(animal_type_id,name),FOREIGN KEY(animal_type_id) REFERENCES animal_types(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE animals(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_type_id BIGINT UNSIGNED NOT NULL,breed_id BIGINT UNSIGNED,tag_id VARCHAR(100) NOT NULL,name VARCHAR(100),gender ENUM('male','female') NOT NULL,date_of_birth DATE,weight DECIMAL(8,2) DEFAULT 0,purchase_date DATE,purchase_price DECIMAL(12,2) DEFAULT 0,health_status ENUM('healthy','sick','under_treatment','recovered') DEFAULT 'healthy',current_location VARCHAR(150),notes TEXT,photo VARCHAR(255),status ENUM('active','sold','dead','transferred') DEFAULT 'active',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,UNIQUE(farm_id,tag_id),FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_type_id) REFERENCES animal_types(id),FOREIGN KEY(breed_id) REFERENCES breeds(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE animal_gallery(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,animal_id BIGINT UNSIGNED NOT NULL,type ENUM('photo','video','document') DEFAULT 'photo',file_path VARCHAR(255) NOT NULL,title VARCHAR(150),description TEXT,is_cover BOOLEAN DEFAULT FALSE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE milk_records(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,user_id BIGINT UNSIGNED,record_date DATE NOT NULL,session ENUM('morning','evening') NOT NULL,quantity DECIMAL(8,2) NOT NULL,fat DECIMAL(5,2) DEFAULT 0,snf DECIMAL(5,2) DEFAULT 0,quality VARCHAR(100),notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE health_records(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,problem VARCHAR(255),symptoms TEXT,diagnosis TEXT,treatment TEXT,medicine VARCHAR(255),veterinarian VARCHAR(150),treatment_date DATE,follow_up_date DATE,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE vaccinations(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,vaccine_name VARCHAR(150) NOT NULL,vaccination_date DATE NOT NULL,next_due_date DATE,veterinarian VARCHAR(150),status ENUM('completed','upcoming','overdue') DEFAULT 'completed',notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE pregnancy_records(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,heat_date DATE,insemination_date DATE,pregnancy_check_date DATE,pregnancy_status ENUM('not_confirmed','confirmed','not_pregnant','completed') DEFAULT 'not_confirmed',expected_calving_date DATE,actual_calving_date DATE,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE breeding_records(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,heat_detection_date DATE,insemination_date DATE,bull_name VARCHAR(150),semen_information TEXT,pregnancy_check_date DATE,pregnancy_status VARCHAR(100),expected_delivery_date DATE,actual_calving_date DATE,calf_details TEXT,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE animal_weights(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,animal_id BIGINT UNSIGNED NOT NULL,weight DECIMAL(8,2) NOT NULL,recorded_date DATE NOT NULL,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE feed_types(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(150) UNIQUE NOT NULL,unit VARCHAR(50),minimum_stock DECIMAL(10,2) DEFAULT 0,description TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE feed_stock(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,feed_type_id BIGINT UNSIGNED NOT NULL,quantity DECIMAL(10,2) DEFAULT 0,purchase_price DECIMAL(12,2) DEFAULT 0,supplier VARCHAR(150),expiry_date DATE,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,UNIQUE(farm_id,feed_type_id),FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(feed_type_id) REFERENCES feed_types(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE feed_transactions(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,feed_type_id BIGINT UNSIGNED NOT NULL,type ENUM('purchase','usage','adjustment') NOT NULL,quantity DECIMAL(10,2) NOT NULL,transaction_date DATE NOT NULL,user_id BIGINT UNSIGNED,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(feed_type_id) REFERENCES feed_types(id),FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE expenses(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,category VARCHAR(100) NOT NULL,amount DECIMAL(12,2) NOT NULL,expense_date DATE NOT NULL,payment_method VARCHAR(50),paid_by VARCHAR(150),description TEXT,receipt VARCHAR(255),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE income(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,source VARCHAR(150) NOT NULL,amount DECIMAL(12,2) NOT NULL,income_date DATE NOT NULL,payment_method VARCHAR(50),description TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE inventory(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,item_name VARCHAR(150) NOT NULL,category VARCHAR(100),quantity DECIMAL(10,2) DEFAULT 0,unit VARCHAR(50),minimum_stock DECIMAL(10,2) DEFAULT 0,expiry_date DATE,supplier VARCHAR(150),purchase_price DECIMAL(12,2) DEFAULT 0,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE notifications(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED,user_id BIGINT UNSIGNED,type VARCHAR(100),title VARCHAR(200) NOT NULL,message TEXT,is_read BOOLEAN DEFAULT FALSE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE subscription_plans(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) UNIQUE NOT NULL,price_monthly DECIMAL(10,2) DEFAULT 0,price_yearly DECIMAL(10,2) DEFAULT 0,max_animals INT,max_users INT,storage_gb INT DEFAULT 1,ads_enabled BOOLEAN DEFAULT TRUE,description TEXT,status BOOLEAN DEFAULT TRUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE subscriptions(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,plan_id BIGINT UNSIGNED NOT NULL,start_date DATE NOT NULL,end_date DATE NOT NULL,status ENUM('trial','active','expired','cancelled') DEFAULT 'trial',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(plan_id) REFERENCES subscription_plans(id)) ENGINE=InnoDB;
CREATE TABLE payments(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED NOT NULL,subscription_id BIGINT UNSIGNED,amount DECIMAL(12,2) NOT NULL,payment_method VARCHAR(50),transaction_id VARCHAR(255),status ENUM('pending','success','failed','refunded') DEFAULT 'pending',payment_date DATETIME,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE CASCADE,FOREIGN KEY(subscription_id) REFERENCES subscriptions(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE activity_logs(id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,farm_id BIGINT UNSIGNED,user_id BIGINT UNSIGNED,action VARCHAR(100) NOT NULL,module VARCHAR(100),description TEXT,ip_address VARCHAR(45),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(farm_id) REFERENCES farms(id) ON DELETE SET NULL,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;

INSERT INTO roles(name) VALUES ('main_admin'),('farm_admin'),('farm_user');

INSERT INTO farms(name,owner_name,phone,email,address,city,state,status,trial_started_at,trial_ends_at) VALUES
('Krishna Dairy Farm','Karan Garchar','9876543210','admin@krishnadairy.com','Ahmedabad','Ahmedabad','Gujarat','active',NOW(),DATE_ADD(NOW(),INTERVAL 7 DAY)),
('Shree Dairy Farm','Raj Patel','9876543211','raj@shreedairy.com','Mehsana','Mehsana','Gujarat','trial',NOW(),DATE_ADD(NOW(),INTERVAL 7 DAY)),
('Green Valley Dairy','Amit Shah','9876543212','amit@greenvalley.com','Anand','Anand','Gujarat','trial',NOW(),DATE_ADD(NOW(),INTERVAL 7 DAY));

-- Replace these demo password values with Laravel Hash::make() values before production.
INSERT INTO users(farm_id,role_id,name,email,mobile,password,status) VALUES
(NULL,1,'Main Admin','mainadmin@krishnadairy.com','9000000001','CHANGE_THIS_PASSWORD','active'),
(1,2,'Karan Garchar','karan@krishnadairy.com','9000000002','CHANGE_THIS_PASSWORD','active'),
(1,3,'Farm Worker 1','worker1@krishnadairy.com','9000000003','CHANGE_THIS_PASSWORD','active'),
(2,2,'Raj Patel','raj@shreedairy.com','9000000004','CHANGE_THIS_PASSWORD','active'),
(3,2,'Amit Shah','amit@greenvalley.com','9000000005','CHANGE_THIS_PASSWORD','active');

INSERT INTO animal_types(name,description) VALUES
('Cow','Adult female cow'),('Buffalo','Adult female buffalo'),('Cow Calf','Young cow calf'),('Buffalo Calf','Young buffalo calf'),('Bull','Male cattle'),('Breeding Bull','Bull used for breeding');

INSERT INTO breeds(animal_type_id,name,origin,average_milk,average_fat,description) VALUES
(1,'Gir','India',10,4.5,'Indian dairy cattle breed'),(1,'HF','Europe',20,3.8,'High milk producing dairy breed'),(1,'Jersey','United Kingdom',15,4.8,'Dairy cattle breed'),(1,'Sahiwal','India',12,4.5,'Indian dairy cattle breed'),(2,'Murrah','India',12,7,'Popular dairy buffalo breed'),(2,'Mehsana','India',10,6.5,'Gujarat buffalo breed'),(2,'Surti','India',8,6.5,'Gujarat buffalo breed'),(2,'Jaffarabadi','India',9,7,'Large Indian buffalo breed');

INSERT INTO feed_types(name,unit,minimum_stock) VALUES
('Cattle Feed','kg',100),('Green Fodder','kg',200),('Dry Fodder','kg',200),('Hay','kg',100),('Silage','kg',150),('Mineral Mixture','kg',25),('Feed Bran','kg',50);

INSERT INTO subscription_plans(name,price_monthly,price_yearly,max_animals,max_users,storage_gb,ads_enabled,description) VALUES
('Trial',0,0,25,2,1,TRUE,'7-day free trial'),('Basic',599,5999,50,2,1,TRUE,'For small dairy farms'),('Pro',899,8999,NULL,5,10,FALSE,'For growing dairy farms');

INSERT INTO animals(farm_id,animal_type_id,breed_id,tag_id,name,gender,date_of_birth,weight,health_status,current_location,notes) VALUES
(1,1,1,'KDF-C-001','Gauri','female','2022-04-15',420,'healthy','Shed A','High producing Gir cow'),
(1,1,2,'KDF-C-002','Radha','female','2021-08-20',450,'healthy','Shed A','HF cow'),
(1,2,5,'KDF-B-001','Kamdhenu','female','2021-02-10',520,'healthy','Shed B','Murrah buffalo'),
(1,3,1,'KDF-CC-001','Gopi','female','2025-03-12',120,'healthy','Calf Shed','Cow calf'),
(1,4,5,'KDF-BC-001','Moti','male','2025-05-10',140,'healthy','Calf Shed','Buffalo calf'),
(2,1,3,'SDF-C-001','Laxmi','female','2022-01-18',400,'healthy','Shed A','Jersey cow'),
(3,2,6,'GV-B-001','Ganga','female','2021-11-05',510,'healthy','Shed A','Mehsana buffalo');

INSERT INTO animal_gallery(animal_id,type,file_path,title,description,is_cover) VALUES
(1,'photo','animals/1/front.jpg','Front Photo','Front view of Gauri',TRUE),
(1,'photo','animals/1/left.jpg','Left Side','Left side view',FALSE),
(1,'photo','animals/1/right.jpg','Right Side','Right side view',FALSE),
(2,'photo','animals/2/front.jpg','Front Photo','Front view of Radha',TRUE),
(3,'photo','animals/3/front.jpg','Front Photo','Front view of Kamdhenu',TRUE);

INSERT INTO milk_records(farm_id,animal_id,user_id,record_date,session,quantity,fat,snf,quality,notes) VALUES
(1,1,3,CURDATE(),'morning',8.5,4.5,8.5,'Good','Normal morning collection'),
(1,1,3,CURDATE(),'evening',7.2,4.4,8.4,'Good','Normal evening collection'),
(1,2,3,CURDATE(),'morning',12,3.8,8.6,'Good','Normal morning collection'),
(1,2,3,CURDATE(),'evening',10.5,3.8,8.6,'Good','Normal evening collection'),
(1,3,3,CURDATE(),'morning',9,7,9,'Excellent','Normal morning collection'),
(1,3,3,CURDATE(),'evening',8,6.9,8.9,'Excellent','Normal evening collection');

INSERT INTO health_records(farm_id,animal_id,problem,symptoms,diagnosis,treatment,veterinarian,treatment_date,follow_up_date,notes) VALUES
(1,1,'Routine Checkup','No major symptoms','Healthy','Routine observation','Dr. Mehta',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 30 DAY),'Routine health check');

INSERT INTO vaccinations(farm_id,animal_id,vaccine_name,vaccination_date,next_due_date,veterinarian,status,notes) VALUES
(1,1,'FMD Vaccine',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 6 MONTH),'Dr. Mehta','completed','Routine vaccination'),
(1,2,'HS Vaccine',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 6 MONTH),'Dr. Mehta','completed','Routine vaccination');

INSERT INTO pregnancy_records(farm_id,animal_id,heat_date,insemination_date,pregnancy_check_date,pregnancy_status,expected_calving_date,notes) VALUES
(1,1,'2026-07-01','2026-07-02','2026-07-30','confirmed','2027-04-10','Pregnancy confirmed');

INSERT INTO breeding_records(farm_id,animal_id,heat_detection_date,insemination_date,bull_name,semen_information,pregnancy_check_date,pregnancy_status,expected_delivery_date,notes) VALUES
(1,1,'2026-07-01','2026-07-02','Gir Bull A','Sample semen record','2026-07-30','confirmed','2027-04-10','Demo breeding record');

INSERT INTO animal_weights(farm_id,animal_id,weight,recorded_date,notes) VALUES
(1,1,420,CURDATE(),'Monthly weight'),(1,2,450,CURDATE(),'Monthly weight'),(1,3,520,CURDATE(),'Monthly weight');

INSERT INTO feed_stock(farm_id,feed_type_id,quantity,purchase_price,supplier,expiry_date) VALUES
(1,1,500,32,'Local Feed Supplier',DATE_ADD(CURDATE(),INTERVAL 12 MONTH)),
(1,2,1000,4,'Green Farm Supplier',NULL),(1,3,800,8,'Local Fodder Supplier',NULL),
(1,4,400,10,'Hay Supplier',NULL),(1,5,600,12,'Silage Supplier',DATE_ADD(CURDATE(),INTERVAL 6 MONTH)),
(1,6,50,120,'Mineral Supplier',DATE_ADD(CURDATE(),INTERVAL 12 MONTH)),(1,7,150,25,'Feed Bran Supplier',NULL);

INSERT INTO feed_transactions(farm_id,feed_type_id,type,quantity,transaction_date,user_id,notes) VALUES
(1,1,'purchase',500,CURDATE(),3,'Initial stock'),(1,1,'usage',25,CURDATE(),3,'Daily usage'),(1,2,'usage',100,CURDATE(),3,'Daily green fodder usage');

INSERT INTO expenses(farm_id,category,amount,expense_date,payment_method,paid_by,description) VALUES
(1,'Feed',16000,CURDATE(),'UPI','Karan Garchar','Monthly cattle feed purchase'),
(1,'Medicine',2500,CURDATE(),'Cash','Karan Garchar','Animal medicines'),
(1,'Electricity',3500,CURDATE(),'UPI','Karan Garchar','Farm electricity bill');

INSERT INTO income(farm_id,source,amount,income_date,payment_method,description) VALUES
(1,'Milk',18500,CURDATE(),'UPI','Daily milk income'),(1,'Other',2500,CURDATE(),'Cash','Other farm income');

INSERT INTO inventory(farm_id,item_name,category,quantity,unit,minimum_stock,expiry_date,supplier,purchase_price) VALUES
(1,'FMD Vaccine','Medicine',20,'Vial',5,DATE_ADD(CURDATE(),INTERVAL 12 MONTH),'Veterinary Supplier',250),
(1,'Milking Bucket','Milking Equipment',10,'Piece',2,NULL,'Farm Equipment Supplier',850),
(1,'Cleaning Brush','Cleaning Supplies',15,'Piece',5,NULL,'Farm Supply Store',120);

INSERT INTO notifications(farm_id,user_id,type,title,message,is_read) VALUES
(1,2,'vaccination','Vaccination Reminder','Check upcoming animal vaccinations.',FALSE),
(1,2,'pregnancy','Pregnancy Follow-up','Pregnancy follow-up is scheduled.',FALSE),
(1,2,'feed','Feed Stock','Review current feed stock levels.',FALSE);

INSERT INTO subscriptions(farm_id,plan_id,start_date,end_date,status) VALUES
(1,3,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 30 DAY),'active'),
(2,1,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY),'trial'),
(3,1,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY),'trial');

INSERT INTO payments(farm_id,subscription_id,amount,payment_method,transaction_id,status,payment_date) VALUES
(1,1,899,'demo','DEMO-TXN-001','success',NOW());

CREATE INDEX idx_users_farm ON users(farm_id);
CREATE INDEX idx_animals_farm ON animals(farm_id);
CREATE INDEX idx_milk_farm_date ON milk_records(farm_id,record_date);
CREATE INDEX idx_vaccination_due ON vaccinations(farm_id,next_due_date);
CREATE INDEX idx_expenses_farm_date ON expenses(farm_id,expense_date);
CREATE INDEX idx_income_farm_date ON income(farm_id,income_date);
CREATE INDEX idx_notifications_user ON notifications(user_id,is_read);
CREATE INDEX idx_payments_farm ON payments(farm_id);

SELECT 'Krishna Dairy Farm database created successfully' AS message;

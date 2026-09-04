-- ============================================================
-- قاعدة بيانات الأرضية الرقمية لوزارة التربية الوطنية
-- Digital Educational Platform Database
-- ============================================================

CREATE DATABASE IF NOT EXISTS `education_platform_db` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `education_platform_db`;

-- ------------------------------------------------------------
-- 1. جدول المستعملين والنظام (Users & Authentication)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `dzds_id` VARCHAR(100) UNIQUE COMMENT 'معرف الدخول الموحد عبر المحافظة السامية للرقمنة',
    `full_name` VARCHAR(150) NOT NULL,
    `email` VARCHAR(100) UNIQUE,
    `role` ENUM('admin', 'director', 'teacher', 'supervisor') DEFAULT 'director',
    `institution_name` VARCHAR(150) DEFAULT 'متوسطة الشهيد خالد مكاوي (سطاوالي)',
    `directorate` VARCHAR(100) DEFAULT 'مديرية التربية للجزائر غرب',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 2. جدول التلاميذ (Students Master Table)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `students` (
    `id` VARCHAR(50) PRIMARY KEY COMMENT 'رقم التعريف الموحد للتلميذ',
    `first_name` VARCHAR(50) NOT NULL COMMENT 'الاسم بالعربية',
    `last_name` VARCHAR(50) NOT NULL COMMENT 'اللقب بالعربية',
    `first_name_latin` VARCHAR(50) COMMENT 'الاسم باللاتينية',
    `last_name_latin` VARCHAR(50) COMMENT 'اللقب باللاتينية',
    `gender` ENUM('ذكر', 'أنثى') NOT NULL,
    `birth_date` DATE NOT NULL,
    `birth_place` VARCHAR(100) NOT NULL,
    `address` VARCHAR(255),
    `academic_year` VARCHAR(20) DEFAULT '2026-2027',
    `level` VARCHAR(50) DEFAULT 'رابعة',
    `group_no` VARCHAR(10) DEFAULT '1' COMMENT 'رقم الفوج',
    `status` ENUM('خارجي', 'داخلي', 'نصف داخلي') DEFAULT 'خارجي',
    `is_registered` TINYINT(1) DEFAULT 0 COMMENT 'حالة التسجيل البيداغوجي ودفع الحقوق',
    `exam_registered` TINYINT(1) DEFAULT 0 COMMENT 'حالة التسجيل في الامتحانات الرسمية BEM',
    `struck_off` TINYINT(1) DEFAULT 0 COMMENT 'حالة الشطب',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 3. جدول الامتحانات الرسمية (Official Examinations Registration)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `exam_registrations` (
    `registration_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` VARCHAR(50) NOT NULL,
    `directorate` VARCHAR(150) DEFAULT 'مديرية التربية للجزائر غرب',
    `exam_center` VARCHAR(150),
    `exam_wilaya_code` VARCHAR(10),
    `exam_commune_name` VARCHAR(100),
    `father_name` VARCHAR(100),
    `mother_name` VARCHAR(150),
    `registration_status` ENUM('registered', 'pending', 'cancelled') DEFAULT 'registered',
    `registered_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`student_id`) REFERENCES `students`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 4. جدول التوجيه المدرسي وبطاقة المتابعة (Guidance & Follow-up)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `guidance_records` (
    `guidance_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` VARCHAR(50) NOT NULL,
    `pref_1` VARCHAR(100) COMMENT 'الرغبة الأولى',
    `pref_2` VARCHAR(100) COMMENT 'الرغبة الثانية',
    `pref_3` VARCHAR(100) COMMENT 'الرغبة الثالثة',
    `pref_4` VARCHAR(100) COMMENT 'الرغبة الرابعة',
    `council_proposal` VARCHAR(100) COMMENT 'اقتراح مجلس القسم',
    `final_guidance` VARCHAR(100) COMMENT 'قرار التوجيه النهائي',
    `guardian_name` VARCHAR(100),
    `guardian_relation` VARCHAR(50),
    `guardian_job` VARCHAR(100),
    `guardian_phone` VARCHAR(30),
    `absences_justified` INT DEFAULT 0,
    `absences_unjustified` INT DEFAULT 0,
    `delays` INT DEFAULT 0,
    `general_behavior` ENUM('ممتاز', 'جيد جداً', 'جيد', 'مقبول', 'يحتاج متابعة') DEFAULT 'جيد',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`student_id`) REFERENCES `students`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 5. جدول طلبات التحويل بين المؤسسات (Student Transfers)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `transfers` (
    `transfer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` VARCHAR(50) NOT NULL,
    `student_name` VARCHAR(150) NOT NULL,
    `original_school` VARCHAR(150) NOT NULL,
    `destination_school` VARCHAR(150) NOT NULL,
    `request_date` DATE NOT NULL,
    `status` ENUM('قيد الدراسة', 'مقبول', 'مرفوض') DEFAULT 'قيد الدراسة',
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`student_id`) REFERENCES `students`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 6. جدول التلاميذ المنقطعين عن الدراسة (Dropout Students)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `dropout_students` (
    `dropout_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` VARCHAR(50) UNIQUE NOT NULL,
    `full_name` VARCHAR(150) NOT NULL,
    `last_level` VARCHAR(50) DEFAULT 'رابعة',
    `dropout_date` DATE,
    `reintegration_status` ENUM('قيد الانتظار', 'تم الإدماج', 'مرفوض') DEFAULT 'قيد الانتظار',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 7. جدول إحصائيات الشهادات والوثائق المستخرجة (Certificates Serial Audit)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `certificates_log` (
    `log_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` VARCHAR(50) NOT NULL,
    `cert_type` ENUM('شهادة مدرسية', 'شهادة تسجيل', 'بطاقة متابعة') NOT NULL,
    `serial_number` INT NOT NULL,
    `issued_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`student_id`) REFERENCES `students`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- إضافة بيانات تجريبية البداية (Dummy Data)
-- ------------------------------------------------------------
INSERT INTO `users` (`dzds_id`, `full_name`, `email`, `role`) 
VALUES ('DZDS-2026-9988', 'مستخدم DZDS المعتمد', 'admin@education.dz', 'admin');

INSERT INTO `students` (`id`, `first_name`, `last_name`, `first_name_latin`, `last_name_latin`, `gender`, `birth_date`, `birth_place`, `address`, `academic_year`, `level`, `group_no`, `status`, `is_registered`) 
VALUES 
('20260001', 'أحمد', 'بن علي', 'Ahmed', 'Benali', 'ذكر', '2011-05-12', 'سطاوالي', 'سطاوالي الحي القسيم', '2026-2027', 'رابعة', '1', 'خارجي', 1),
('20260002', 'مريم', 'قاسم', 'Meryem', 'Kacem', 'أنثى', '2011-09-24', 'زرالدة', 'زرالدة وسط المدينة', '2026-2027', 'رابعة', '2', 'خارجي', 0);
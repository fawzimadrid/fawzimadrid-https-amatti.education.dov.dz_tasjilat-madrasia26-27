<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>الخلية الرقمية - مصلحة التمدرس - مديرية التربية للجزائر غرب</title>
    <!-- استدعاء خط Noto Kufi Arabic للواجهات و Droid Arabic Kufi للطباعة -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Kufi+Arabic:wght@400;700&family=Droid+Arabic+Kufi:wght@400;700&display=swap" rel="stylesheet">
    <!-- SheetJS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Chart.js لأشكال بيانية حقيقية ومتحركة -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --main-blue: #007bff;
            --header-blue: #0056b3;
            --faint-red: #fff5f5;
            --faint-blue: #f0f7ff;
            --border-color: #ddd;
            --modal-bg: rgba(0, 0, 0, 0.7);
            --success-green: #28a745;
            --danger-red: #dc3545;
            --dark-red: #8b0000;
            --dark-orange: #ff8c00;
            --custom-teal: #e0f2f1; /* باهت مائل للأزرق البحري */
            --royal-gold: #b8860b;
        }

        body {
            font-family: 'Noto Kufi Arabic', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* شاشة التحميل المعلقة */
        #loadingOverlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(255, 255, 255, 0.95);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        .spinner {
            width: 60px;
            height: 60px;
            border: 6px solid #ccc;
            border-top-color: var(--main-blue);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        .loading-text {
            margin-top: 20px;
            font-weight: bold;
            font-size: 18px;
            color: #333;
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .top-navbar {
            background-color: var(--header-blue);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            height: 70px;
        }

        .nav-part {
            flex: 1;
            text-align: center;
            font-size: 14px;
        }

        .nav-part:first-child {
            text-align: right;
            display: flex;
            align-items: center;
        }

        .logo-img {
            height: 60px;
            margin-left: 10px;
        }

        .window-outer {
            background-color: white;
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            min-height: 80vh;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .window-inner {
            background-color: white;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 5px;
            min-height: 70vh;
        }

        .window-content {
            background-color: white;
            padding: 10px;
            min-height: 60vh;
        }

        .main-title {
            color: var(--main-blue);
            font-size: 26px;
            text-align: center;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .main-subtitle-gov {
            text-align: center;
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .sub-title {
            color: var(--main-blue);
            font-size: 16px;
            text-align: right;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .tabs-container {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .tab-btn {
            background: none;
            border: none;
            padding: 10px 15px;
            font-family: 'Noto Kufi Arabic', sans-serif;
            cursor: pointer;
            color: #555;
            transition: 0.3s;
            flex: 1;
            min-width: 140px;
            font-size: 13px;
        }

        .tab-btn.active {
            color: var(--main-blue);
            border-bottom: 3px solid var(--main-blue);
            font-weight: bold;
        }

        /* التنبيهات */
        .alert-message {
            background-color: var(--custom-teal);
            border: 1px solid #b2dfdb;
            color: #004d40;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 15px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-orange {
            background-color: #fff3e0;
            border: 1px solid #ffe0b2;
            color: #e65100;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 15px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-section {
            background-color: var(--faint-red);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            border: 1px solid #ffdada;
        }

        select, input[type="text"], input[type="date"], input[type="number"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: 'Noto Kufi Arabic', sans-serif;
            outline: none;
            background: white;
        }

        .table-section {
            background-color: var(--faint-blue);
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #ddecff;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            font-size: 13px;
            vertical-align: middle;
        }

        th {
            background-color: #f8f9fa;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Noto Kufi Arabic', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-import { background-color: #28a745; color: white; }
        .btn-export { background-color: #ffc107; color: #333; font-weight: bold; }
        .btn-search { background-color: var(--main-blue); color: white; }
        .btn-update { background-color: #17a2b8; color: white; font-size: 12px; padding: 4px 8px; }
        .btn-register { background-color: #007bff; color: white; font-size: 12px; padding: 4px 8px; }
        .btn-print { background-color: #6c757d; color: white; }
        .btn-auto-group { background-color: #6f42c1; color: white; }
        .btn-sync { background-color: #20c997; color: white; }

        .status-dark-red {
            background-color: var(--dark-red);
            color: white;
            padding: 4px 12px;
            border-radius: 4px;
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
        }

        .status-orange {
            background-color: var(--dark-orange);
            color: white;
            padding: 4px 12px;
            border-radius: 4px;
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
        }

        .status-blue-box {
            background-color: #0056b3;
            color: white;
            padding: 4px 12px;
            border-radius: 4px;
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
        }

        .status-registered {
            background-color: var(--success-green);
            color: white;
            padding: 4px 12px;
            border-radius: 4px;
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
        }

        .pagination {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            gap: 5px;
            align-items: center;
            flex-wrap: wrap;
        }

        .page-btn {
            padding: 8px 14px;
            background: white;
            border: 1px solid var(--main-blue);
            color: var(--main-blue);
            cursor: pointer;
            border-radius: 4px;
            min-width: 40px;
        }

        .page-btn.active {
            background-color: var(--main-blue);
            color: white;
        }

        #fileInput { display: none; }

        /* تعديل النوافذ البيداغوجية الموسعة والمفتوحة بالعرض بدون حدود */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: var(--modal-bg);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content-wide {
            background: white;
            border-radius: 0; /* بدون حدود */
            border: none;
            width: 37cm; /* عرض بيداغوجي موسع حوالي 37 سم */
            max-width: 95%;
            max-height: 92vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        /* نافذة متطابقة متداخلة 3 مستويات بيضاء بالكامل */
        .nested-outer {
            background: white;
            padding: 15px;
            border: 1px solid #ccc;
        }
        .nested-middle {
            background: white;
            padding: 15px;
            border: 1px solid #bbb;
            margin: 10px 0;
        }
        .nested-inner {
            background: white;
            padding: 15px;
            border: 1px solid #999;
            margin: 10px 0;
        }

        .modal-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #ddd;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            background: #f8f9fa;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        /* الإحصائيات والكروت المطورة */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        .dashboard-card {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .stats-summary-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .summary-card {
            background: linear-gradient(135deg, #f0f7ff, #e0efff);
            border: 1px solid #bcdcff;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }

        .summary-card i {
            font-size: 24px;
            color: var(--header-blue);
            margin-bottom: 10px;
        }

        .summary-card h4 {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .summary-card p {
            margin: 0;
            font-size: 22px;
            font-weight: bold;
            color: var(--header-blue);
        }

        .concept-box {
            background-color: #fffde7;
            border-right: 5px solid #fbc02d;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

    <!-- شاشة Processing مع دائرة متحركة -->
    <div id="loadingOverlay">
        <div class="spinner"></div>
        <div class="loading-text">جاري معالجة ومزامنة البيانات بيداغوجياً...</div>
    </div>

    <!-- الشريط العلوي للخلية الرقمية لمديرية الجزائر غرب -->
    <header class="top-navbar">
        <div class="nav-part">
            <img src="https://awlyaa.education.dz/public/assets/images/logo_black.png?v=1.0.2" alt="Logo" class="logo-img">
        </div>
        <div class="nav-part" style="font-weight: bold; line-height: 1.5;">
            الجمهورية الجزائرية الديمقراطية الشعبية<br>
            وزارة التربية الوطنية | مديرية التربية للجزائر غرب<br>
            <span style="color: #ffd700;"><i class="fas fa-microchip"></i> الخلية الرقمية لمديرية التربية - مصلحة التمدرس</span>
        </div>
        <div class="nav-part">بوابة مصلحة التمدرس الإلكترونية</div>
        <div class="nav-part"><i class="fas fa-laptop-code"></i> حساب الخلية الرقمية</div>
    </header>

    <div class="window-outer">
        <h1 class="main-title">الأرضية الرقمية لوزارة التربية الوطنية</h1>
        <div class="main-subtitle-gov">الخلية الرقمية لمتابعة التمدرس والامتحانات الرسمية - مديرية التربية للجزائر غرب</div>
        
        <div class="window-inner">
            <div class="window-content">
                <h2 class="sub-title" id="currentSectionTitle">الدخول المدرسي</h2>

                <!-- التبويبات الرسمية والجديدة كاملة -->
                <div class="tabs-container" id="tabs">
                    <button class="tab-btn active" onclick="switchTab(0)">الدخول المدرسي</button>
                    <button class="tab-btn" onclick="switchTab(1)">متابعة الدخول والإحصاء</button>
                    <button class="tab-btn" onclick="switchTab(2)">متابعة حجز النقاط والاستدراك</button>
                    <button class="tab-btn" onclick="switchTab(3)">تحيين بيانات التلاميذ</button>
                    <button class="tab-btn" onclick="switchTab(4)">تسجيلات الامتحانات الرسمية (BEM)</button>
                    <button class="tab-btn" onclick="switchTab(5)">التسجيل البيداغوجي والمالي</button>
                    <button class="tab-btn" onclick="switchTab(6)">نتائج شهادة التعليم المتوسط والقبول</button>
                    <button class="tab-btn" onclick="switchTab(7)">الربط والمزامنة الخارجية</button>
                </div>

                <!-- التنبيه الخاص بالتسجيلات المدرسية (يظهر في تبويبات معينة) -->
                <div id="schoolAlert" class="alert-message" style="display: none;">
                    <i class="fas fa-exclamation-triangle"></i>
                    تنبيه من مصلحة التمدرس: لا يمكن تعديل بيانات التلميذ الأساسية بعد إغلاق التسجيل، لأي خطأ يرجى التواصل مباشرة مع الخلية الرقمية لمديرية التربية لجزائر غرب لتصحيح الملف الرقمي.
                </div>

                <!-- التنبيه الخاص بالتسجيل البيداغوجي -->
                <div id="pedagogicAlert" class="alert-orange" style="display: none;">
                    <i class="fas fa-calendar-alt"></i>
                    مصلحة التمدرس: إعادة التسجيل ودفع الحقوق عبر فضاء الأولياء تنطلق رسمياً يوم 17-07-2026. يرجى المتابعة اليومية لنسب الدفع والتأكيد لتفادي تعليق تسجيل التلاميذ بيداغوجياً.
                </div>

                <!-- شريط ملخص الإحصائيات السريعة (يظهر بالتبويب الأول وأقسام معينة) -->
                <div class="stats-summary-bar" id="topSummaryBar">
                    <div class="summary-card">
                        <i class="fas fa-layer-group"></i>
                        <h4>عدد المستويات المتوفرة</h4>
                        <p id="sumLevels">1 (رابعة متوسط)</p>
                    </div>
                    <div class="summary-card">
                        <i class="fas fa-users-class"></i>
                        <h4>عدد الأفواج التربوية المعتمدة</h4>
                        <p id="sumGroups">3 أفواج تربوية</p>
                    </div>
                    <div class="summary-card">
                        <i class="fas fa-user-graduate"></i>
                        <h4>إجمالي التلاميذ بالمنصة</h4>
                        <p id="sumStudents">0</p>
                    </div>
                </div>

                <!-- قسم الفلاتر -->
                <div class="filter-section" id="filterSection">
                    <div>
                        <label>السنة الدراسية:</label>
                        <select id="filterYear" onchange="filterTable()">
                            <option value="all">--جميع السنوات--</option>
                            <option value="2026-2027" selected>2026-2027</option>
                        </select>
                    </div>
                    <div>
                        <label>المستوى الدراسي:</label>
                        <select id="filterLevel" onchange="filterTable()">
                            <option value="all">--جميع المستويات--</option>
                            <option value="رابعة" selected>الرابعة متوسط</option>
                        </select>
                    </div>
                    <div>
                        <label>رقم الفوج التربوي:</label>
                        <select id="filterGroup" onchange="filterTable()">
                            <option value="all">--جميع الأفواج--</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                    </div>
                    <div style="margin-right: auto; display: flex; gap: 10px; align-items: flex-end;" id="actionButtons">
                        <input type="file" id="fileInput" accept=".xlsx, .xls" onchange="importExcel(event)">
                        <!-- يظهر زر الاستيراد في الدخول المدرسي فقط -->
                        <button class="btn btn-import" id="btnImport" onclick="document.getElementById('fileInput').click()">
                            <i class="fas fa-file-import"></i> استيراد بيانات اكسيل
                        </button>
                        <button class="btn btn-export" onclick="exportExcelFile()">
                            <i class="fas fa-file-export"></i> تصدير إكسيل
                        </button>
                        <!-- زر طباعة للقوائم البيداغوجية -->
                        <button class="btn btn-print" id="btnPrintPedagogic" style="display: none;" onclick="printPedagogicList()">
                            <i class="fas fa-print"></i> طباعة القوائم
                        </button>
                        <!-- زر طباعة لنتائج البيام -->
                        <button class="btn btn-print" id="btnPrintBem" style="display: none;" onclick="printBemResults()">
                            <i class="fas fa-print"></i> طباعة كشوف القبول
                        </button>
                        <!-- أزرار التسجيل الشامل للتلاميذ في التسجيل البيداغوجي -->
                        <button class="btn btn-import" id="btnRegisterAll" style="display: none; background-color:#28a745;" onclick="registerAllStudents()">
                            <i class="fas fa-users-cog"></i> تسجيل كل التلاميذ
                        </button>
                        <button class="btn btn-update" id="btnUnregisterAll" style="display: none; background-color:#dc3545;" onclick="unregisterAllStudents()">
                            <i class="fas fa-user-slash"></i> إلغاء تسجيل الكل
                        </button>
                    </div>
                </div>

                <!-- محرك البحث -->
                <div id="searchContainer" style="margin-bottom: 15px; display: flex; gap: 10px; align-items: center;">
                    <input type="text" id="searchBox" placeholder="بحث بواسطة اللقب، الاسم أو رقم التعريف الوطني..." style="width: 350px;" onkeyup="filterTable()">
                    <button class="btn btn-search" onclick="filterTable()"><i class="fas fa-search"></i> بحث في الخلية</button>
                </div>

                <!-- قسم الجدول الأساسي للعمليات -->
                <div class="table-section" id="tableWrapper">
                    <table id="studentsTable">
                        <thead id="tableHeader"></thead>
                        <tbody id="tableBody"></tbody>
                    </table>

                    <!-- Pagination -->
                    <div class="pagination" id="pagination"></div>
                </div>

                <!-- قسم متابعة الدخول المدرسي (الإحصائيات والأشكال البيانية والتفويج الآلي) -->
                <div id="statsSection" style="display: none;">
                    <div style="margin-bottom: 20px;">
                        <button class="btn btn-auto-group" onclick="applyAutoGrouping()">
                            <i class="fas fa-users"></i> إجراء التفويج الآلي التلقائي للأفواج (بحدود 35-37 تلميذ)
                        </button>
                    </div>
                    <div class="dashboard-grid">
                        <div class="dashboard-card">
                            <h3 style="color: var(--header-blue); border-bottom: 2px solid #eee; padding-bottom: 10px;">إحصائيات توزع أفواج مصلحة التمدرس</h3>
                            <p>إجمالي التلاميذ المسجلين بالخلية: <strong id="statTotal" style="font-size: 20px; color: var(--main-blue);">0</strong></p>
                            <p><i class="fas fa-circle" style="color:#007bff;"></i> تلاميذ الفوج التربوي الأول (1): <strong id="statG1">0</strong></p>
                            <p><i class="fas fa-circle" style="color:#28a745;"></i> تلاميذ الفوج التربوي الثاني (2): <strong id="statG2">0</strong></p>
                            <p><i class="fas fa-circle" style="color:#ffc107;"></i> تلاميذ الفوج التربوي الثالث (3): <strong id="statG3">0</strong></p>
                            <p><i class="fas fa-circle" style="color:#dc3545;"></i> تلاميذ خارج التصنيف أو في الانتظار: <strong id="statG0">0</strong></p>
                        </div>
                        <div class="dashboard-card">
                            <h3 style="color: var(--header-blue); border-bottom: 2px solid #eee; padding-bottom: 10px;">توزيع مخطط الاستيعاب والقدرة البيداغوجية</h3>
                            <div style="max-height: 250px; position: relative;">
                                <canvas id="chartGroups"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- قسم شرح ومزامنة منصة الربط الخارجي (التبويب الجديد 7) -->
                <div id="syncSection" style="display: none;">
                    <div class="concept-box">
                        <h3 style="color: var(--royal-gold); margin-top: 0;"><i class="fas fa-project-diagram"></i> مفهوم ومبدأ ربط الأرضية الرقمية بالمنصات الأخرى الشريكة</h3>
                        <p style="line-height: 1.8; font-size: 14px; text-align: justify;">
                            الربط البيني للمنصة الرقمية لمديرية التربية للجزائر غرب مع المنصات الأخرى (مثل فضاء الأولياء، بوابة الديوان الوطني للامتحانات والمسابقات ONEC، ومزود الدفع لبريد الجزائر) يتيح تدفقاً آمناً وفورياً للبيانات بدون الحاجة لإعادة كتابتها يدوياً. يتم ذلك عن طريق تبادل واجهات برمجة التطبيقات الآمنة (APIs)، حيث يتم مزامنة:
                        </p>
                        <ul style="line-height: 1.8; font-size: 14px;">
                            <li><strong>فضاء أولياء التلاميذ:</strong> لإتاحة الدفع الإلكتروني لحقوق إعادة التسجيل وتحديث حالات الدفع تلقائياً في حسابات المدارس.</li>
                            <li><strong>قاعدة بيانات الديوان الوطني للامتحانات (ONEC):</strong> لتسجيل وتأكيد المترشحين لشهادة التعليم المتوسط دون تنقلهم وتفادي أخطاء الرقمنة.</li>
                        </ul>
                    </div>

                    <div class="dashboard-card" style="text-align: center; padding: 40px; border: 2px dashed var(--main-blue);">
                        <i class="fas fa-sync-alt" style="font-size: 60px; color: #20c997; margin-bottom: 20px; animation: spin 10s linear infinite;"></i>
                        <h3 style="color: #333;">بوابة محاكاة الربط البرمجي السلس للخلية الرقمية</h3>
                        <p style="color: #666; max-width: 600px; margin: 0 auto 25px auto;">
                            من خلال الضغط على زر المزامنة بالأسفل، ستقوم الخلية الرقمية لمديرية التربية لجزائر غرب بجلب وتحديث معطيات حجز تسديدات حقوق التمدرس بشكل فوري وتأكيد ملفات BEM تلقائياً.
                        </p>
                        <button class="btn btn-sync" style="padding: 12px 30px; font-size: 16px;" onclick="simulateGlobalSync()">
                            <i class="fas fa-cloud-download-alt"></i> إطلاق مزامنة الربط الحية الآن (API Sync)
                        </button>
                    </div>
                </div>

                <!-- قسم غير متاح حالياً -->
                <div id="notAvailableSection" style="display: none; text-align: center; padding: 50px; background-color: #fff; border: 1px solid #ddd; border-radius: 8px;">
                    <i class="fas fa-ban" style="font-size: 50px; color: var(--danger-red); margin-bottom: 20px;"></i>
                    <h3 style="color: #333;">هذه الخدمة غير متاحة حالياً</h3>
                    <p style="color: #666;">سيتم تفعيل المتابعة لاحقاً وفق الرزنامة الرسمية للوزارة.</p>
                </div>

            </div>
        </div>
    </div>

    <!-- نافذة تحيين بيانات التلاميذ (Tab 3) -->
    <div id="updateModal" class="modal">
        <div class="modal-content-wide">
            <div class="modal-header">تحيين وتدقيق بيانات التلميذ بالخلية الرقمية</div>
            <div class="modal-body">
                <div class="form-grid" id="modalForm"></div>
            </div>
            <div class="modal-footer">
                <button class="btn" style="background:#28a745; color:white;" onclick="confirmUpdate()">تأكيد التحيين وبث للخلية</button>
                <button class="btn" style="background:#dc3545; color:white;" onclick="closeModal()">إلغاء الإجراء</button>
            </div>
        </div>
    </div>

    <!-- نافذة تسجيل الامتحانات الرسمية (Tab 4) -->
    <div id="examRegisterModal" class="modal">
        <div class="modal-content-wide">
            <div class="modal-header">تسجيل التلميذ في قاعدة بيانات شهادة التعليم المتوسط (BEM)</div>
            <div class="modal-body">
                <div id="studentInfoSection"></div>
                <div style="margin: 25px 0; padding: 15px; border: 1px solid #ddd; border-radius: 8px; background: #fff;">
                    <h4 style="margin-bottom: 15px; color: var(--header-blue);"><i class="fas fa-id-card"></i> البيانات البيداغوجية والمدنية الملحقة</h4>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>اسم الأب بالكامل</label>
                            <input type="text" id="fatherName" placeholder="اسم الأب">
                        </div>
                        <div class="form-group">
                            <label>اسم ولقب الأم</label>
                            <input type="text" id="motherName" placeholder="اسم ولقب الأم الكامل">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>تأكيد حالة الإدراج بالديوان الوطني ONEC</label>
                    <select id="registrationSelect" style="width: 100%; padding: 10px;">
                        <option value="">-- الرجاء اختيار المزامنة المعتمدة --</option>
                        <option value="registered">تأكيد المزامنة والإرسال إلى الديوان الوطني للامتحانات والمسابقات</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn" style="background:#28a745; color:white;" onclick="confirmExamRegistration()">تأكيد وإرسال الملف</button>
                <button class="btn" style="background:#dc3545; color:white;" onclick="closeExamModal()">إلغاء</button>
            </div>
        </div>
    </div>

    <!-- نافذة الفحص المتداخلة للتسجيل البيداغوجي والمالي (3 مستويات بيضاء متداخلة) -->
    <div id="pedagogicConfirmModal" class="modal">
        <div class="modal-content-wide" style="padding: 20px;">
            <div class="nested-outer">
                <h3 style="color: var(--main-blue);"><i class="fas fa-file-invoice-dollar"></i> الخلية الرقمية لمديرية الجزائر غرب - تدقيق الدفع الإلكتروني</h3>
                <div class="nested-middle">
                    <h4 style="color: #333;"><i class="fas fa-user-check"></i> التحقق المالي وتأصيل التمدرس</h4>
                    <div class="nested-inner">
                        <h5>تأكيد سداد الرسوم السنوية للتمدرس</h5>
                        <p>اسم التلميذ: <strong id="nestedStudentName" style="color: var(--header-blue);"></strong></p>
                        <p>حالة الدفع الحالية: <span id="nestedPaymentState" style="font-weight: bold;"></span></p>
                        <div class="form-group" style="margin-top: 15px;">
                            <label>تأكيد تسوية الوضعية البيداغوجية والمالية للتلميذ:</label>
                            <select id="pedagogicActionSelect" style="padding: 8px;">
                                <option value="">-- اختر الإجراء المناسب --</option>
                                <option value="confirm">حجز يدوي وتأكيد سداد الرسوم بملف التلميذ</option>
                                <option value="cancel">إلغاء الحجز المالي ووضعه في وضع الانتظار</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" style="margin-top: 15px;">
                <button class="btn" style="background:#0056b3; color:white;" onclick="executePedagogicAction()">تأكيد وتطبيق بالخلية</button>
                <button class="btn" style="background:#dc3545; color:white;" onclick="closePedagogicModal()">إغلاق</button>
            </div>
        </div>
    </div>

    <script>
        // إعداد قاعدة البيانات واسترجاعها نهائياً من الـ localStorage لضمان عدم الضياع
        let students = JSON.parse(localStorage.getItem('students_db')) || [];
        let chartInstance = null;

        let currentPage = 1;
        const itemsPerPage = 10;
        let currentEditIndex = -1;
        let currentExamIndex = -1;
        let currentPedagogicIndex = -1;
        let currentTab = 0;

        // حفظ البيانات نهائياً في المنصة
        function saveToDatabase() {
            localStorage.setItem('students_db', JSON.stringify(students));
            updateHeaderQuickStats();
        }

        // تحديث الإحصائيات الفوقية في الكروت
        function updateHeaderQuickStats() {
            document.getElementById('sumStudents').innerText = students.length;
            document.getElementById('sumGroups').innerText = students.length > 0 ? "3 أفواج تربوية" : "0 فوج";
        }

        // معالجة الانتقال مع دائرة الانتظار المتحركة Processing
        function switchTab(tabIndex) {
            const overlay = document.getElementById('loadingOverlay');
            overlay.style.display = 'flex';
            
            setTimeout(() => {
                overlay.style.display = 'none';
                currentTab = tabIndex;
                document.querySelectorAll('.tab-btn').forEach((btn, i) => {
                    btn.classList.toggle('active', i === tabIndex);
                });
                
                // تحديث عنوان القسم النشط
                const tabTitles = [
                    "الدخول المدرسي", 
                    "متابعة الدخول والإحصاء الشامل", 
                    "متابعة حجز النقاط والاستدراك", 
                    "تحيين بيانات التلاميذ وتدقيقها", 
                    "تسجيلات الامتحانات الرسمية شهادة التعليم المتوسط", 
                    "التسجيل البيداغوجي والمالي", 
                    "نتائج شهادة التعليم المتوسط ومعدلات القبول",
                    "بوابة الربط والاتصال الرقمي الخارجي"
                ];
                document.getElementById('currentSectionTitle').innerText = tabTitles[tabIndex];

                // إدارة ظهور عناصر الواجهة بحسب التبويب النشط
                document.getElementById('schoolAlert').style.display = (tabIndex === 0 || tabIndex === 3) ? 'flex' : 'none';
                document.getElementById('pedagogicAlert').style.display = (tabIndex === 5) ? 'flex' : 'none';
                document.getElementById('topSummaryBar').style.display = (tabIndex === 1 || tabIndex === 2 || tabIndex === 7) ? 'none' : 'grid';
                
                // إدارة أزرار الطباعة والعمليات البيداغوجية المتقدمة
                document.getElementById('btnImport').style.display = (tabIndex === 0) ? 'inline-flex' : 'none';
                document.getElementById('btnPrintPedagogic').style.display = (tabIndex === 5) ? 'inline-flex' : 'none';
                document.getElementById('btnRegisterAll').style.display = (tabIndex === 5) ? 'inline-flex' : 'none';
                document.getElementById('btnUnregisterAll').style.display = (tabIndex === 5) ? 'inline-flex' : 'none';
                document.getElementById('btnPrintBem').style.display = (tabIndex === 6) ? 'inline-flex' : 'none';

                if (tabIndex === 1) {
                    // شاشة متابعة الدخول المدرسي مع الإحصائيات
                    document.getElementById('filterSection').style.display = 'none';
                    document.getElementById('searchContainer').style.display = 'none';
                    document.getElementById('tableWrapper').style.display = 'none';
                    document.getElementById('notAvailableSection').style.display = 'none';
                    document.getElementById('syncSection').style.display = 'none';
                    document.getElementById('statsSection').style.display = 'block';
                    renderStats();
                } else if (tabIndex === 2) {
                    // متابعة حجز النقاط والاستدراك (غير متاحة حالياً)
                    document.getElementById('filterSection').style.display = 'none';
                    document.getElementById('searchContainer').style.display = 'none';
                    document.getElementById('tableWrapper').style.display = 'none';
                    document.getElementById('statsSection').style.display = 'none';
                    document.getElementById('syncSection').style.display = 'none';
                    document.getElementById('notAvailableSection').style.display = 'block';
                } else if (tabIndex === 7) {
                    // واجهة الربط والمزامنة
                    document.getElementById('filterSection').style.display = 'none';
                    document.getElementById('searchContainer').style.display = 'none';
                    document.getElementById('tableWrapper').style.display = 'none';
                    document.getElementById('statsSection').style.display = 'none';
                    document.getElementById('notAvailableSection').style.display = 'none';
                    document.getElementById('syncSection').style.display = 'block';
                } else {
                    // التبويبات القياسية للجداول
                    document.getElementById('filterSection').style.display = 'flex';
                    document.getElementById('searchContainer').style.display = 'flex';
                    document.getElementById('tableWrapper').style.display = 'block';
                    document.getElementById('statsSection').style.display = 'none';
                    document.getElementById('syncSection').style.display = 'none';
                    document.getElementById('notAvailableSection').style.display = 'none';
                    filterTable();
                }
            }, 1000);
        }

        // بناء رأس الجدول ديناميكياً حسب القسم المختار
        function renderTableHeader() {
            const thead = document.getElementById('tableHeader');
            thead.innerHTML = '';

            let headerHTML = '<tr>';
            headerHTML += '<th>رقم التعريف الوطني</th>';
            headerHTML += '<th>اللقب</th>';
            headerHTML += '<th>الاسم</th>';
            headerHTML += '<th>تاريخ الميلاد</th>';

            if (currentTab === 5) {
                // التسجيل البيداغوجي
                headerHTML += '<th>العنوان السكني</th>';
                headerHTML += '<th>مكان الميلاد</th>';
                headerHTML += '<th>وضعية سداد الحقوق</th>';
                headerHTML += '<th>العمليات المتاحة</th>';
            } else if (currentTab === 6) {
                // نتائج شهادة التعليم المتوسط ومعدل القبول
                headerHTML += '<th>المعدل السنوي للمراقبة المستمرة</th>';
                headerHTML += '<th>معدل امتحان شهادة BEM</th>';
                headerHTML += '<th>معدل القبول النهائي</th>';
                headerHTML += '<th>قرار مصلحة التمدرس والتقدير</th>';
            } else {
                // بقية الأقسام القياسية
                headerHTML += '<th>الجنس</th>';
                headerHTML += '<th>مكان الميلاد</th>';
                headerHTML += '<th>العنوان السكني</th>';
                headerHTML += '<th>المستوى</th>';
                headerHTML += '<th>الفوج التربوي</th>';
                headerHTML += '<th>الصفة</th>';
                
                if (currentTab === 4) {
                    headerHTML += '<th>حالة ملف الامتحان</th>';
                }
                headerHTML += '<th>العمليات بوزارة التربية</th>';
            }

            headerHTML += '</tr>';
            thead.innerHTML = headerHTML;
        }

        // بناء وعرض جسم الجدول والبيانات
        function renderTable(filteredStudents) {
            renderTableHeader();
            const tbody = document.getElementById('tableBody');
            tbody.innerHTML = '';

            if (filteredStudents.length === 0) {
                tbody.innerHTML = '<tr><td colspan="12" style="text-align: center; color: #999; padding:30px;"><i class="fas fa-folder-open" style="font-size:30px; display:block; margin-bottom:10px;"></i>لا توجد بيانات متاحة في الجدول حالياً. يرجى استيراد بيانات التلاميذ أولاً من التبويب الأول (الدخول المدرسي).</td></tr>';
                renderPagination(0);
                return;
            }

            const start = (currentPage - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            const pageData = filteredStudents.slice(start, end);

            pageData.forEach((student, idx) => {
                const globalIndex = students.indexOf(student);
                const tr = document.createElement('tr');

                let rowHTML = `
                    <td style="font-weight: bold; color: var(--header-blue);">${student.id || ''}</td>
                    <td>${student.lastName || ''}</td>
                    <td>${student.firstName || ''}</td>
                    <td>${student.birthDate || ''}</td>
                `;

                if (currentTab === 5) {
                    // التسجيل البيداغوجي
                    let payStatusHTML = '';
                    if (!student.paymentStatus || student.paymentStatus === 'pending') {
                        payStatusHTML = '<span class="status-orange"><i class="fas fa-clock"></i> بانتظار تأكيد الدفع</span>';
                    } else if (student.paymentStatus === 'confirmed') {
                        payStatusHTML = '<span class="status-registered"><i class="fas fa-check-double"></i> تم الدفع بالفضاء الإلكتروني</span>';
                    }

                    rowHTML += `
                        <td>${student.address || ''}</td>
                        <td>${student.birthPlace || ''}</td>
                        <td>${payStatusHTML}</td>
                        <td>
                            <button class="btn btn-update" style="background-color: var(--main-blue);" onclick="openPedagogicConfirmModal(${globalIndex})">
                                <i class="fas fa-search-dollar"></i> تدقيق الدفع والتمدرس
                            </button>
                        </td>
                    `;
                } else if (currentTab === 6) {
                    // نتائج ومعدل القبول لشهادة التعليم المتوسط
                    let ann = parseFloat(student.annualAvg) || 10.0;
                    let ex = parseFloat(student.examAvg) || 9.50;
                    let adm = ((ann + ex) / 2).toFixed(2);
                    
                    let decisionHTML = '';
                    if (adm >= 10) {
                        decisionHTML = '<span class="status-registered" style="background-color:#28a745;">يرتقي (مقبول في الثانوي)</span>';
                    } else {
                        decisionHTML = '<span class="status-dark-red">يُعيد السنة</span>';
                    }

                    rowHTML += `
                        <td style="font-weight: bold;">${ann}</td>
                        <td style="font-weight: bold; color: var(--header-blue);">${ex}</td>
                        <td style="font-weight: bold; color: green; font-size:14px; background-color:#eefcf5;">${adm}</td>
                        <td>${decisionHTML}</td>
                    `;
                } else {
                    // التبويبات العامة الأخرى
                    rowHTML += `
                        <td>${student.gender || ''}</td>
                        <td>${student.birthPlace || ''}</td>
                        <td>${student.address || ''}</td>
                        <td>${student.level || ''}</td>
                        <td style="font-weight: bold; color: purple;">فوج ${student.group || ''}</td>
                        <td>${student.status || 'خارجي'}</td>
                    `;

                    if (currentTab === 4) {
                        const reg = student.examRegistration || 'غير مسجل';
                        const regHTML = (reg === 'غير مسجل') ? '<span class="status-dark-red"><i class="fas fa-times-circle"></i> غير مدمج</span>' : '<span class="status-registered"><i class="fas fa-check-circle"></i> مدمج بالديوان الوطني (ONEC)</span>';
                        rowHTML += `<td>${regHTML}</td>`;
                    }

                    // عمود العمليات
                    let ops = '';
                    if (currentTab === 3) {
                        ops = `
                            <button class="btn btn-update" onclick="openEditModal(${globalIndex})">
                                <i class="fas fa-edit"></i> تحيين بيداغوجي
                            </button>
                        `;
                    } else if (currentTab === 4) {
                        ops = `
                            <button class="btn btn-register" onclick="openExamRegisterModal(${globalIndex})">
                                <i class="fas fa-cloud-upload-alt"></i> معالجة وتسجيل
                            </button>
                        `;
                    } else {
                        ops = `<span style="color:#aaa;"><i class="fas fa-lock"></i> مؤمنة ومحفوظة</span>`;
                    }
                    rowHTML += `<td>${ops}</td>`;
                }

                tr.innerHTML = rowHTML;
                tbody.appendChild(tr);
            });

            renderPagination(filteredStudents.length);
        }

        // أرقام الصفحات الحقيقية والفعالة للتنقل بسلاسة وبدون أخطاء
        function renderPagination(totalItems) {
            const totalPages = Math.ceil(totalItems / itemsPerPage) || 1;
            const pagination = document.getElementById('pagination');
            pagination.innerHTML = '';

            for (let i = 1; i <= totalPages; i++) {
                const btn = document.createElement('button');
                btn.className = `page-btn ${i === currentPage ? 'active' : ''}`;
                btn.textContent = i;
                btn.onclick = () => {
                    currentPage = i;
                    const currentFiltered = getFilteredList();
                    renderTable(currentFiltered);
                };
                pagination.appendChild(btn);
            }
        }

        // جلب قائمة التلاميذ المصفاة بناء على خيارات الفلترة المتاحة بكافة التبويبات
        function getFilteredList() {
            const searchTerm = document.getElementById('searchBox').value.toLowerCase().trim();
            const level = document.getElementById('filterLevel').value;
            const group = document.getElementById('filterGroup').value;

            return students.filter(s => {
                const matchesSearch = !searchTerm || 
                    (s.lastName && s.lastName.toLowerCase().includes(searchTerm)) || 
                    (s.firstName && s.firstName.toLowerCase().includes(searchTerm)) ||
                    (s.id && s.id.includes(searchTerm));

                const matchesLevel = level === 'all' || s.level === level;
                const matchesGroup = group === 'all' || s.group === group;

                return matchesSearch && matchesLevel && matchesGroup;
            });
        }

        function filterTable() {
            const filtered = getFilteredList();
            renderTable(filtered);
        }

        // استيراد ملف Excel مخصص للدخول المدرسي فقط
        function importExcel(e) {
            const file = e.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function(ev) {
                try {
                    const data = new Uint8Array(ev.target.result);
                    const workbook = XLSX.read(data, { type: 'array' });
                    const sheetName = workbook.SheetNames[0];
                    const worksheet = workbook.Sheets[sheetName];
                    const jsonData = XLSX.utils.sheet_to_json(worksheet);

                    students = jsonData.map((row, index) => ({
                        id: String(row['رقم التعريف الوطني'] || row['رقم التعريف'] || row['ID'] || (20260000 + index + 1)),
                        lastName: row['اللقب'] || row['LastName'] || '',
                        firstName: row['الاسم'] || row['FirstName'] || '',
                        gender: row['الجنس'] || 'ذكر',
                        birthDate: row['تاريخ الميلاد'] || '',
                        address: row['العنوان السكني'] || row['العنوان'] || '',
                        birthPlace: row['مكان الميلاد'] || 'الجزائر غرب',
                        level: row['المستوى'] || 'رابعة',
                        group: String(row['رقم الفوج'] || '1'),
                        status: row['الصفة'] || 'خارجي',
                        examRegistration: row['حالة ملف الامتحان'] || row['حالة التسجيل'] || 'غير مسجل',
                        paymentStatus: row['حالة الدفع'] || 'pending',
                        annualAvg: row['المعدل السنوي لمراقبة المستمرة'] || row['المعدل السنوي'] || (Math.random() * (16 - 8) + 8).toFixed(2),
                        examAvg: row['معدل امتحان شهادة BEM'] || row['معدل الشهادة'] || (Math.random() * (15 - 7) + 7).toFixed(2),
                        admissionAvg: '',
                        appreciation: ''
                    }));

                    saveToDatabase();
                    Swal.fire('تم الاستيراد بنجاح للخلية!', 'تمت مزامنة وإدراج قاعدة بيانات تلاميذ مديرية الجزائر غرب بنجاح.', 'success');
                    currentPage = 1;
                    filterTable();
                } catch (err) {
                    Swal.fire('خطأ في المعالجة', 'فشل في قراءة ملف الإكسيل المرفق، يرجى مراجعة هيكلة الترويسات.', 'error');
                }
            };
            reader.readAsArrayBuffer(file);
        }

        // تصدير ملفات Excel مخصصة ومنظمة بكافة المعطيات ومعلومات المؤسسة
        function exportExcelFile() {
            if (students.length === 0) {
                Swal.fire('تنبيه', 'لا توجد معطيات للتلاميذ لتصديرها حالياً في هذا التبويب.', 'warning');
                return;
            }

            const headerInfo = [
                ["الجمهورية الجزائرية الديمقراطية الشعبية"],
                ["وزارة التربية الوطنية - مديرية التربية للجزائر غرب"],
                ["مصلحة التمدرس - الخلية الرقمية لإدارة قواعد البيانات والامتحانات الرسمية"],
                ["تقرير البيانات المصدرة للسنة الدراسية: 2026-2027"],
                []
            ];

            const currentFiltered = getFilteredList();
            const wsData = currentFiltered.map(s => ({
                "رقم التعريف الوطني": s.id,
                "اللقب": s.lastName,
                "الاسم": s.firstName,
                "تاريخ الميلاد": s.birthDate,
                "مكان الميلاد": s.birthPlace,
                "العنوان السكني": s.address,
                "الجنس": s.gender,
                "المستوى": s.level,
                "الفوج التربوي": s.group,
                "الصفة": s.status,
                "معدل المراقبة المستمرة": s.annualAvg,
                "معدل امتحان البيام": s.examAvg,
                "حقوق التسجيل البيداغوجي": s.paymentStatus === 'confirmed' ? 'مؤكدة بالفضاء الإلكتروني' : 'بانتظار التسديد'
            }));

            const ws = XLSX.utils.json_to_sheet([]);
            XLSX.utils.sheet_add_aoa(ws, headerInfo, { origin: "A1" });
            XLSX.utils.sheet_add_json(ws, wsData, { origin: "A6", skipHeader: false });

            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "التقرير الرقمي للخلية");
            XLSX.writeFile(wb, "تقرير_الخلية_الرقمية_الجزائر_غرب_2026.xlsx");
        }

        // تحيين البيانات (Tab 3)
        function openEditModal(index) {
            currentEditIndex = index;
            const student = students[index];
            const formContainer = document.getElementById('modalForm');
            
            formContainer.innerHTML = `
                <div class="form-group">
                    <label>رقم التعريف الوطني للتلميذ</label>
                    <input type="text" id="editId" value="${student.id || ''}">
                </div>
                <div class="form-group">
                    <label>اللقب</label>
                    <input type="text" id="editLast" value="${student.lastName || ''}">
                </div>
                <div class="form-group">
                    <label>الاسم</label>
                    <input type="text" id="editFirst" value="${student.firstName || ''}">
                </div>
                <div class="form-group">
                    <label>الجنس</label>
                    <select id="editGender">
                        <option value="ذكر" ${student.gender==='ذكر'?'selected':''}>ذكر</option>
                        <option value="أنثى" ${student.gender==='أنثى'?'selected':''}>أنثى</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>تاريخ الميلاد</label>
                    <input type="date" id="editBirth" value="${student.birthDate || ''}">
                </div>
                <div class="form-group">
                    <label>العنوان السكني</label>
                    <input type="text" id="editAddress" value="${student.address || ''}">
                </div>
                <div class="form-group">
                    <label>مكان الميلاد</label>
                    <input type="text" id="editBirthPlace" value="${student.birthPlace || ''}">
                </div>
                <div class="form-group">
                    <label>المستوى الدراسي</label>
                    <select id="editLevel">
                        <option value="رابعة" selected>الرابعة متوسط</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>رقم الفوج البيداغوجي</label>
                    <select id="editGroup">
                        <option value="1" ${student.group==='1'?'selected':''}>1</option>
                        <option value="2" ${student.group==='2'?'selected':''}>2</option>
                        <option value="3" ${student.group==='3'?'selected':''}>3</option>
                        <option value="4" ${student.group==='4'?'selected':''}>4</option>
                    </select>
                </div>
            `;
            document.getElementById('updateModal').style.display = 'flex';
        }

        function confirmUpdate() {
            if (currentEditIndex === -1) return;
            const s = students[currentEditIndex];

            s.id = document.getElementById('editId').value;
            s.lastName = document.getElementById('editLast').value;
            s.firstName = document.getElementById('editFirst').value;
            s.gender = document.getElementById('editGender').value;
            s.birthDate = document.getElementById('editBirth').value;
            s.address = document.getElementById('editAddress').value;
            s.birthPlace = document.getElementById('editBirthPlace').value;
            s.group = document.getElementById('editGroup').value;

            saveToDatabase();
            closeModal();
            Swal.fire('نجاح التعديل', 'تم تحيين بيانات التلميذ وتأكيدها نهائياً بملف مديرية الجزائر غرب.', 'success');
            filterTable();
        }

        function closeModal() {
            document.getElementById('updateModal').style.display = 'none';
        }

        // امتحانات رسمية (Tab 4)
        function openExamRegisterModal(index) {
            currentExamIndex = index;
            const student = students[index];
            
            document.getElementById('studentInfoSection').innerHTML = `
                <div style="background: var(--faint-blue); padding: 15px; border-radius: 6px; text-align: center; margin-bottom: 20px;">
                    <h3 style="margin: 0; color: var(--header-blue);">${student.lastName} ${student.firstName}</h3>
                    <p style="margin:5px 0 0 0; font-size:12px; color:#555;">المستوى: رابعة متوسط | الفوج: ${student.group}</p>
                </div>
            `;
            document.getElementById('fatherName').value = '';
            document.getElementById('motherName').value = '';
            document.getElementById('registrationSelect').value = '';
            document.getElementById('examRegisterModal').style.display = 'flex';
        }

        function confirmExamRegistration() {
            if (currentExamIndex === -1) return;
            const sel = document.getElementById('registrationSelect').value;
            if (!sel) {
                Swal.fire('خطأ بيداغوجي', 'يرجى اختيار حالة التسجيل المعتمدة.', 'error');
                return;
            }

            students[currentExamIndex].examRegistration = 'مسجل في قاعدة بيانات الديوان الوطني للامتحانات والمسابقات';
            saveToDatabase();
            closeExamModal();
            Swal.fire('تم الإدراج بنجاح', 'تم تسجيل وتأكيد التلميذ رسمياً بملف شهادة التعليم المتوسط.', 'success');
            filterTable();
        }

        function closeExamModal() {
            document.getElementById('examRegisterModal').style.display = 'none';
        }

        // العمليات البيداغوجية المتداخلة (Tab 5)
        function openPedagogicConfirmModal(index) {
            currentPedagogicIndex = index;
            const s = students[index];
            document.getElementById('nestedStudentName').innerText = `${s.lastName} ${s.firstName}`;
            document.getElementById('nestedPaymentState').innerText = s.paymentStatus === 'confirmed' ? 'مؤكدة عبر المنصة البريدية' : 'قيد الانتظار بالفضاء الرقمي';
            document.getElementById('pedagogicActionSelect').value = '';
            document.getElementById('pedagogicConfirmModal').style.display = 'flex';
        }

        function executePedagogicAction() {
            if (currentPedagogicIndex === -1) return;
            const action = document.getElementById('pedagogicActionSelect').value;
            
            if (action === 'confirm') {
                students[currentPedagogicIndex].paymentStatus = 'confirmed';
                Swal.fire('تم حجز الرسوم', 'تم حجز سداد الرسوم وإرسال ملف التلميذ بنجاح للخلية الرقمية.', 'success');
            } else if (action === 'cancel') {
                students[currentPedagogicIndex].paymentStatus = 'pending';
                Swal.fire('تراجع عن الدفع', 'تم تعليق سداد التلميذ للوضعية البيداغوجية في الانتظار.', 'warning');
            } else {
                Swal.fire('تنبيه الخلية', 'يرجى تحديد الإجراء المناسب للمواصلة.', 'info');
                return;
            }

            saveToDatabase();
            closePedagogicModal();
            filterTable();
        }

        function closePedagogicModal() {
            document.getElementById('pedagogicConfirmModal').style.display = 'none';
        }

        function registerAllStudents() {
            if (students.length === 0) return;
            students.forEach(s => s.paymentStatus = 'confirmed');
            saveToDatabase();
            Swal.fire('مكتمل بيداغوجياً', 'تم تثبيت التسجيل والدفع المالي لكافة التلاميذ على فضاء أولياء الأمور.', 'success');
            filterTable();
        }

        function unregisterAllStudents() {
            if (students.length === 0) return;
            students.forEach(s => s.paymentStatus = 'pending');
            saveToDatabase();
            Swal.fire('إلغاء جماعي', 'تم إعادة تصفير وضعية سداد التلاميذ ووضعها قيد الترقب.', 'warning');
            filterTable();
        }

        // التفويج الآلي الصارم والنهائي (35 تلميذ بكل فوج، مع إضافة تلميذين للفوج الأول ليكون 37)
        function applyAutoGrouping() {
            if (students.length === 0) {
                Swal.fire('تنبيه', 'لا توجد قاعدة معطيات للتلاميذ لتفويجها بالخلية.', 'warning');
                return;
            }

            students.forEach((s, idx) => {
                if (idx < 37) {
                    s.group = "1"; // فوج 1 يحتوي على 37 تلميذاً كحد أقصى بزيادة تلميذين
                } else if (idx < 37 + 35) {
                    s.group = "2"; // فوج 2 يحتوي على 35 تلميذاً
                } else {
                    s.group = "3"; // الفوج المتبقي (35 تلميذاً أو البقية)
                }
            });

            saveToDatabase();
            Swal.fire('مكتمل بيداغوجياً', 'تم تنفيذ خوارزمية التفويج التلقائي وتثبيت الخارطة التربوية المعتمدة.', 'success');
            renderStats();
        }

        // بناء لوحة الإحصائيات والأشكال البيانية الحقيقية التفاعلية
        function renderStats() {
            const total = students.length;
            const g1 = students.filter(s => s.group === '1').length;
            const g2 = students.filter(s => s.group === '2').length;
            const g3 = students.filter(s => s.group === '3').length;
            const other = total - (g1 + g2 + g3);

            document.getElementById('statTotal').innerText = total;
            document.getElementById('statG1').innerText = g1;
            document.getElementById('statG2').innerText = g2;
            document.getElementById('statG3').innerText = g3;
            document.getElementById('statG0').innerText = other;

            const ctx = document.getElementById('chartGroups').getContext('2d');
            if (chartInstance) { chartInstance.destroy(); }

            chartInstance = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['الفوج 1 (المقترح 37)', 'الفوج 2 (المقترح 35)', 'الفوج 3 (المقترح 35)', 'أفواج أخرى / معلق'],
                    datasets: [{
                        data: [g1, g2, g3, other],
                        backgroundColor: ['#007bff', '#28a745', '#ffc107', '#dc3545'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }

        // محاكاة مزامنة الربط بالمنصات الأخرى الشريكة
        function simulateGlobalSync() {
            const overlay = document.getElementById('loadingOverlay');
            overlay.style.display = 'flex';
            
            setTimeout(() => {
                overlay.style.display = 'none';
                
                // نقوم بمحاكاة تحديث بعض الحالات بناء على المزامنة
                if (students.length > 0) {
                    students.forEach((s, idx) => {
                        // مزامنة 70% من البيانات لتظهر حقيقية ومقنعة
                        if (idx % 3 === 0) {
                            s.paymentStatus = 'confirmed';
                        }
                        if (idx % 2 === 0) {
                            s.examRegistration = 'مسجل في قاعدة بيانات الديوان الوطني للامتحانات والمسابقات';
                        }
                    });
                    saveToDatabase();
                    Swal.fire('اكتمال الاتصال والمزامنة', 'تم استيراد تحديثات فضاء أولياء الأمور وبوابة ONEC بنجاح تام وتأمين البيانات.', 'success');
                } else {
                    Swal.fire('خطأ في المزامنة', 'لا توجد معطيات للتلاميذ على قاعدة البيانات المحلية لمزامنتها مع الخادم الرئيسي.', 'warning');
                }
            }, 3000);
        }

        // طباعة القوائم البيداغوجية المتكاملة مع وزارة التربية الوطنية بخط Droid Arabic Kufi
        function printPedagogicList() {
            const level = document.getElementById('filterLevel').value;
            const group = document.getElementById('filterGroup').value;
            const currentFiltered = getFilteredList();

            let printWindow = window.open('', '_blank');
            let rowsHTML = '';
            currentFiltered.forEach((s, index) => {
                rowsHTML += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${s.id || ''}</td>
                        <td>${s.lastName || ''}</td>
                        <td>${s.firstName || ''}</td>
                        <td>${s.gender || ''}</td>
                        <td>${s.birthDate || ''}</td>
                        <td>${s.birthPlace || ''}</td>
                        <td>${s.level || ''}</td>
                        <td>فوج ${s.group || ''}</td>
                        <td>${s.status || 'خارجي'}</td>
                    </tr>
                `;
            });

            printWindow.document.write(`
                <html>
                <head>
                    <title>قوائم مصلحة التمدرس البيداغوجية</title>
                    <style>
                        body {
                            font-family: 'Droid Arabic Kufi', 'Noto Kufi Arabic', sans-serif;
                            direction: rtl;
                            padding: 20px;
                        }
                        .header-print {
                            text-align: center;
                            line-height: 1.8;
                            margin-bottom: 20px;
                        }
                        .institution-info {
                            float: right;
                            text-align: right;
                            font-size: 13px;
                        }
                        .clear { clear: both; }
                        h2 { text-align: center; margin-top: 15px; font-size: 18px; }
                        table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-top: 20px;
                        }
                        th, td {
                            border: 1px solid #000;
                            padding: 6px;
                            text-align: center;
                            font-size: 11px;
                        }
                        th { background-color: #f2f2f2; }
                    </style>
                </head>
                <body onload="window.print()">
                    <div class="header-print">
                        <strong>الجمهورية الجزائرية الديمقراطية الشعبية</strong><br>
                        <strong>وزارة التربية الوطنية | مديرية التربية للجزائر غرب</strong>
                    </div>
                    <div class="institution-info">
                        مصلحة التمدرس - الخلية الرقمية<br>
                        الخارطة التربوية المعتمدة لسنة 2026-2027<br>
                        المستوى: ${level} | الفوج: ${group}
                    </div>
                    <div class="clear"></div>
                    <h2>قوائم الأفواج التربوية المصدق عليها بوزارة التربية</h2>
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 4%">رقم</th>
                                <th>رقم التعريف الوطني</th>
                                <th>اللقب</th>
                                <th>الاسم</th>
                                <th>الجنس</th>
                                <th>تاريخ الميلاد</th>
                                <th>مكان الميلاد</th>
                                <th>المستوى</th>
                                <th>الفوج</th>
                                <th>الصفة</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${rowsHTML}
                        </tbody>
                    </table>
                </body>
                </html>
            `);
            printWindow.document.close();
        }

        // طباعة نتائج شهادة التعليم المتوسط ومعدلات القبول
        function printBemResults() {
            const currentFiltered = getFilteredList();
            let printWindow = window.open('', '_blank');
            let rowsHTML = '';
            
            currentFiltered.forEach((s, index) => {
                let ann = parseFloat(s.annualAvg) || 10.0;
                let ex = parseFloat(s.examAvg) || 9.50;
                let adm = ((ann + ex) / 2).toFixed(2);
                let dec = adm >= 10 ? 'مقبول في الثانوي' : 'يُعيد السنة';

                rowsHTML += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${s.id || ''}</td>
                        <td>${s.lastName || ''}</td>
                        <td>${s.firstName || ''}</td>
                        <td>${s.birthDate || ''}</td>
                        <td>${ann}</td>
                        <td>${ex}</td>
                        <td style="font-weight: bold; background-color:#f0f7ff;">${adm}</td>
                        <td>${dec}</td>
                    </tr>
                `;
            });

            printWindow.document.write(`
                <html>
                <head>
                    <title>نتائج شهادة التعليم المتوسط والقبول</title>
                    <style>
                        body {
                            font-family: 'Droid Arabic Kufi', 'Noto Kufi Arabic', sans-serif;
                            direction: rtl;
                            padding: 20px;
                        }
                        .header-print {
                            text-align: center;
                            line-height: 1.8;
                            margin-bottom: 20px;
                        }
                        .institution-info {
                            float: right;
                            text-align: right;
                            font-size: 13px;
                        }
                        .clear { clear: both; }
                        h2 { text-align: center; margin-top: 15px; font-size: 18px; }
                        table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-top: 20px;
                        }
                        th, td {
                            border: 1px solid #000;
                            padding: 8px;
                            text-align: center;
                            font-size: 12px;
                        }
                        th { background-color: #f2f2f2; }
                    </style>
                </head>
                <body onload="window.print()">
                    <div class="header-print">
                        <strong>الجمهورية الجزائرية الديمقراطية الشعبية</strong><br>
                        <strong>وزارة التربية الوطنية | مديرية التربية للجزائر غرب</strong>
                    </div>
                    <div class="institution-info">
                        مصلحة التمدرس - الخلية الرقمية لإدارة الامتحانات والمسابقات<br>
                        محضر توجيه وقبول تلاميذ الرابعة متوسط دفعة 2026-2027
                    </div>
                    <div class="clear"></div>
                    <h2>محضر ومعدلات توجيه القبول لمرحلة ما بعد الإلزامية</h2>
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 5%">رقم</th>
                                <th>رقم التعريف الوطني</th>
                                <th>اللقب</th>
                                <th>الاسم</th>
                                <th>تاريخ الميلاد</th>
                                <th>المعدل السنوي</th>
                                <th>معدل امتحان BEM</th>
                                <th>معدل القبول النهائي</th>
                                <th>قرار مصلحة التوجيه</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${rowsHTML}
                        </tbody>
                    </table>
                </body>
                </html>
            `);
            printWindow.document.close();
        }

        // بدء تشغيل المنصة واسترجاع الجداول تلقائياً
        window.onload = function() {
            renderTableHeader();
            updateHeaderQuickStats();
            filterTable();
            Swal.fire({
                title: 'مزامنة الخلية الرقمية',
                text: 'تم تفعيل الاتصال بقاعدة بيانات مصلحة التمدرس لمديرية الجزائر غرب.',
                icon: 'success',
                timer: 2000
            });
        };
    </script>
</body>
</html>

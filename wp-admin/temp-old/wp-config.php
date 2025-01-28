<?php // Modified for Arabic by Rasheed Bydousi

/** إعدادات برنامج ووردبريس المعرب **/

// ** إعدادات قاعدة البيانات - ينمكنك الحصول على هذه المعلومات من مستضيفك ** //
/** اسم قاعدة بيانات ووردبريس */
define('DB_NAME', 'ibnsina_wp');

/** اسم المستخدم لقاعدة البيانات */
define('DB_USER', 'ibnsina_wp');

/** كلمة المرور لقاعدة البيانات */
define('DB_PASSWORD', '102030');

/** عنوان خادم قاعدة البيانات */
define('DB_HOST', 'localhost');

/** ترميز قاعدة البيانات */
define('DB_CHARSET', 'utf8');

/** مقارنات قاعدة الببيانات (Collation). 
* إذا كنت غير متأكّد أتركها فارغة */
define('DB_COLLATE', '');

/**#@+
 * مفاتيح الأمان.
 * استخدم الرابط التالي لتوليد المفتايح {@link https://api.wordpress.org/secret-key/1.1/salt/}
 * @منذ 2.6.0
 */
define('AUTH_KEY',         'b<,Syy|[P3oh+tEK+l6%`kLGic|chIN++H[iXD20D7xvYv.gY]U+[W6}sL=v!/hR');
define('SECURE_AUTH_KEY',  'Kd}}k.1Ow*qiU 77RPv~D+x%vlb*cNv7XKSZ{@6*EIiARxC#gQ8rVu=f02:cY+>n');
define('LOGGED_IN_KEY',    '!R{=I3=>7h(x d9=@~3|Gc[}:V,FL[T`i+u_4Onl,[dF~jXq^Ju5j@ r$4ErpHqV');
define('NONCE_KEY',        'd1w<+]fB=cxJS=9wt|RPkAr+4NZ||qIyHS|/uTVDqbQi4@-2J&V<A1/YLL6( {7_');
define('AUTH_SALT',        '&oc_Ba6LEh:WH9oI]!f*5E2X)JA9 DYQ$z3Gz#[S=^4x6T3~G&(}*UUo+#}hyM9X');
define('SECURE_AUTH_SALT', 'x=eTum@9fh*+K+:VRiy.TKp)C#r1+wVo8-/s0;5m%WGX-f0qa{D+XR-r1=U=T2_k');
define('LOGGED_IN_SALT',   'uwWs6*)Xd&@M?%:XZX dlGseZkwt}D6|!+L6R+cq)m?l|LH(bnSP6i%K6Zif{=E4');
define('NONCE_SALT',       'X/TQhg(d[/{`1j|6 gqZ(;eKO<?P^+a=`?B]{IDLYT=e<=_](?|*(BDiBhs-2aj|');


/**#@-*/

/**
 * بادئة الجداول في قاعدة البيانات.
 * تستطيع تركيب أكثر من مدونة على نفس قاعدة البيانات إذا أعطيت لكل قاعدة بادئة جداول مختلفة
 * استخدم فقط حروف, أرقام وخطوط سفلية!
 */
$table_prefix  = 'wp_';

/**
 * اللغة الافتراضية المستخدمة في هذه النسخة هي العربية
 * إذا أردت أن تكون لوحة التحكم في مدونتك بالانجليزية قم بحذف الحرفين أدناه وهي الحروف ar
 */
define('WPLANG', 'ar');

/**
 * للمطورين: نظام تشخيص الأخطاء
 * قم بتغيير flase إلى true لتمكين عرض الملاحظات أثناء التطوير
 */
define('WP_DEBUG', false);

/* هذا هو المطلوب! توقف عن التعديل. نتمنى لك التوفيق في موقعك! */

/** المسار المطلق لمجلد ووردبريس. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

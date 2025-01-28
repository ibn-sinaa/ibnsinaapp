<?php
define('WP_CACHE', true); // WP-Optimize Cache
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'ibnsina_website' );
/** MySQL database username */
define( 'DB_USER', 'ibnsina_website' );
/** MySQL database password */
define( 'DB_PASSWORD', 'Z8z.QC=9zoc6' );
/** MySQL hostname */
define( 'DB_HOST', 'localhost' );
/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );
/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
if ( !defined('WP_CLI') ) {
    define( 'WP_SITEURL', $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] );
    define( 'WP_HOME',    $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] );
}
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'jQfaVBY2W0YSmM0DHH7TP5RAuMvKvSixYjx5fZ0kpxyGjgCxK3Gd8rKWEYtM8rCJ' );
define( 'SECURE_AUTH_KEY',  'yWcahmKUzL0rEkDNmEctYX1VHWQYId7Q0U6LWVzmTEcmfsYol5JKzBMsu2L2IivK' );
define( 'LOGGED_IN_KEY',    'ogJfrIz4vQcfV36Rbj8feuv9Jl3F3VfIXdYLtDtPl76BKIWFJ4m703Rm9sZ1oMnC' );
define( 'NONCE_KEY',        'lTCCcEK3FyPrhCsqNAev4wlMrhmGbr4vqrFOB79LOZ40V3prSrAnoWHGLBH9O9NZ' );
define( 'AUTH_SALT',        'lmR4meMeSUQfoq5BShU93pMgjmshLax1iaAn9w1Phexgw8LkYGr7xcdmDb35VdBZ' );
define( 'SECURE_AUTH_SALT', 'AtO4HZz7vw2NGZyMxe1IciVBwwOvZwljtM85OsqRLlbWrj8byIvDYmfRtekjw6u2' );
define( 'LOGGED_IN_SALT',   'ZIup4Zy3pp9lPDc5tcS95y1ezn4CtSvfIOGmt5NugertslRCPZNyYkI9xrHwyzkb' );
define( 'NONCE_SALT',       'oYaKoYyXjjgSXhRmobJzXO7QBejKXeEaXQeD0Ha9L8H1smB57g7sYicqBE6IA40m' );
#define( 'WP_DEBUG', true );
/**#@-*/
/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wfxEz7mte_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );
define( 'DISALLOW_FILE_EDIT', true );
define( 'CONCATENATE_SCRIPTS', false );
/* That's all, stop editing! Happy publishing. */
/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
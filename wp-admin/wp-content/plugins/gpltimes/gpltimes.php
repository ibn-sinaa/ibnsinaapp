<?php
/**
 * @package  Gpltimes
 */

/*
Plugin Name: GPL Times
Plugin URI: https://www.gpltimes.com/
Description: GPL Times Auto Updater 
Version: 4.0.5
Author: GPL Times
Author URI: https://www.gpltimes.com/
License: GPLv2 or later
Text Domain: Gpltimes
*/

if ( ! defined( 'ABSPATH' ) ) {
    exit; // Exit if accessed directly
}

if (!defined('gpltimes_version')) {
    define('gpltimes_version', '4.0.5');
}

// Require once the Composer Autoload
if (file_exists(dirname(__FILE__) . '/vendor/autoload.php')) {
    require_once dirname(__FILE__) . '/vendor/autoload.php';
}

//added to fix the WP 6.4.3 issue
add_filter('unzip_file_use_ziparchive', '__return_false');

// The code that runs during plugin activation
require_once dirname(__FILE__) . '/inc/GplCron/gpl-wp-cron.php';
require_once dirname(__FILE__) . '/inc/Pages/gpltimes_notice.php';
require_once dirname(__FILE__) . '/inc/GplCron/gpl-auth-recheck.php';


function manual_enqueue_media_scripts() {
    if (isset($_GET['page']) && $_GET['page'] == 'gpltimes-whitelabel') {
        wp_enqueue_media();
    }
}
add_action('admin_enqueue_scripts', 'manual_enqueue_media_scripts');


function activate_gpltimes_plugin() {
    // Start output buffering
    ob_start();

    Inc\Base\Activate::activate();

    // Clear old cron jobs
    wp_clear_scheduled_hook('gpl_cron_hook');
    wp_clear_scheduled_hook('gpl_cron_hook_time');
    wp_clear_scheduled_hook('gpl_cron_hook_member');
    wp_clear_scheduled_hook('gpltimes_daily_notice_check');
    wp_clear_scheduled_hook('gpl_plugin_update_check');
    wp_clear_scheduled_hook('gpl_time_check');
    wp_clear_scheduled_hook('gpl_member_check');
    wp_clear_scheduled_hook('gpltimes_auth_recheck');

    // Plugin update check cron
    if (!wp_next_scheduled('gpl_plugin_update_check')) {
        wp_schedule_event(time(), 'hourly', 'gpl_plugin_update_check'); // Changed to 'hourly'
    }

    if (!wp_next_scheduled('gpltimes_auth_recheck')) {
        wp_schedule_event(time(), 'twicedaily', 'gpltimes_auth_recheck'); // 'twicedaily' is a default WP schedule
    }

    $gplplugslug = [];
    $gpldiffslug = [];
    $gplcron = '';
    update_option('gplpluginlistslug', $gplplugslug, true);
    update_option('gpldiffslug', $gpldiffslug, true);
    update_option('gplcrondata', $gplcron, true);
    update_option('gpltokenid', '', true);
    update_option('gplcheckedstatus', '0', true);
    update_option('gpltimes_beta_updates', '0', true);
    flush_rewrite_rules();

    // Clear any existing transients related to token validation
    delete_transient('valid_gpl_token');
    // End output buffering and discard any output
    ob_end_clean();
}

register_activation_hook(__FILE__, 'activate_gpltimes_plugin');


function deactivate_gpltimes_plugin() {
    // Clear the new cron jobs
    wp_clear_scheduled_hook('gpl_cron_hook');
    wp_clear_scheduled_hook('gpl_cron_hook_time');
    wp_clear_scheduled_hook('gpl_cron_hook_member');
    wp_clear_scheduled_hook('gpltimes_daily_notice_check');
    wp_clear_scheduled_hook('gpl_plugin_update_check');
    wp_clear_scheduled_hook('gpl_time_check');
    wp_clear_scheduled_hook('gpl_member_check');
    wp_clear_scheduled_hook('gpltimes_auth_recheck');

    // Remove the filters that manipulate the plugin updates
    remove_filter('site_transient_update_plugins', 'filter_plugin_updates');
    remove_filter('site_transient_update_plugins', 'filter_plugin_updates_main', 999999999);
    remove_filter('site_transient_update_plugins', 'disable_plugin_updates', 999999999);

    // Remove the filters that manipulate the theme updates
    remove_filter('site_transient_update_themes', 'disable_theme_updates', 999999999);


    Inc\Base\Deactivate::deactivate();

    $whitelabel_settings = get_option('gpltimes_whitelabel_settings', array());
    if (isset($whitelabel_settings['hide_settings'])) {
        unset($whitelabel_settings['hide_settings']);
        update_option('gpltimes_whitelabel_settings', $whitelabel_settings);
    }

    // Clean up transients (if needed)
    
    delete_option('gplstatus');
    delete_option('gpltokenid');
    delete_option('username');
    delete_option('password');
    delete_option('gpltimestatus');
    delete_option('packagereturndata');
    delete_option('gpltimes_last_update_check');
    delete_option('gpldiffslug');
    delete_option('gplpluginlistslug');
    delete_option('gplcrondata');
    delete_option('gplcheckedstatus');
    delete_option('current_time_gpl');
    delete_option('gplpluginactive');
    delete_option('gpltimes_whitelabel_settings');
    delete_option('gplcrondatamember');
    delete_option('gpluncheckdata');
    delete_option('gpltimes_beta_updates');
    delete_option('gpl_membership_details');

    // Clear any existing transients related to token validation
    delete_transient('valid_gpl_token');
    delete_transient('gpltimes_api_result');
    delete_transient('gpltimes_notice_data');
    delete_transient('gpltimes_daily_check_transient');
    delete_transient('gpltimes_daily_update_check');
    delete_transient('update_plugins');
    delete_transient('update_themes');
    set_site_transient('update_plugins', new \stdClass());
    set_site_transient('update_themes', new \stdClass());
}

register_deactivation_hook(__FILE__, 'deactivate_gpltimes_plugin');



function gpltimes_ensure_crons_exist() {
    wp_clear_scheduled_hook('gpl_cron_hook');
    wp_clear_scheduled_hook('gpl_cron_hook_time');
    wp_clear_scheduled_hook('gpl_cron_hook_member');
    wp_clear_scheduled_hook('gpl_time_check');
    wp_clear_scheduled_hook('gpl_member_check');
    wp_clear_scheduled_hook('gpltimes_daily_notice_check');
    wp_clear_scheduled_hook('gpl_plugin_update_check');
    wp_clear_scheduled_hook('gpltimes_auth_recheck');


    if (!wp_next_scheduled('gpl_plugin_update_check')) {
        wp_schedule_event(time(), 'hourly', 'gpl_plugin_update_check');
    }

    if (!wp_next_scheduled('gpltimes_auth_recheck')) {
        wp_schedule_event(time(), 'twicedaily', 'gpltimes_auth_recheck');
    }

}

function gpltimes_daily_check() {
    // Check if our transient is set, and if not, run the function
    if (false === get_transient('gpltimes_daily_check_transient')) {
        gpltimes_ensure_crons_exist();
        // Set our transient to expire in 24 hours
        set_transient('gpltimes_daily_check_transient', '1', DAY_IN_SECONDS);
    }
}
add_action('init', 'gpltimes_daily_check');




// Initialize all the core classes of the plugin
if (class_exists('Inc\\Init')) {
    Inc\Init::register_services();
}

$result_slug = get_option('gpldiffslug');

function filter_plugin_updates($value) {
    $result_slug = get_option('gpldiffslug');

    if ($result_slug != NULL) {
        foreach ($result_slug as $plugin) {
            if (isset($value->response[$plugin])) {
                unset($value->response[$plugin]);
            }
        }
    }

    return $value;
}

add_filter('automatic_updates_is_vcs_checkout', '__return_false', 1);
add_filter('site_transient_update_plugins', 'filter_plugin_updates');

$returndata = get_option('gplcrondata');
$token = esc_attr(get_option('gplstatus'));

if (empty($token)) {
    function filter_plugin_updates_main($value) {
        $returndata = get_option('gplcrondata');
        if ($returndata != NULL) {
            if (!empty($returndata)) {
                foreach ($returndata as $data) {
                    $returnslug = $data->slug;

                    if (isset($value->response[$returnslug])) {
                        unset($value->response[$returnslug]);
                    }
                }
            }
        }

        return $value;
    }

    add_filter('site_transient_update_plugins', 'filter_plugin_updates_main', 999999999);
    add_filter('site_transient_update_themes', 'filter_plugin_updates_main', 999999999);
}


function disable_plugin_updates($value) {
    $pluginsToDisable = get_option('gpluncheckdata');

    if (!empty($pluginsToDisable)) {
        if (isset($value) && is_object($value)) {
            foreach ($pluginsToDisable as $plugin) {
                if (isset($value->response[$plugin])) {
                    unset($value->response[$plugin]);
                }
            }
        }
    }

    return $value;
}

function disable_theme_updates($value) {
    $themesToDisable = get_option('gpluncheckdata');

    if (!empty($themesToDisable)) {
        if (isset($value) && is_object($value)) {
            foreach ($themesToDisable as $theme) {
                if (isset($value->response[$theme])) {
                    unset($value->response[$theme]);
                }
            }
        }
    }

    return $value;
}


$gplcheckedstatus = get_option('gplcheckedstatus');

if ($gplcheckedstatus == 1) {
    add_filter('site_transient_update_plugins', 'disable_plugin_updates', 999999999);
    add_filter('site_transient_update_themes', 'disable_theme_updates', 999999999); 
    update_option('gplcheckedstatus', '0', true);
}

add_action('admin_init', 'gpltimes_check_update_on_plugins_page');

function gpltimes_check_update_on_plugins_page() {

    // Check if user is admin and on the plugins page
    if (current_user_can('administrator') &&
    (strpos($_SERVER['REQUEST_URI'], 'plugins.php') !== false ||
     strpos($_SERVER['REQUEST_URI'], 'themes.php') !== false || 
     strpos($_SERVER['REQUEST_URI'], 'update-core.php') !== false)) {

        $last_check = get_option('gpltimes_last_update_check', 0);
        $current_time = time();

        // If more than 3 hours have passed since the last check
        if ($current_time - $last_check >= 3 * HOUR_IN_SECONDS) {

            // Call the update logic function
            gpl_cron_main_no_transient();

            // After the update check logic, set the timestamp
            update_option('gpltimes_last_update_check', $current_time);
        }
    }
}


add_action('admin_init', 'gpltimes_check_update_after_plugin_activation');

function gpltimes_check_update_after_plugin_activation() {
    if (isset($_GET['activate']) && $_GET['activate'] == 'true') {
        gpl_cron_main_no_transient();
    }
}

add_action('switch_theme', 'gpltimes_check_update_after_theme_activation');

function gpltimes_check_update_after_theme_activation() {
    gpl_cron_main_no_transient();
}


//WPMU Dev update disable
add_action('admin_init', 'clear_plugin_update_option');
function clear_plugin_update_option() {
    global $pagenow;
    if ($pagenow == 'plugins.php') {
        update_option('wdp_un_updates_available', '');
    }
}


function gpltimes_whitelabel_settings_page() {

    // Check if user has the necessary permissions
    if (!current_user_can('manage_options')) {
        wp_die(__('You do not have sufficient permissions to access this page.'));
    }

    // Handle form submission
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {

        // Save user inputs
        $whitelabel_settings = array(
            'name' => sanitize_text_field($_POST['gpltimes_name']),
            'description' => sanitize_text_field($_POST['gpltimes_description']),
            'author' => sanitize_text_field($_POST['gpltimes_author']),
            'author_url' => esc_url_raw($_POST['gpltimes_whitelabel_settings']['author_url']),
            'logo' => sanitize_text_field($_POST['gpltimes_logo']),
            'hide_settings' => isset($_POST['gpltimes_hide_settings']) ? 1 : 0,
            'disable_admin_notice' => isset($_POST['gpltimes_disable_admin_notice']) ? 1 : 0,
            'disable_all_admin_notices_except_updates' => isset($_POST['gpltimes_disable_all_admin_notices_except_updates']) ? 1 : 0,
            'disable_updates_visibility' => isset($_POST['gpltimes_disable_updates_visibility']) ? 1 : 0,

        );


        update_option('gpltimes_whitelabel_settings', $whitelabel_settings);

        if (1 === $whitelabel_settings['disable_admin_notice']) {
            delete_transient('gpltimes_notice_data');
        }
        
       // Redirect to avoid resubmission on page refresh
        echo '<script>window.location.href="'. admin_url('admin.php?page=gpltimes_plugin') . '";</script>';
        exit;

    }

    include(plugin_dir_path(__FILE__) . 'templates/whitelabel-settings.php');
}



add_filter('plugin_row_meta', 'gpltimes_modify_plugin_row_meta', 10, 4);

function gpltimes_modify_plugin_row_meta($plugin_meta, $plugin_file, $plugin_data, $status) {
    if ($plugin_file === 'gpltimes/gpltimes.php') {
        $whitelabel_settings = get_option('gpltimes_whitelabel_settings', array());

        // Modify Author link
        if (isset($whitelabel_settings['author']) && !empty($whitelabel_settings['author'])) {
            $author_url = isset($whitelabel_settings['author_url']) && !empty($whitelabel_settings['author_url']) ? esc_url($whitelabel_settings['author_url']) : $plugin_data['AuthorURI'];
            $plugin_meta[1] = '<a href="' . $author_url . '">' . esc_html($whitelabel_settings['author']) . '</a>';
        }

        // Modify "Visit plugin site" link
        if (isset($whitelabel_settings['author_url']) && !empty($whitelabel_settings['author_url'])) {
            $plugin_meta[2] = '<a href="' . esc_url($whitelabel_settings['author_url']) . '">' . __('Visit plugin site') . '</a>';
        }
    }
    return $plugin_meta;
}


// Filter to modify plugin details in the plugins array
add_filter('all_plugins', 'gpltimes_modify_all_plugins');

function gpltimes_modify_all_plugins($plugins) {
    $whitelabel_settings = get_option('gpltimes_whitelabel_settings', array());
    if (isset($plugins['gpltimes/gpltimes.php'])) {
        if (isset($whitelabel_settings['name']) && !empty($whitelabel_settings['name'])) {
            $plugins['gpltimes/gpltimes.php']['Name'] = $whitelabel_settings['name'];
        }
        if (isset($whitelabel_settings['description']) && !empty($whitelabel_settings['description'])) {
            $plugins['gpltimes/gpltimes.php']['Description'] = $whitelabel_settings['description'];
        }
        if (isset($whitelabel_settings['author']) && !empty($whitelabel_settings['author'])) {
            $plugins['gpltimes/gpltimes.php']['Author'] = $whitelabel_settings['author'];
            $plugins['gpltimes/gpltimes.php']['AuthorName'] = $whitelabel_settings['author'];
        }

        if (isset($whitelabel_settings['author_url']) && !empty($whitelabel_settings['author_url'])) {
            $plugins['gpltimes/gpltimes.php']['AuthorURI'] = $whitelabel_settings['author_url'];
        }
               

    }
    return $plugins;
}

add_action('admin_head', 'gpltimes_custom_logo_css');

function gpltimes_custom_logo_css() {
    $whitelabel_settings = get_option('gpltimes_whitelabel_settings', array());
    if (isset($whitelabel_settings['logo']) && !empty($whitelabel_settings['logo'])) {
        echo '<style>
            #adminmenu .toplevel_page_gpltimes_plugin div.wp-menu-image {
                background: url("' . esc_url($whitelabel_settings['logo']) . '") no-repeat center center !important;
                background-size: 16px 16px !important;
            }
            #adminmenu .toplevel_page_gpltimes_plugin div.wp-menu-image img {
                visibility: hidden;
            }
        </style>';
    }
}


function gpltimes_manage_admin_notices() {
    $whitelabel_settings = get_option('gpltimes_whitelabel_settings', array());

    if (isset($whitelabel_settings['disable_admin_notice']) && 1 === (int) $whitelabel_settings['disable_admin_notice']) {
        delete_transient('gpltimes_notice_data');
        remove_action('admin_notices', 'gpltimes_admin_notice');
    }

    if (isset($whitelabel_settings['disable_all_admin_notices_except_updates']) && 1 === (int) $whitelabel_settings['disable_all_admin_notices_except_updates']) {
        remove_all_actions('admin_notices');
        remove_all_actions('all_admin_notices');
    }
}
add_action('admin_init', 'gpltimes_manage_admin_notices');


function gpltimes_deactivation() {
    if (!current_user_can('manage_options')) {
        wp_send_json_error('Insufficient permissions');
        return;
    }

    // Add your deactivation logic here

    $user_id = get_option('gpltokenid');
    $domain = get_site_url();
    $parsedUrl = parse_url($domain, PHP_URL_HOST);
    $normalized_domain = preg_replace('/^www\./', '', $parsedUrl);


    // Send request to your endpoint to remove the data using a GET request
    $deactivation_url = 'https://www.gpltimes.com/deactivate_gplmanager.php?user_id=' . urlencode($user_id) . '&domain=' . urlencode($normalized_domain);
    $deactivation_response = wp_remote_get($deactivation_url, array('timeout' => 20));

    // Optional: Check the response from your endpoint
    if (is_wp_error($deactivation_response)) {
        wp_send_json_error('Error communicating with the deactivation endpoint');
        return;
    }


    // Example: Clearing options, resetting settings, etc.
    update_option('username', '');
    update_option('password', '');
    update_option('gplstatus', '');
    update_option('gplpluginactive', '0');
    delete_transient( 'update_plugins' );
    delete_site_transient( 'update_plugins' );
    delete_option('gpl_membership_details');

    delete_transient( 'update_themes' );
    delete_site_transient( 'update_themes' );

    // Send a success response
    wp_send_json_success('Deactivated successfully');
}

add_action('wp_ajax_gpltimes_deactivation', 'gpltimes_deactivation');



function gpltimes_activation() {
  // Ensure the user has the required capability to perform this action
  if (!current_user_can('manage_options')) {
    wp_send_json_error('Insufficient permissions');
    return;
  }

    $domain = get_site_url();
    $parsedUrl = parse_url($domain, PHP_URL_HOST);
    $normalized_domain = preg_replace('/^www\./', '', $parsedUrl);

    // URL of the remote API endpoint
    $remote_check_url = 'https://www.gpltimes.com/banned_domains.php?domain=' . urlencode($normalized_domain);
    $response = wp_remote_get($remote_check_url, array('timeout' => 20));

    if (is_wp_error($response) || wp_remote_retrieve_response_code($response) != 200) {
        wp_send_json_error('Failed to check domain status');
        return;
    }

    $body = wp_remote_retrieve_body($response);
    $result = json_decode($body, true);

    if (!empty($result['banned'])) {
        wp_send_json_error('Website banned. Visit www.gpltimes.com/domains/ to manage');
        return;
    }

  // Retrieve the username and password from the AJAX request
  $username = sanitize_text_field($_POST['username']);
  $password = sanitize_text_field($_POST['password']);

  // Save the username and password in the WordPress options
  update_option('username', $username);
  update_option('password', $password);

  // Initialize variables
  $token = '';
  $user_id = '';

  // Define the URL for JWT authentication
  $url = 'https://www.gpltimes.com/wp-json/jwt-auth/v1/token';

  // Prepare the request data
  $data = array(
    'username' => $username,
    'password' => $password,
  );

  $timeout = 30; // 30 seconds


  // Send the request to the authentication endpoint
  $response = wp_safe_remote_post($url, array(
    'body' => $data,
    'headers' => array('Content-Type' => 'application/x-www-form-urlencoded'),
    'timeout' => $timeout,

  ));

  // Check if the request was successful
  if (is_wp_error($response)) {
    wp_send_json_error('Failed to connect to the authentication server');
    return;
  }

  if (wp_remote_retrieve_response_code($response) !== 200) {
    wp_send_json_error('Invalid username or password');
    return;
  }

  // Decode the JSON response
  $body = wp_remote_retrieve_body($response);
  $decoded_body = json_decode($body, true);

// Extract the token and user ID
if (isset($decoded_body['token']) && !empty($decoded_body['token'])) {
    $token = $decoded_body['token'];
    $user_id = $decoded_body['id']; // Use 'id' instead of 'user_id'
} else {
    wp_send_json_error('Failed to retrieve the token');
    return;
}

  // Save the token and user ID in the WordPress options
  update_option('gplstatus', $token);
  update_option('gpltokenid', $user_id);

    $jwt_token = get_option('gplstatus');
    // URL of the remote API endpoint for adding the domain and user ID
    $add_domain_url = 'https://www.gpltimes.com/gplmanager.php?user_id=' . urlencode($user_id) . '&domain=' . urlencode($normalized_domain) . '&token=' . urlencode($jwt_token);
    $add_domain_response = wp_remote_get($add_domain_url, array('timeout' => 20));
    
    // Call the gpl_cron_main_no_transient function
  gpl_cron_main_no_transient();

// Return a success response
wp_send_json_success('Activated successfully');

}
add_action('wp_ajax_gpltimes_activation', 'gpltimes_activation');


function disable_thim_core_hooks() {
    // Ensure the class has been loaded by checking for its existence.
    if (class_exists('Thim_Auto_Upgrader') && method_exists('Thim_Auto_Upgrader', 'instance')) {
        // Get the singleton instance of the Thim_Auto_Upgrader
        $updater_instance = Thim_Auto_Upgrader::instance();

        // Remove filters and actions using the instance
        remove_filter('http_request_args', [$updater_instance, 'exclude_check_update_themes_from_wp_org'], 100);
        remove_filter('http_request_args', [$updater_instance, 'exclude_check_update_plugins_from_wp_org'], 100);
        remove_filter('pre_site_transient_update_themes', [$updater_instance, 'inject_update_themes'], 100);
        remove_filter('upgrader_package_options', [$updater_instance, 'pre_update_theme'], 100);
        remove_filter('pre_site_transient_update_plugins', [$updater_instance, 'inject_update_plugins'], 100);
        remove_filter('upgrader_package_options', [$updater_instance, 'pre_update_plugin'], 100);
        remove_filter('upgrader_pre_download', [$updater_instance, 'pre_filter_download_plugin'], 100, 3);
        remove_filter('pre_set_site_transient_update_plugins', [$updater_instance, 'add_check_update_plugins']);
        remove_action('thim_core_check_update_external_plugins', [$updater_instance, 'check_update_external_plugins']);
    }
}

add_action('plugins_loaded', 'disable_thim_core_hooks', 20); 

function delete_transients_on_plugin_update( $upgrader_object, $options ) {
    // Check if an update action is performed for plugins
    if ( $options['action'] == 'update' && $options['type'] == 'plugin' ) {
        // Check if the 'plugins' index exists in the $options array
        if ( isset($options['plugins']) && is_array($options['plugins']) ) {
            // Loop through the updated plugins
            foreach ( $options['plugins'] as $plugin ) {
                // Check if the updated plugin is the one we are targeting
                if ( $plugin == 'gpltimes/gpltimes.php' ) {
                    // Delete the transients
                    delete_transient( 'update_plugins' );
                    delete_site_transient( 'update_plugins' );

                    delete_transient( 'update_themes' );
                    delete_site_transient( 'update_themes' );
                    gpl_cron_main_no_transient();
                   
                }
            }
        }
    }
}

// Hook into the upgrader_process_complete action
add_action( 'upgrader_process_complete', 'delete_transients_on_plugin_update', 10, 2 );

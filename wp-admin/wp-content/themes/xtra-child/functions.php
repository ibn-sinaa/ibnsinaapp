<?php
// Exit if accessed directly
if ( !defined( 'ABSPATH' ) ) exit;

// BEGIN ENQUEUE PARENT ACTION
// AUTO GENERATED - Do not modify or remove comment markers above or below:

if ( !function_exists( 'chld_thm_cfg_locale_css' ) ):
    function chld_thm_cfg_locale_css( $uri ){
        if ( empty( $uri ) && is_rtl() && file_exists( get_template_directory() . '/rtl.css' ) )
            $uri = get_template_directory_uri() . '/rtl.css';
        return $uri;
    }
endif;
add_filter( 'locale_stylesheet_uri', 'chld_thm_cfg_locale_css' );
         
if ( !function_exists( 'child_theme_configurator_css' ) ):
    function child_theme_configurator_css() {
        wp_enqueue_style( 'chld_thm_cfg_child', trailingslashit( get_stylesheet_directory_uri() ) . 'style.css', array(  ) );
    }
endif;
add_action( 'wp_enqueue_scripts', 'child_theme_configurator_css', 20 );

// END ENQUEUE PARENT ACTION



function enqueue_font_awesome() {
    wp_enqueue_style('font-awesome', 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css');
}
add_action('wp_enqueue_scripts', 'enqueue_font_awesome');



/******/
// إزالة قائمة الترتيب الافتراضية (woocommerce-ordering)
remove_action('woocommerce_before_shop_loop', 'woocommerce_catalog_ordering', 30);

// إضافة قائمة الأقسام كـ Dropdown
add_action('woocommerce_before_shop_loop', 'display_category_dropdown', 30);

function display_category_dropdown() {
    $args = array(
        'taxonomy'   => 'product_cat',
        'orderby'    => 'name',
        'order'      => 'ASC',
        'hide_empty' => true,
    );

    $product_categories = get_terms($args);

    if (!empty($product_categories) && !is_wp_error($product_categories)) {
        echo '<div class="category-dropdown" style="margin-bottom: 20px;">';
        echo '<select id="category-select" onchange="location = this.value;" style="padding: 10px; font-size: 16px; width: 100%;">';
        echo '<option value="" disabled selected>اختر القسم</option>';

        foreach ($product_categories as $category) {
            echo '<option value="' . esc_url(get_term_link($category)) . '">' . esc_html($category->name) . '</option>';
        }

        echo '</select>';
        echo '</div>';
    }
}

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" <?php language_attributes(); ?>><head profile="http://gmpg.org/xfn/11">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php wp_title(''); ?><?php if(wp_title('', false)) { echo ' :'; } ?> <?php bloginfo('name'); ?></title>

<link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" media="screen" />
<link rel="alternate" type="application/rss+xml" title="<?php bloginfo('name'); ?> RSS Feed" href="<?php bloginfo('rss2_url'); ?>" />
<link rel="alternate" type="application/atom+xml" title="<?php bloginfo('name'); ?> Atom Feed" href="<?php bloginfo('atom_url'); ?>" />
<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>" />
<link rel="stylesheet" type="text/css" href="<?php bloginfo('template_directory'); ?>/glide.css" media="screen" />	
<link rel="stylesheet" type="text/css" href="<?php bloginfo('template_directory'); ?>/style1.css" media="screen" />	

     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
     
   <script type="text/javascript">

$(document).ready(function(){
         $('.button2 a,input,.allpost a,#newHD a,.img-logo').hover(function(){
		         $(this).stop().animate({'opacity' : '0.4'}, 500);
		 }, function(){$(this).stop().animate({'opacity' : '1'}, 500);});
});
    </script>
    
 


<?php wp_get_archives('type=monthly&format=link'); ?>
<?php //comments_popup_script(); // off by default ?>
<?php 
if ( is_singular() ) wp_enqueue_script( 'comment-reply' );
  ?>
</head>
<body>

<div id="bg-header">
<div style=" position:absolute; right:0px; top:0px; width:50%; background:url(<?php bloginfo('template_directory'); ?>/images/bg-headerR.jpg) repeat-x; height:167px;"></div>
<div id="header">

<div id="logo"><a href="index.php"><img border="0" src="<?php bloginfo('template_directory'); ?>/images/logo.png" /></a></div>
<div id="social">
<ul>
<li class="face"><a target="_blank" href="https://www.facebook.com/profile.php?id=100004905217539"></a></li>
<li class="tw"><a target="_blank" href="https://twitter.com/SinaaIbn"></a></li>
<li class="rss"><a target="_blank" href="<?php bloginfo('rss2_url'); ?>"></a></li>
</ul>
</div>

<div style="position:absolute; left:0px; top:34px;">
<a href="?page_id=10"><img border="0" src="<?php bloginfo('template_directory'); ?>/images/ads/ads.png" /></a>
</div>
  <div  style="position:absolute; bottom: 70px; right: 45px;"><?php include (TEMPLATEPATH . '/topad.php'); ?></div>
     
    <? include("slider.php"); ?>
    
    <DIV style="position:absolute; bottom:78px; left:46px; "><a href="?page_id=8"><img src="<?php bloginfo('template_directory'); ?>/images/pay.jpg" /></a></DIV>
</div>
</div>
<div id="casing">	
<div id="wrapper"> 

<div class="clear"></div>
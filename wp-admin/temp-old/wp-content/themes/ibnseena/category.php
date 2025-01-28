<?php get_header(); ?>

<div id="khaled">
<? get_sidebar(); ?>
 
<div id="bg-left">


<h4 class="pagetitle" style=" width:661px; float:right; border:1px solid #CCCCCC; padding-right:5px; padding-top:5px; padding-bottom:5px; margin: 0 auto; background:url(<?php bloginfo('stylesheet_directory')?>/images/hpage.png) repeat-x; height:20px;line-height:150%; color:#999; font-size:16px;"> <?php single_cat_title(); ?> </h4>

<?php if(have_posts()) : ?>



<?php while (have_posts()) : the_post(); ?>



<div class="posts">



<div style="float:left;  margin-top:7px; margin-left:10px;"><a href="<?php the_permalink() ?>"><? infra_thumb_image(); ?></a></div>





<div class="content-text">



 <h2><a style="color:#2b70e3;" href="<?php the_permalink() ?>" rel="bookmark" title="رابط ثابت لموضوع <?php the_title(); ?>"><?php the_title(); ?></a></h2>      



<p> <?php content_limit(get_the_content(),30); ?></p>



 </div>  </div>



<?php endwhile; ?>



<?php else:?>



<div class="post">



<h2>الصفحة غير موجودة</h2>



<p>يبدو أن الصفحة التي تبحث عنها ليست موجودة بعد الآن ، أنصحك بتصفح  <a href="">التصنيفات</a>, <a href="">الآرشيف</a>, أو بإمكانك إستعمال صندوق البحث أدناه</p>



<?php include(TEMPLATEPATH.'/searchform.php'); ?>



</div> <!-- .post -->



<?php endif; ?>



<?php



$prev_link = get_previous_posts_link('&laquo; المواضيع الجديدة');



$next_link = get_next_posts_link(' المواضيع السابقة &raquo;');



?>



<?php if ($prev_link || $next_link): ?>



<div class="navigation">



  <div class="alignleft"><?php next_posts_link(' المواضيع السابقة &raquo;') ?></div>



  <div class="alignright"><?php previous_posts_link('&laquo; المواضيع الجديدة') ?></div>



</div>



<?php endif; ?>

</div></div></div>
<div class="clear"></div>
<?php get_footer(); ?>
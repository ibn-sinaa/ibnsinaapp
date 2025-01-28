<?php get_header(); ?>




<div id="khaled" >
 
 
<? get_sidebar(); ?>
 
<div id="bg-left">
<?php if (have_posts()) : ?>

<?php while (have_posts()) : the_post(); ?>
<div <?php post_class('post') ?> id="post-<?php the_ID(); ?>" style="background:#fff;border-radius: 7px;-moz-border-radius: 7px;-webkit-border-radius:5px;">

<div style="padding:1px;">
<div id="titlee"><a href="<?php the_permalink() ?>"><? the_title();?></a></div>
</div>
         	     
<div class="met">
	<span class="author">كاتب الموضوع :  <?php the_author(); ?> / <?php the_time('F - j - Y'); ?> </span> 
</div>
 <div class="cover" style="padding-right:10px; background:#fff;">
<div class="entry">
<br />

<?php the_content('اقرأ بقية الدخول &raquo;'); ?>
    <div class="clear"></div>
<?php wp_link_pages(array('قبل' => '<p><strong>صفحات: </strong> ', 'بعد' => '</p>', 'التالي_او_رقم' => 'رقم')); ?>
</div>

      
<div style="text-align:right; font-family:Tahoma; font-size:12px;">
<div style="float:right; height:20px;"><div style="float:right; background:url(<?php bloginfo('template_directory'); ?>/images/view.png) no-repeat; width:16px; height:16px;"></div> &nbsp; <?php echo setPostViews(get_the_ID());?> <?php echo getPostViews(get_the_ID());?></div>

  <div style="float:none; height:20px; border-right:1px solid #ccc;"><div style="float:right; background:url(<?php bloginfo('template_directory'); ?>/images/comment.png) no-repeat; width:16px; height:16px; margin-right:7px; margin-left:3px;"></div> <?php comments_number(' 0 ',' 1  ',' % '); ?></div>

 </div>
 
</div>

<div style=" background:#fff; border-top: dashed 1px #ccc; padding:5px;">
 <a style=" float:left; margin-left:10px;" href="http://www.printfriendly.com/print?url=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/friend.png" alt="" /></a>
 
   
  <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script><!-- Place this tag where you want the +1 button to render --><g:plusone></g:plusone>  
 
  <a style="margin-right:6px;" href=" http://www.facebook.com/sharer/sharer.php?u=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/face.png" alt="" /></a>

  <a style="margin-right:6px;" href="https://twitter.com/intent/tweet?status=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/tw.png" alt="" /></a>

                          
</div>

<div class="singleinfo">

<span class="category"> &nbsp; &nbsp; &#1602;&#1587;&#1605;: 
<?php the_category(', '); ?> </span></div>

 
 
</span>
 

</div>

</div>


<?php comments_template(); ?>

	<?php endwhile; else: ?>

		<h1 class="title">&#1594;&#1610;&#1585; &#1605;&#1608;&#1580;&#1608;&#1583;</h1>
		<p>&#1593;&#1601;&#1608;&#1575; &#1575;&#1604;&#1585;&#1575;&#1576;&#1591; &#1575;&#1604;&#1605;&#1591;&#1604;&#1608;&#1576; &#1594;&#1610;&#1585; &#1605;&#1608;&#1580;&#1608;&#1583;</p>

<?php endif; ?>
</div>
</div></div>
<div class="clear"></div>
<?php get_footer(); ?>
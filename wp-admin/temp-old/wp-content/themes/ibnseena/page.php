<?php get_header(); ?>
<div id="khaled" style=" margin-top:10px; ">
 

<? get_sidebar(); ?>
 
<div id="bg-left">

<?php if (have_posts()) : ?>
<?php while (have_posts()) : the_post(); ?>
		
<div class="post" id="post-<?php the_ID(); ?>" style="background:#fff;border-radius: 7px;-moz-border-radius: 7px;-webkit-border-radius:5px; ">
<div style="padding:1px;">
<div id="titlee"><a href="<?php the_permalink() ?>"><? the_title();?></a></div>
</div>

<div class="cover" style="padding:10px;background:#fff;  ">
<div class="entry">
<?php the_content('Read the rest of this entry &raquo;'); ?>
		<div class="clear"></div>
 	
</div>

</div>


<?php endwhile; endif; ?>
 
</div></div></div></div>
<div class="clear"></div>
<?php get_footer(); ?>
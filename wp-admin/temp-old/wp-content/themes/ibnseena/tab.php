<div id="tabzine" class="widgets ">

<?php 
	$featucat = get_option('infra_gldcat');
	$my_query = new WP_Query('cat=1&showposts=6');	 
	if ($my_query->have_posts()) :
?>

<div class="tabdiv">
<?php while ($my_query->have_posts()) : $my_query->the_post();$do_not_duplicate = $post->ID; ?>	
	
<div id="feature-<?php the_ID(); ?>" >
<div class="inpost">
	<h3><a style="color:#FFFFFF;text-decoration:none;"  href="<?php the_permalink() ?>"><?php the_title(); ?>
     <?php echo setPostViews(get_the_ID());?>
    </a></h3>
</div>
<a href="<?php the_permalink() ?>"></a><?php infra_slider_image(); ?></div>
<?php endwhile; ?>
</div>

<?php endif; ?>

<?php if ($my_query->have_posts()) :?>

<ul id="tabnav" >
<?php while ($my_query->have_posts()) : $my_query->the_post();$do_not_duplicate = $post->ID; ?>	
    <li>
	<a class="listab" style="text-decoration:none;" href="#feature-<?php the_ID(); ?>">
	<h3 style="text-decoration:none;"><?php the_title(); ?></h3></a>
	</li> 
    
	<?php endwhile; ?>
</ul>
<?php endif; ?>
</div>
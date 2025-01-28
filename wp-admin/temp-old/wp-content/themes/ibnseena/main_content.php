<!--- <?
$data=$wpdb->get_results('SELECT * FROM alldownloads');
echo '<div id="khaled">';
?>
	
	<div style="width:492px;float:left; position:relative;">
	<div style=" position:absolute; left:1px; border-left:1px solid #ccc; min-height:220px; margin-top:32px;"></div>
	 
    <iframe width="420" height="315" src="//www.youtube.com/embed/tNEes-tlTIg" frameborder="0" allowfullscreen></iframe>
    
   <?  foreach($data as $da){ ?>

	 <div class="box">

	<div id="titlee"><a href="http://ozist.net/?alldownlad=<?=$da->id;?>">مميزات</a></div>
	<div style="border-top:1px solid #ccc; width:266px; height:1px; position:absolute; left:106px; top:20px;"></div>
	<div class="details">
		<?=$da->desc;?>
	</div>


	<div style="margin-top:20px;" class="button2">
	<div id="mores"><a href="http://ozist.net/?alldownlad=<?=$da->id;?>">


		     <?php if (isset($_GET[lang]) && $_GET[lang]=='en')
				   { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>Read More</span>";  ?>  
				<? }  else { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>لقراءة المزيد</span>";}  ?>
				 
	 </a> </div>

	 
	 
		<?php if (isset($_GET[lang]) && $_GET[lang]=='en')
		{ echo "<div id='downloadE'><a href='http://ozist.net/?alldownlad=".$da->id."'></a></div>";  ?>  
		<? }  else { echo "<div id='download'><a href='http://ozist.net/?alldownlad=".$da->id."'></a></div>";}  ?>

	  <a style=" float:left; margin-left:20px;" href=" http://www.facebook.com/sharer/sharer.php?u=http://ozist.net/?alldownlad=<?=$da->id;?>"><img src="http://ozist.net/wp-content/themes/ozo/images/facehome.png" alt=""></a>

	  <a style=" float:left; margin-left:10px;" href="https://twitter.com/intent/tweet?status=http://ozist.net/?alldownlad=<?=$da->id;?>"><img src="http://ozist.net/wp-content/themes/ozo/images/twitterhome.png" alt=""></a>
	</div>



	</div>

	</div>
	
<?

}
echo '</div><br clear="all"/>';
echo '<br clear="all"/>';
?>			
 !--->
 
<div id="khaled">
<div style="width:492px;float:left;">
<div style="width:448px; height:267px; float:left; ">
 
<iframe width="420" height="267" src="//www.youtube.com/embed/tNEes-tlTIg" frameborder="0" allowfullscreen></iframe> 

</div>
 <?php 
$my_query = new WP_Query('cat=4&showposts=1');
while ($my_query->have_posts()) : $my_query->the_post();$do_not_duplicate = $post->ID;
?>
<div class="box">

  
    
<div id="titlee"><a href="<?php the_permalink() ?>"><? the_title(); ?></a></div>
<div id="border-box"></div>
<div class="details"><?php the_content_rss('', TRUE, '', 50); ?></div>

<div style="margin-top:20px;" class="button2">
<div id="mores"><a href="<?php the_permalink() ?>">


     <?php if (isset($_GET[lang]) && $_GET[lang]=='en')
   { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>Read More</span>";  ?>  
<? }  else { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>لقراءة المزيد</span>";}  ?>
 
 </a> </div>
 
     <?php if (isset($_GET[lang]) && $_GET[lang]=='en')
   { echo "<div id='downloadE'><a href='https://www.regnow.com/softsell/nph-softsell.cgi?item=13272-10'></a></div>";  ?>  
<? }  else { echo "<div id='download'><a href='https://www.regnow.com/softsell/nph-softsell.cgi?item=13272-10'></a></div>";}  ?>
 
  <a style=" float:left; margin-left:20px;" href=" http://www.facebook.com/sharer/sharer.php?u=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/facehome.png" alt="" /></a>

  <a style=" float:left; margin-left:10px;"  href="https://twitter.com/intent/tweet?status=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/twitterhome.png" alt="" /></a>
  
    <a style=" float:left; margin-left:10px;"  href="#"><img src="<?php bloginfo(template_url); ?>/images/in.png" alt="" /></a>
</div>


</div>
<?php endwhile; ?>
</div>

<div style="width:492px;float:left; position:relative;">
<div style=" position:absolute; left:-20px; border-left:1px solid #ccc; min-height:220px; margin-top:32px;"></div>
<div style="background:url(<?php bloginfo('template_directory'); ?>/images/video1.png) no-repeat; width:476px; height:267px; float:right; margin-right:14px;"></div>

 <?php 
$my_query = new WP_Query('cat=5&showposts=1');
while ($my_query->have_posts()) : $my_query->the_post();$do_not_duplicate = $post->ID;
?>
<div class="box">

<div id="titlee"><a href="<?php the_permalink() ?>"><? the_title(); ?></a></div>
<div style="border-top:1px solid #ccc; width:266px; height:1px; position:absolute; left:106px; top:20px;"></div>
<div class="details"><?php the_content_rss('', TRUE, '', 50); ?></div>


<div style="margin-top:20px;" class="button2">
<div id="mores"><a href="<?php the_permalink() ?>">


     <?php if (isset($_GET[lang]) && $_GET[lang]=='en')
   { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>Read More</span>";  ?>  
<? }  else { echo "<span style='text-align:center; color:#fff; text-shadow:1px 1px #025588;'>لقراءة المزيد</span>";}  ?>
 
 </a> </div>

     <?php if (isset($_GET[lang]) && $_GET[lang]=='en')
   { echo "<div id='downloadE'><a href='http://ozist.net/l1.exe'></a></div>";  ?>  
<? }  else { echo "<div id='download'><a href='http://ozist.net/l1.exe'></a></div>";}  ?>
 

  <a style=" float:left; margin-left:20px;" href=" http://www.facebook.com/sharer/sharer.php?u=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/facehome.png" alt="" /></a>

  <a style=" float:left; margin-left:10px;"  href="https://twitter.com/intent/tweet?status=<?php the_permalink() ?>"><img src="<?php bloginfo(template_url); ?>/images/twitterhome.png" alt="" /></a>
  
      <a style=" float:left; margin-left:10px;"  href="#"><img src="<?php bloginfo(template_url); ?>/images/in.png" alt="" /></a>

</div>



</div>
<?php endwhile; ?>

</div>
 

<div class="clear"></div>

<br />
<br />
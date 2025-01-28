<?php get_header(); ?>

<div id="khaled" style="margin-top:10px;">
 
<? include("left.php");?>
                      
                      
                      
 <div style="float:right; width:674px; position:relative;"> 

<div class="shead" >
<div id="searchpage">
	<form method="get" id="searchpageform" action="<?php bloginfo('home'); ?>" >
	<input style="background:url(<?php bloginfo('template_directory'); ?>/images/btn-search11.png) repeat-x; height:22px; font-family:Tahoma; font-size:12px; width:649px; border:1px solid #888;" id="sform" class="rounded" type="text" name="s" onfocus="if(this.value=='search site'){this.value=''};" onblur="if(this.value==''){this.value='search site'};" value="<?php echo wp_specialchars($s, 1); ?>" />
	<input id="formsubmit" type="submit" value="بحث" />
	</form>
</div>


<p style="margin-top:12px; float:right; color:#000; text-align:right; padding-right:10px; font-family:Tahoma; font-size:12px;">
<?php
$mySearch =& new WP_Query("s=$s & showposts=-1");
$num = $mySearch->post_count;
echo $num.' نتائج البحث عن '; the_search_query();
?> في <?php  get_num_queries(); ?> <?php timer_stop(1); ?> ثواني.
</p>
</div>

<?php if (have_posts()) : ?>
<?php while (have_posts()) : the_post(); ?>
		
<div class="sbox" id="post-<?php the_ID(); ?>" style="background:#f3f3f3; border:1px solid #ccc; margin:7px;">

<h2 class="stitle"><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title(); ?>"><?php the_title(); ?></a></h2>

<p style="line-height:18px; paddding:5px 0px; color:#333;"><?php the_content_rss('more_link_text', TRUE, '', 30); ?></p>
<div class="clear"></div>

<span class="searchmeta" >كتبت بواسطة <?php the_author(); ?> on <?php the_time('F - j - Y'); ?> | <?php comments_popup_link('0 مشاركة', '1 مشاركة', '% مشاركات'); ?></span>	

</div>

	<?php endwhile; ?>

 <div id="navigation">
<?php
if(function_exists('wp_pagenavi')) { wp_pagenavi(); }
?>
</div>
	<?php else : ?>



<div class="cover" style="margin-right:10px; font-family:Tahoma; color:#333;">
<div class="entry">

<b>البحث - <?php the_search_query();?> - لم تطابق اي مداخلة.</b>

<p style="color:#333">اقتراحات:</p>
<ul style="list-style:none;">

   <li>  تأكد من كتابة الكلمات بشكل صحيح.</li>

   <li>  حاول كلمات مختلفة.</li>

   <li>  محاولة استخدام كلمات أكثر عمومية.</li>
</ul>
			
</div>
</div>
<?php endif; ?>


</div></div>
<div class="clear"></div>
<?php get_footer(); ?>
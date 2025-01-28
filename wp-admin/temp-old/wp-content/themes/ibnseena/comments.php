<?php
	if (!empty($_SERVER['SCRIPT_FILENAME']) && 'comments.php' == basename($_SERVER['SCRIPT_FILENAME']))
		die ('Please do not load this page directly. Thanks!');

	if ( post_password_required() ) { ?>
		<p class="nocomments">هذه المشاركة محمية بكلمة المرور . ادخل كلمة المرور لمشاهدة جميع التعليقات .</p>
<?php
		return;
	}
?>

<!-- You can start editing here. -->
<div id="commentsbox">
<?php if ( have_comments() ) : ?>
	<h3 id="comments"><?php comments_number('لا تعليق', 'تعليق واحد', '% تعليقات' );?> حتى الآن.</h3>



	<ol class="commentlist">
	<?php wp_list_comments(); ?>
	</ol>

	<div class="comment-nav">
		<div class="alignleft"><?php previous_comments_link() ?></div>
		<div class="alignright"><?php next_comments_link() ?></div>

	</div>
 <?php else : // this is displayed if there are no comments so far ?>
	<?php if ( comments_open() ) : ?>
		<!-- If comments are open, but there are no comments. -->

	 <?php else : // comments are closed ?>
		<!-- If comments are closed. -->
		<p class="nocomments">جميع التعليقات مغلقة</p>

	<?php endif; ?>
<?php endif; ?>


<?php if ( comments_open() ) : ?>
<div id="comment-form">
<div id="respond" class="rounded">

<h3><?php comment_form_title( 'أضف تعليق', 'أضف ردك يا %s' ); ?></h3>

<div class="cancel-comment-reply">
	<small><?php cancel_comment_reply_link(); ?></small>
</div>

<?php if ( get_option('comment_registration') && !is_user_logged_in() ) : ?>
<p>يجب عليك تسجيل الدخول <a href="<?php echo wp_login_url( get_permalink() ); ?>">logged in</a> حتى تستطيع الرد</p>
<?php else : ?>

<form action="<?php echo get_option('siteurl'); ?>/wp-comments-post.php" method="post" id="commentform">

<?php if ( is_user_logged_in() ) : ?>

<p> <a href="<?php echo get_option('siteurl'); ?>/wp-admin/profile.php"><?php echo $user_identity; ?></a>. <a href="<?php echo wp_logout_url(get_permalink()); ?>" title="Log out of this account">تسجيل الخروج&raquo;</a></p>

<?php else : ?>

<div style="width:214px; float:right; margin-top:18px;">
<table width="109%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="132"><small style="color:#FF0000;"> <?php if ($req) echo " "; ?></small>
<span style="color:#333; font-family:tahoma; padding-right:10px; font-size:12px; padding-bottom:10px;">الإسم (مطلوب)</span><input type="text" name="author" id="author"  onfocus="if(this.value=='الإسم (مطلوب)'){this.value=''};" onblur="if(this.value==''){this.value='الإسم (مطلوب)'};" value="<?php echo esc_attr($comment_author); ?>" size="22" tabindex="1" <?php if ($req) echo "aria-required='true'"; ?> />

<small style="color:#FF0000;"> <?php if ($req) echo "  "; ?></small>
<span style="color:#333; font-family:tahoma; padding-right:10px; font-size:12px; padding-bottom:10px;">البريد الإلكتروني (مطلوب)</span>
<input type="text" name="email"  onfocus="if(this.value=='البريد الإلكتروني (مطلوب)'){this.value=''};" onblur="if(this.value==''){this.value='البريد الإلكتروني (مطلوب)'};" id="email" value="<?php echo esc_attr($comment_author_email); ?>" size="22" tabindex="2" <?php if ($req) echo "aria-required='true'"; ?> />

<span style="color:#333; font-family:tahoma; padding-right:10px; font-size:12px; padding-bottom:10px;">الموقع (اختياري)</span>
<input type="text" name="url" id="url" onfocus="if(this.value=='الموقع (اختياري)'){this.value=''};" onblur="if(this.value==''){this.value='الموقع (اختياري)'};"  value="<?php echo esc_attr($comment_author_url); ?>" size="22" tabindex="3" />


<?php endif; ?></td>

    <td width="359" background="<?php bloginfo('template_directory'); ?>/images/btn/name-mail.png" style="width:246; height:162px; background-repeat:no-repeat;">&nbsp;</td>
  </tr>
</table>
</td>
</div>


<textarea name="comment" id="comment" cols="100%" rows="10" tabindex="4"></textarea><br />

<input name="submit" type="submit" id="commentSubmit" tabindex="5" value="أضف تعليق" />
<?php comment_id_fields(); ?>
<?php do_action('comment_form', $post->ID); ?>

</form>
<br />

<?php endif; // If registration required and not logged in ?>
</div>
</div>
<br />
<br />
<br />

<?php endif; // if you delete this the sky will fall on your head ?>
</div>
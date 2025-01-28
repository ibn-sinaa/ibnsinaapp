<?php /* ÊãÊ ÇáÈÑãÌÉ ÈæÇÓØÉ 
http://ahmed-elsayed.com */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'traidntright', 'footer.tpl', 6, false),)), $this); ?>

<div align="right"><?php echo $this->_tpl_vars['stylelist']; ?>
</div>
<div align="center">
  

<?php echo traidntright(array(), $this);?>

  

</div>

</td>
				<td width="28" class="right" valign="bottom" >
			<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_08.gif" width="28" height="10" alt="" />
			</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>

		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_10.gif" width="20" height="61" alt="" /></td>
				<td width="225">
				<img src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_11.gif" width="225" height="61" alt="" /></td>
				<td class="footer">&nbsp;<?php echo $this->_tpl_vars['lang']['copyright']; ?>
<?php echo $this->_tpl_vars['site']['site_name']; ?>
</td>
				<td width="213">
				<img  src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_14.gif" width="213" height="61" alt="" /></td>
				<td width="28">
				<img  src="<?php echo $this->_tpl_vars['stylepath']; ?>
/images/tr-up_15.gif" width="28" height="61" alt="" /></td>
			</tr>
</table>

</td>
</tr>
</table>
</body>
</html>
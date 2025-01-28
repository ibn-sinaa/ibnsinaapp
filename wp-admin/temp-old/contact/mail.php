<?php

global $board_config,$SMTPactive,$masteremail,$sitename;

$board_config['smtp_username'] = 'smtp@ibn-sinaa.net';
$board_config['smtp_password'] = '8Tg5cdldVDNvQCe2qiA3VDtCRQQAATvXS44qhUvyzXxnf9Qxcq';

function smtpmail($mail_to, $subject, $message, $headers = "")
{
	global $board_config;
	$message = preg_replace("/(?<!\r)\n/si", "\r\n", $message);
	if ($headers != "")
	{
		if(is_array($headers))
		{
			if(sizeof($headers) > 1)
			{
				$headers = join("\r\n", $headers);
			}
			else
			{
				$headers = $headers[0];
			}
		}
		$headers = chop($headers);
		$headers = preg_replace("/(?<!\r)\n/si", "\r\n", $headers);
		$header_array = explode("\r\n", $headers);
		@reset($header_array);
		$headers = "";
		while( list(, $header) = each($header_array) )
		{
			if( preg_match("/^cc:/si", $header) )
			{
				$cc = preg_replace("/^cc:(.*)/si", "\\1", $header);
			}
			else if( preg_match("/^bcc:/si", $header ))
			{
				$bcc = preg_replace("/^bcc:(.*)/si", "\\1", $header);
				$header = "";
			}
			$headers .= $header . "\r\n";
		}
		$headers = chop($headers);
		$cc = explode(",", $cc);
		$bcc = explode(",", $bcc);
	}
	if($mail_to == "")
	{
		echo "No email address specified<br>". __LINE__."<br>". __FILE__."<br>";
	}
	if(trim($subject) == "")
	{
		echo"No email Subject specified".__LINE__."".__FILE__."<br>";
	}
	if(trim($message) == "")
	{
		echo "Email message was blank".__LINE__."".__FILE__."<br>";
	}
	$mail_to_array = explode(",", $mail_to);

	if( !$socket = fsockopen("localhost", "26", $errno, $errstr, 20))
	{
		echo "Could not connect to smtp host : $errno : $errstr".__LINE__."".__FILE__."<br>";
	}
	if( !empty($board_config['smtp_username']) && !empty($board_config['smtp_password']) )
	{

		fputs($socket, "EHLO " . $board_config['smtp_host'] . "\r\n");
		fputs($socket, "AUTH LOGIN\r\n");
		fputs($socket, base64_encode($board_config['smtp_username']) . "\r\n");
		fputs($socket, base64_encode($board_config['smtp_password']) . "\r\n");
	} 
	else 
	{
		fputs($socket, "HELO " . $board_config['smtp_host'] . "\r\n");
	}

	fputs($socket, "MAIL FROM: <" . $board_config['board_email'] . ">\r\n");

	$to_header = "To: ";
	@reset( $mail_to_array );
	while( list( , $mail_to_address ) = each( $mail_to_array ))
	{
		$mail_to_address = trim($mail_to_address);
		if ( preg_match('/[^ ]+\@[^ ]+/', $mail_to_address) )
		{
			fputs( $socket, "RCPT TO: <$mail_to_address>\r\n" );
		}
		$to_header .= ( ( $mail_to_address != '' ) ? ', ' : '' ) . "<$mail_to_address>";
	}
	@reset( $bcc );
	while( list( , $bcc_address ) = each( $bcc ))
	{
		$bcc_address = trim( $bcc_address );
		if ( preg_match('/[^ ]+\@[^ ]+/', $bcc_address) )
		{
			fputs( $socket, "RCPT TO: <$bcc_address>\r\n" );
		}
	}
	@reset( $cc );
	while( list( , $cc_address ) = each( $cc ))
	{
		$cc_address = trim( $cc_address );
		if ( preg_match('/[^ ]+\@[^ ]+/', $cc_address) )
		{
			fputs($socket, "RCPT TO: <$cc_address>\r\n");
		}
	}
	fputs($socket, "DATA\r\n");
	fputs($socket, "Subject: $subject\r\n");
	fputs($socket, "$to_header\r\n");
	fputs($socket, "$headers\r\n\r\n");
	fputs($socket, "$message\r\n");
	fputs($socket, ".\r\n");
	fputs($socket, "QUIT\r\n");
	fclose($socket);

	return TRUE;
}


?>

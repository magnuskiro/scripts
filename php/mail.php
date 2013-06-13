<?php
if (isset($_REQUEST['email']))
//if "email" is filled out, send email
  {
  //send email
  $email = $_REQUEST['email'] ; 
  $subject = $_REQUEST['subject'] ;
  $message = $_REQUEST['message'] ;
  $headers = 'From: magnuskiro@coperio.no' . "\r\n" .
   'Reply-To: webmaster@example.com' . "\r\n" .
   'X-Mailer: PHP/' . phpversion();
  mail( $email,  $subject,$message,$headers );
  echo "Thank you for using our mail form";
  }
else

echo "
<html>
<body>
<form method='post' action='mail.php'>
  Email: <input name='email' type='text' /><br />
  Subject: <input name='subject' type='text' /><br />
  Message:<br />
  <textarea name='message' rows='15' cols='40'>
  </textarea><br />
  <input type='submit' />
  </form>
</body>
</html>
"; 

?>

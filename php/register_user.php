<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);

$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD,WALLET,VERIFY) VALUES ('$name','$email','$phone','$password','0','1')";

if ($conn->query($sqlinsert) === true)
{
    sendEmail($email);
    echo "success";
    
}
else
{
    echo "failed";
}

//http://justminedb.com/mobileminer/php/register_user.php?name=AidenLeong&email=aidenleong98@gmail.com&phone=0169324212&password=123456

function sendEmail($useremail) {
    $to      = $useremail; 
    $subject = 'Verification for Mobile Miner'; 
    $message = 'http://justminedb.com/mobileminer/php/verify.php?email='.$useremail; 
    $headers = 'From: noreply@mobileminer.com' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>


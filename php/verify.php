<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_GET['email'];

$sql = "UPDATE USER SET VERIFY = '1' WHERE EMAIL = '$email'";
$result = $conn->query($sql);

if ($row = $result > 0){
    echo "YOUR EMAIL HAS BEEN VERIFIED";
}

?>
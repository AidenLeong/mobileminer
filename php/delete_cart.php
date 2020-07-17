<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$id = $_POST['id'];


if (isset($_POST['id'])){
    $sqldelete = "DELETE FROM CART WHERE EMAIL = '$email' AND ID='$id'";
}else{
    $sqldelete = "DELETE FROM CART WHERE EMAIL = '$email'";
}
    
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>
<?php
error_reporting(0);
include_once ("dbconnect.php");
$id = $_POST['id'];
$name  = ucwords($_POST['name']);
$quantity  = $_POST['quantity'];
$price  = $_POST['price'];
$type  = $_POST['type'];
$os  = $_POST['os'];
$battery  = $_POST['battery'];
$sensor = $_POST['sensor'];
$memory  = $_POST['memory'];
$weight  = $_POST['weight'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = '../productimage/'.$id.'.jpg';

$sqlupdate = "UPDATE PRODUCT SET NAME = '$name', PRICE = '$price', QUANTITY= '$quantity',TYPE = '$type',OS = '$os',BATTERY = '$battery',SENSOR = '$sensor',MEMORY = '$memory',WEIGHT ='$weight' WHERE ID = '$id'";

if ($conn->query($sqlupdate) === true)
{
    //echo 'success';
    if (file_put_contents($path, $decoded_string)){
        echo 'success';
    }else{
        echo 'success';
    }
}
else
{
    echo "failed";
}    


?>
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
$sensor  = $_POST['sensor'];
$memory  = $_POST['memory'];
$weight  = $_POST['weight'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$path = '../productimage1/'.$id.'.jpg';

$sqlinsert = "INSERT INTO PRODUCT(ID,NAME,PRICE,QUANTITY,TYPE,OS,BATTERY,SENSOR,MEMORY,WEIGHT) VALUES ('$id','$name','$price','$quantity','$type','$os','$battery','$sensor','$memory','$weight')";
$sqlsearch = "SELECT * FROM PRODUCT WHERE ID='$id'";
$resultsearch = $conn->query($sqlsearch);
if ($resultsearch->num_rows > 0)
{
    echo 'found';
}else{
if ($conn->query($sqlinsert) === true)
{
    if (file_put_contents($path, $decoded_string)){
        echo 'success';
    }else{
        echo 'failed';
    }
}
else
{
    echo "failed";
}    
}


?>
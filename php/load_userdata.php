<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM USER WHERE EMAIL = '$email'";    
$money = 0;
 
$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    while ($row = $result->fetch_assoc())
    {
    $money = $money + $row["WALLET"];
    }
    echo  $money;
}
else
{
    echo "nodata";
}
?>
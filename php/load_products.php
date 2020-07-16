

<?php
error_reporting(0);
include_once ("dbconnect.php");
$type = $_POST['type'];
$name = $_POST['name'];
$id = $_POST['id'];

$sql = 'SELECT * FROM PRODUCT ORDER BY ID';

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["products"] = array();
    while ($row = $result->fetch_assoc())
    {
        $productlist = array();
        $productlist["id"] = $row["ID"];
        $productlist["name"] = $row["NAME"];
        $productlist["price"] = $row["PRICE"];
        $productlist["quantity"] = $row["QUANTITY"];
        $productlist["type"] = $row["TYPE"];
        $productlist["weight"] = $row["WEIGHT"];        
        $productlist["sensor"] = $row["SENSOR"];
        $productlist["os"] = $row["OS"];
        $productlist["battery"] = $row["BATTERY"];
        $productlist["memory"] = $row["MEMORY"];
        array_push($response["products"], $productlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>
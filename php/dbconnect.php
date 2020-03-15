<?php
$servername = "localhost";
$username   = "justmine_mobilemineradmin";
$password   = "vT-1gC8=2{j%";
$dbname     = "justmine_mobileminer";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
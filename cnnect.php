<?php
$servername = "localhost";
$username = "root";   // default in XAMPP
$password = "";       // blank by default
$dbname = "agriculture_db"; // replace with your DB name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully!";
?>
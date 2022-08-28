<?php
/* Local Database*/
$servername_db = "localhost";
$username_db = "leastpa1_root_20";
$password_db = "livestock123456789";
$dbname_db = "leastpa1_livestock_record";

// Create connection
$conn = mysqli_connect($servername_db, $username_db, $password_db, $dbname_db);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>
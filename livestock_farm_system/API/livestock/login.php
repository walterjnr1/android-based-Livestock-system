<?php 
require_once('connect.php'); 

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

$username = $_POST['txtusername'];
$password = $_POST['txtpassword'];

$sql = "SELECT * FROM users WHERE username='" .$username. "' and password = '".$password."'";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
// output data of each row
$row = mysqli_fetch_assoc($result);
echo json_encode("Success");
}else { 
echo json_encode("Wrong email and Password");
}

?>




<?php 
require_once('db.php'); 
require_once('connect.php'); 


header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: application/json');

$livestock_no = $_POST['txtlivestock_no'];
$status = "Healthy";

//Get current health status of livestock
$sql_get_status = "select * from livestock where livestock_no='$livestock_no'"; 
$result_get_status = $conn->query($sql_get_status);
$row_get_status = mysqli_fetch_array($result_get_status);
$status_current=$row_get_status['status'];

if ($status_current=="Sick"){
$status_update="Healthy";
}else if ($status_current=="Healthy"){
$status_update="Sick";
}

$stmt = $dbh->prepare("UPDATE livestock SET status = ? WHERE livestock_no = ?");
$result =  $stmt->execute([$status_update,$livestock_no]);

echo json_encode(['livestock_no' => $livestock_no,'success' => $result]);

?>

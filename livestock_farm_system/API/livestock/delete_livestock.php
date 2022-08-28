<?php 
require_once('db.php'); 

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: application/json');

$livestock_no = $_POST['txtlivestock_no'];
$stmt = $dbh->prepare("DELETE FROM livestock WHERE livestock_no = ?");
$result = $stmt->execute([$livestock_no]);

echo json_encode(['livestock_no' => $livestock_no,'success' => $result]);
?>
<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: application/json');
include "db.php";
header('Content-Type: application/json');

//$username=$_POST['txtusername'];
$username='walterjnr1';

$stmt = $dbh->prepare("SELECT count(*) FROM livestock where username=?");
$stmt->execute([$username]);
$count_livestock = $stmt->fetchColumn(); 
echo json_encode($count_livestock);
?>
<?php 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: application/json');
include "db.php";
header('Content-Type: application/json');

//$query=$_POST['txtsearch'];
$query=$_GET['query'];
$username=$_GET['username'];

$stmt = $dbh->prepare("SELECT * FROM livestock WHERE (`status` LIKE '%".$query."%') OR (`livestock_no` LIKE '%".$query."%') OR (`name` LIKE '%".$query."%') AND username='$username'");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($result);
?>
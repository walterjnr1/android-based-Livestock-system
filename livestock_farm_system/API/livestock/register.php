<?php 
require_once('connect.php'); 

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

$digits = 3;
$livestock_no=rand(pow(10, $digits-1), pow(10, $digits)-1);

$username = mysqli_real_escape_string($conn,$_POST['txtusername']);
$name = mysqli_real_escape_string($conn,$_POST['cmdname']);
$sex = mysqli_real_escape_string($conn,$_POST['cmdsex']);
$weight = mysqli_real_escape_string($conn,$_POST['txtweight']);
$status = mysqli_real_escape_string($conn,$_POST['cmdstatus']);

date_default_timezone_set('Africa/Lagos');
$current_date = date('Y-m-d');

$sql = "SELECT * FROM livestock where livestock_no='$livestock_no'";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
echo json_encode("livestock No Already Exist");
}else{
    
//save livestock details
$query = "INSERT into `livestock` (username,name,sex,livestock_no,weight,status,date_register)
VALUES ('$username','$name','$sex','$livestock_no','$weight','$status','$current_date')";
$result = mysqli_query($conn,$query);

if($result){

//Get phone Number
$sql_get = "select * from users where username='$username'"; 
$result_get = $conn->query($sql_get);
$row_get = mysqli_fetch_array($result_get);
$phone=$row_get['phone'];

//SEnd livestock code Via SMS
$username='rexrolex0@gmail.com';//Note: urlencodemust be added forusernameand 
$password='admin123';// passwordas encryption code for security purpose.

$sender='FARM-AUTHUR';
$message  = 'Your livestock Code for New '.$name.'  is :'.$livestock_no.'';
$api_url  = 'https://portal.nigeriabulksms.com/api/';

//Create the message data
$data = array('username'=>$username, 'password'=>$password, 'sender'=>$sender, 'message'=>$message, 'mobiles'=>$phone);
//URL encode the message data
$data = http_build_query($data);
//Send the message
$request = $api_url.'?'.$data;
$result  = file_get_contents($request);
$result  = json_decode($result);


  echo json_encode("success");
  } else {
  echo json_encode("Something Went Wrong");
  }
}
?>
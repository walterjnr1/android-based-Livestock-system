<?php 
// DB credentials.
define('DB_HOST','localhost');
define('DB_USER','leastpa1_root_20');
define('DB_PASS','livestock123456789');
define('DB_NAME','leastpa1_livestock_record');
// Establish database connection.
try
{
$dbh = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME,DB_USER, DB_PASS,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"));

}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}
?>
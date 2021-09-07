<?php
$connection = mysqli_connect("192.168.100.5","testuserDB","password","testDB") or die("Error " . mysqli_error($connection));
$sql = "SELECT id, str FROM testtable";
$result = mysqli_query($connection, $sql) or die("Error " . mysqli_error($connection));
$items = array();
while($row = mysqli_fetch_assoc($result))
{
$items[] = $row;
}
echo json_encode($items);
?>

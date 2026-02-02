<?php 
header("Access-Control-Allow-Origin: *");
$arr = null;
$conn = new mysqli("localhost", "root", "", "toko_merch_hmif");
if ($conn->connect_error) {
    $arr = ["result" => "error", "message" => "unable to connect"];
    echo json_encode($arr);
    exit;
}

$sql = "SELECT email,nama FROM users WHERE email=? AND password=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $_POST['email'], $_POST['password']);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows >0 ) {
    $data = $result->fetch_assoc();
    $arr = ["status" => "success", "data" => $data];
    echo json_encode($arr);
}else{
    $arr = ["status" => "error", "message" => "Invalid email or password"];
    echo json_encode($arr);
}



?>
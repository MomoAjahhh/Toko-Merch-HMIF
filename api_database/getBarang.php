<?php
header("Access-Control-Allow-Origin: *");
$arr = null;
$conn = new mysqli("localhost", "root", "", "toko_merch_hmif");
if ($conn->connect_error) {
    $arr = ["result" => "error", "message" => "unable to connect"];
    echo json_encode($arr);
    exit;
}

$sql = "SELECT * FROM barang";
$cari = "";
if (isset($_POST['cari']) && $_POST['cari'] != "") {
    $cari = "%" . $_POST['cari'] . "%";
    $sql .= " WHERE nama LIKE ?";
}

$stmt = $conn->prepare($sql);
if (!$stmt) {
    $arr = ["result" => "error", "message" => "SQL prepare error: " . $conn->error];
    echo json_encode($arr);
    exit;
}

if ($cari != "") {
    $stmt->bind_param("s", $cari);
}

$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result && $result->num_rows > 0) {
    while ($r = $result->fetch_assoc()) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "message" => "No data found or SQL error: $sql"];
}

echo json_encode($arr);
$stmt->close();
$conn->close();
?>
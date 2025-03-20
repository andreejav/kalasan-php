<?php
header('Content-Type: application/json');

// Require the database configuration file
require_once '../src/db/db_connection.php';

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch total tree species
$totalSpeciesResult = $conn->query("SELECT COUNT(DISTINCT address) AS total FROM tree_species");
$totalSpecies = $totalSpeciesResult->fetch_assoc()['total'];

// Fetch total uploads
$totalUploadsResult = $conn->query("SELECT COUNT(*) AS total FROM tree_species");
$totalUploads = $totalUploadsResult->fetch_assoc()['total'];

// Fetch tree species data
$treeSpeciesDataResult = $conn->query("SELECT address, date_time FROM tree_species");
$treeSpeciesData = [];

while ($row = $treeSpeciesDataResult->fetch_assoc()) {
    $treeSpeciesData[] = $row;
}

// Close connection
$conn->close();

// Return data as JSON
echo json_encode([
    'totalSpecies' => $totalSpecies,
    'totalUploads' => $totalUploads,
    'treeSpeciesData' => $treeSpeciesData
]);
?>

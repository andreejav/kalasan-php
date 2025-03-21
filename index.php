<?php
// Database connection details
include 'src/db/db_connection.php';

// Fetch data for dashboard stats
$contributor_count = 0;
$planted_tree = 0;
$chartData = [];

// Get contributor count
$sql = "SELECT COUNT(*) AS contributor_count FROM users";
$result = $conn->query($sql);
if ($result && $row = $result->fetch_assoc()) {
    $contributor_count = $row['contributor_count'];
}

// Get total planted trees
$sql = "SELECT COUNT(*) AS planted_tree FROM tree_planted";
$result = $conn->query($sql);
if ($result && $row = $result->fetch_assoc()) {
    $planted_tree = $row['planted_tree'];
}

// Fetch data for the chart (trees by category)
$sql = "SELECT category, COUNT(*) AS count FROM tree_planted GROUP BY category";
$result = $conn->query($sql);
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $chartData[] = $row;
    }
}

// Get endemic and indigenous tree count
$endemic_count = 0;
$indigenous_count = 0;

$sql = "SELECT category, COUNT(*) AS count FROM tree_planted WHERE category IN ('Endemic', 'Indigenous') GROUP BY category";
$result = $conn->query($sql);

if ($result) {
    while ($row = $result->fetch_assoc()) {
        if ($row['category'] === 'Endemic') {
            $endemic_count = $row['count'];
        }
        if ($row['category'] === 'Indigenous') {
            $indigenous_count = $row['count'];
        }
    }
}

$sql = "SELECT COUNT(*) AS Identifiers_count FROM admin";
$result = $conn->query($sql);
if ($result && $row = $result->fetch_assoc()) {
    $Identifiers_count = $row['Identifiers_count'];
}


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KALASAN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }
        .navbar {
            background-color: #4CAF50;
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #fff !important;
        }
        .navbar-nav .nav-link:hover {
            color: #d4edda !important;
        }
        
        .active{
        font-weight: bold;
    }
        #map {
            position: absolute;
            top: 56px; /* Adjust for navbar height */
            left: 0;
            right: 0;
            bottom: 0;
            height: calc(100vh - 56px);
            width: 100vw;
        }
    </style>
    <style>
    .floating-card {
        position: absolute;
        top: 150px;
        left: 20px;
        z-index: 1000;
        background: rgba(255, 255, 255, 0.9);
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        font-size: 16px;
        width: 250px;
    }

    .floating-card h5 {
        margin-bottom: 10px;
        color: #4CAF50;
    }
</style>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">KALASAN</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item active"><a class="nav-link" href="index.php">Home</a></li>
                <!--<li class="nav-item"><a class="nav-link" href="map.php">Map</a></li>-->
                <li class="nav-item"><a class="nav-link" href="about.php">About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.php">Contact</a></li>
                <li class="nav-item">
                    <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                </li>
            </ul>
        </div>
    </div>
</nav>

 <!-- Modal for Login -->
 <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Login</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
    <button class="btn btn-success w-100 mb-3" onclick="window.location.href='admin/index.php'">Kalasan Admin</button>
    <button class="btn btn-success w-100" onclick="window.location.href='user/index.php'">Kalasan Forest Ranger</button>
</div>


            
            <!-- Modal Footer with Flexbox for Centered Signup Text -->
            <div class="modal-footer d-flex justify-content-center w-100">
                <p class="signup-text m-0">Don't have an account? <a href="#">Sign up here</a></p>
            </div>
        </div>
    </div>
</div>

<div class="floating-card">
    <h5>Dashboard Overview</h5>
    <p><strong>Identifiers:</strong> <?php echo $Identifiers_count; ?></p>
    <p><strong>Contributors:</strong> <?php echo $contributor_count; ?></p>
    <hr>
    <p><strong>Planted Trees:</strong> <?php echo $planted_tree; ?></p>
    <p><strong>Endemic Trees:</strong> <?php echo $endemic_count; ?></p>
    <p><strong>Indigenous Trees:</strong> <?php echo $indigenous_count; ?></p>
</div>



  <!-- Map Content -->
  <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-body">
            <div id="map"></div> <!-- Map container -->
          </div>
        </div>
      </div>
    </div>
  </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Kalasan. All Rights Reserved.</p>
    </footer>


<!-- JS Files -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet.markercluster@1.3.0/dist/leaflet.markercluster.js"></script>
<!-- Leaflet and MarkerCluster CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.3.0/dist/MarkerCluster.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.3.0/dist/MarkerCluster.Default.css" />

<script>
document.addEventListener('DOMContentLoaded', function () {
// Step 1: Initialize the map
var map = L.map('map').setView([8.358062751051879, 124.86094951519246], 11); // Initial view

// Step 2: Add the tile layers (map backgrounds)
var satelliteLayer = L.tileLayer('https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png', {
attribution: '© OpenStreetMap contributors, Tiles by OSM France'
});

var osmLayer = L.tileLayer('https://tiles.stadiamaps.com/tiles/alidade_satellite/{z}/{x}/{y}{r}.jpg', {
attribution: '© OpenStreetMap contributors'
});

// Add OpenStreetMap layer by default
osmLayer.addTo(map);

// Step 3: Add a layer control to toggle between OSM and Satellite views
var baseLayers = {
"Street Map": satelliteLayer,
"Satellite View": osmLayer,
};

L.control.layers(baseLayers).addTo(map);

// Step 4: Initialize marker cluster group
var markers = L.markerClusterGroup();

// Step 5: Define the custom tree icon
var treeIcon = L.icon({
iconUrl: 'user/assets/img/Tag Icon.png',  // Replace with actual path
iconSize: [38, 38],  // Size of the icon
iconAnchor: [19, 38],  // Point of the icon that corresponds to the marker's location
popupAnchor: [0, -38]  // Point from which the popup should open relative to the iconAnchor
});

// Step 6: Fetch plant locations from the server
fetch('user/get_plant_data.php')
.then(response => response.json())
.then(data => {
  data.forEach(plant => {
    const species_name = plant.species_name;
    const lat = plant.latitude;
    const lon = plant.longitude;
    const address = plant.address; // Ensure consistency in field names
    const imageUrl = plant.image;
    const date_time = plant.date_time; // Capture date from EXIF metadata

   // Step 7: Add markers with custom icon to the marker cluster group
var marker = L.marker([lat, lon], { icon: treeIcon })
.bindPopup(`
<div class="col-4">
<img src="${plant.image_path}" alt="Plant Image" class="img-fluid" 
     style="width: 150px; height: auto; cursor: pointer;" 
     onclick="openFullscreen('${plant.image_path}')" 
     onerror="this.onerror=null; this.src='assets/img/default-plant.jpg';">
</div>
<strong>Species:</strong> ${species_name}<br>
<strong>Location:</strong> ${address}<br>
<strong>Date Captured:</strong> ${date_time}
`);


    markers.addLayer(marker); // Add each marker to the marker cluster group
  });

  // Add all markers to the map
  map.addLayer(markers);
})
.catch(error => console.error('Error fetching plant data:', error));
});

// Function to open image in full screen
function openFullscreen(imageSrc) {
// Create a new image element
var img = new Image();
img.src = imageSrc;
img.style.position = 'fixed';
img.style.top = '0';
img.style.left = '0';
img.style.width = '100%';
img.style.height = '100%';
img.style.objectFit = 'contain';
img.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
img.style.cursor = 'pointer';
img.style.zIndex = '9999';

// Add the image to the document body
document.body.appendChild(img);

// Close the image on click
img.onclick = function () {
document.body.removeChild(img);
};
}


</script>
<script>
const menuToggle = document.getElementById('menuToggle');
const sidebar = document.getElementById('sidebar');
const mainPanel = document.getElementById('mainPanel');

menuToggle.addEventListener('click', () => {
    sidebar.classList.toggle('expanded');
    mainPanel.classList.toggle('expanded');
});
</script>
</body>
<script src="assets/js/core/jquery.min.js"></script>
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<script src="assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script>
</html>
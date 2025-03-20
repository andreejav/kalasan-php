<?php
// Database connection details
include 'src/db/db_connection.php';

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch data for dashboard stats
$sql = "SELECT COUNT(*) AS contributor_count FROM users WHERE id IS NOT NULL";
$result = $conn->query($sql);
$contributor_count = ($result->num_rows > 0) ? $result->fetch_assoc()['contributor_count'] : 0;

$sql = "SELECT COUNT(*) AS planted_tree FROM tree_planted WHERE id IS NOT NULL";
$result = $conn->query($sql);
$planted_tree = ($result->num_rows > 0) ? $result->fetch_assoc()['planted_tree'] : 0;

// Fetch data for the chart (trees by category)
$sql = "SELECT category, COUNT(*) AS count FROM tree_planted GROUP BY category";
$result = $conn->query($sql);
$chartData = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $chartData[] = $row;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KALASAN</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for nature theme -->
    <style>
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
            margin-bottom: 60px; /* Space for the fixed footer */
        }
        .navbar {
            background-color: #4CAF50; /* Nature-inspired green */
        }
        
        .navbar-brand {
            color: #fff !important;
            font-weight: bold;
        }
        .navbar-nav .nav-link {
            color: #fff !important;
        }
        .navbar-nav .nav-link:hover {
            color: #d4edda !important; /* Light green on hover */
        }
        .hero-section {
            background-image: url('https://www.w3schools.com/w3images/forest.jpg'); /* Nature background */
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 3rem;
            font-weight: bold;
        }
        .hero-section p {
            font-size: 1.5rem;
            font-style: italic;
        }
        .footer {
            background-color: #2d6a4f; /* Dark green footer */
            color: #fff;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 10px 0;
            text-align: center;
            z-index: 9999;
        }
        .modal-header, .modal-footer {
            background-color: #4CAF50;
            color: white;
        }
        .signup-text {
            margin-top: 20px;
            color: #2d6a4f;
        }
        .signup-text a {
            text-decoration: none;
            font-weight: bold;
            color: #2d6a4f;
        }
        .signup-text a:hover {
            color: #3e8e41;
        }
        .active{
        font-weight: bold;
    }
    .card-category {
    font-weight: bold;
}

    </style>
</head>
<body>
    <!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <a class="navbar-brand" href="#">KALASAN</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.php">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="map.php">Map</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.php">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.php">Contact</a>
                </li>
                <li class="nav-item">
                    <!-- Login Button to trigger Modal -->
                    <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                </li>
            </ul>
        </div>
    </div>
</nav>

    <!-- Hero Section -->
    <section class="hero-section">
    <div class="container text-center">
        <h1>Welcome to Kalasan</h1>
        <p>Preserving nature, protecting resources, and sustaining life for future generations.</p>
    </div>
<br>
    <div class="container">
        <div class="row justify-content-center text-center" style="color:black;">
            <div class="col-lg-3 col-md-6">
                <div class="card card-stats">
                    <div class="card-body">
                        <p class="card-category" style="font-weight: bold;">Contributors</p>
                        <p class="card-title"><?php echo $contributor_count; ?></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card card-stats">
                    <div class="card-body">
                        <p class="card-category" style="font-weight: bold;">Planted Trees</p>
                        <p class="card-title"><?php echo $planted_tree; ?></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>





    <!-- Modal for Login -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Login</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
    <button class="btn btn-success w-100 mb-3" onclick="window.location.href='dev-kalasan/index.php'">Kalasan Admin</button>
    <button class="btn btn-success w-100" onclick="window.location.href='kalasan_mapping/index.php'">Kalasan Forest Ranger</button>
</div>


            
            <!-- Modal Footer with Flexbox for Centered Signup Text -->
            <div class="modal-footer d-flex justify-content-center w-100">
                <p class="signup-text m-0">Don't have an account? <a href="#">Sign up here</a></p>
            </div>
        </div>
    </div>
</div>


    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Kalasan. All Rights Reserved.</p>
    </footer>

    <!-- Bootstrap JS & Popper.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>

-- Create a temporary table to store predefined locations with accurate coordinates
CREATE TEMPORARY TABLE temp_locations (
    address VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    area_planted INT
);

-- Insert accurate latitude and longitude values for the specified locations
INSERT INTO temp_locations (address, latitude, longitude, area_planted) VALUES
('San Miguel & Lunocan, Manolo Fortich, Bukidnon', 8.382832, 124.844469, 8),
('Lingion, Manolo Fortich, Bukidnon', 8.425897, 124.897884, 6),
('Dicklum, Manolo Fortich, Bukidnon', 8.370144, 124.848220, 6),

('Kisolon, Sumilao, Bukidnon', 8.323726, 124.978881, 8),
('Impasugong, Bukidnon', 8.286940, 125.030104, 10),
('Cawayan, Impasugong, Bukidnon', 8.250407, 125.017407, 9),
('Impakibel, Santiago, Manolo Fortich, Bukidnon', 8.410158, 124.988005, 3);

-- Insert tree planting data into the tree_planted table with random distribution
-- Insert tree planting data into the tree_planted table with species based on location
INSERT INTO tree_planted (user_id, latitude, longitude, date_time, address, image_path, exif_data, validated, species_name, scientific_name, description, category, admin_id)
SELECT 
    8,  -- user_id (Adjust as needed)
    t.latitude + ((RAND() - 0.5) * 0.002),  -- Slight randomization for realistic planting locations
    t.longitude + ((RAND() - 0.5) * 0.002), 
    NOW(),
    t.address,
    'uploads/sample_image.jpg',
    NULL,
    0,
    CASE 
        WHEN t.address IN ('San Miguel & Lunocan, Manolo Fortich, Bukidnon', 
                           'Lingion, Manolo Fortich, Bukidnon', 
                           'Dicklum, Manolo Fortich, Bukidnon') 
        THEN 'Bagras'
        
        WHEN t.address IN ('Kisolon, Sumilao, Bukidnon') 
        THEN 'Falcata'
        
        WHEN t.address IN ('Impasugong, Bukidnon', 
                           'Cawayan, Impasugong, Bukidnon') 
        THEN 'Para Ruber'
        
        WHEN t.address IN ('Impakibel, Santiago, Manolo Fortich, Bukidnon') 
        THEN 'Falcata'
        
        ELSE 'Unknown' -- Default case
    END,
    CASE 
        WHEN t.address IN ('San Miguel & Lunocan, Manolo Fortich, Bukidnon', 
                           'Lingion, Manolo Fortich, Bukidnon', 
                           'Dicklum, Manolo Fortich, Bukidnon') 
        THEN 'Eucalyptus deglupta' 
        
        WHEN t.address IN ('Kisolon, Sumilao, Bukidnon', 'Impakibel, Santiago, Manolo Fortich, Bukidnon') 
        THEN 'Falcataria moluccana'
        
        WHEN t.address IN ('Impasugong, Bukidnon', 'Cawayan, Impasugong, Bukidnon') 
        THEN 'Hevea brasiliensis'
        
        ELSE 'Unknown'
    END,
    CASE 
        WHEN t.address IN ('San Miguel & Lunocan, Manolo Fortich, Bukidnon', 
                           'Lingion, Manolo Fortich, Bukidnon', 
                           'Dicklum, Manolo Fortich, Bukidnon') 
        THEN 'Commonly known as the rainbow eucalyptus, used in reforestation.'
        
        WHEN t.address IN ('Kisolon, Sumilao, Bukidnon', 'Impakibel, Santiago, Manolo Fortich, Bukidnon') 
        THEN 'Commonly known as Falcata, used in agroforestry and timber production.'
        
        WHEN t.address IN ('Impasugong, Bukidnon', 'Cawayan, Impasugong, Bukidnon') 
        THEN 'Commonly known as Para Rubber, used for latex production.'
        
        ELSE 'Unknown description'
    END,
    'Native',  -- Category (You can change if needed)
    3  -- admin_id (Adjust as needed)
FROM temp_locations t
CROSS JOIN (
    SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL 
    SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
    SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL
    SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL
    SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
) AS numbers
LIMIT 20; -- Adjust limit based on available seedlings

-- Get the range of inserted IDs
SET @min_tree_planted_id = (SELECT MIN(id) FROM tree_planted WHERE date_time = (SELECT MAX(date_time) FROM tree_planted));
SET @max_tree_planted_id = (SELECT MAX(id) FROM tree_planted WHERE date_time = (SELECT MAX(date_time) FROM tree_planted));

-- Insert into analytics table for monitoring planted trees
INSERT INTO analytics (tree_planted_id, total_count)
SELECT id, FLOOR(RAND() * 100) + 1 FROM tree_planted WHERE id BETWEEN @min_tree_planted_id AND @max_tree_planted_id;

-- Insert into reviews table for verification and comments
INSERT INTO reviews (tree_planted_id, review_by, status, comments)
SELECT id, 3, 'pending', 'Initial review required.' FROM tree_planted WHERE id BETWEEN @min_tree_planted_id AND @max_tree_planted_id;

-- Insert tree images for reference
INSERT INTO tree_images (tree_planted_id, image_path)
SELECT id, 'uploads/sample_image.jpg' FROM tree_planted WHERE id BETWEEN @min_tree_planted_id AND @max_tree_planted_id;

-- Drop the temporary table
DROP TEMPORARY TABLE temp_locations;

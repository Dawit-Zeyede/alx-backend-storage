-- Lists all bands with Glam rock as their main style, ranked by their longevity.
SELECT band_name, 
       CASE 
           WHEN split IS NULL THEN YEAR(CURRENT_DATE()) - formed
           ELSE split - formed
       END AS lifespan
FROM metal_bands
WHERE style IS NOT NULL AND LOCATE('Glam rock', style) > 0
ORDER BY lifespan DESC;

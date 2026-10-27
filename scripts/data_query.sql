USE SF_library;

SELECT 
	`Age Range` AS age_range,
	COUNT(*) AS total_activity_records,
    SUM(`Total Checkouts
checkout_total`) AS total_checkouts,
    SUM(`Total Renewals
renewal_total`) AS total_renewals
FROM staging_library_data
WHERE `Age Range` IS NOT NULL AND `Age Range` != ''
GROUP BY `Age Range`

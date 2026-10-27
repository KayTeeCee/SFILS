USE SF_library;


ALTER TABLE staging_library_data ADD INDEX idx_staging_patron_type (`Patron Type Code
patron_type_code`);

ALTER TABLE staging_library_data ADD INDEX idx_stage_age (`Age Range`(50));

ALTER TABLE staging_library_data ADD INDEX idx_stage_year (`Year Patron Registered`);

ALTER TABLE staging_library_data ADD INDEX idx_stage_lib (`Home Library Code
home_library_code`(10));

ALTER TABLE staging_library_data ADD INDEX idx_stage_notice (`Notification Preference Code
notification_medium_code`(50));

INSERT INTO libraries (home_library_code, home_library_definition)
SELECT DISTINCT `Home Library Code
home_library_code`, `Home Library Definition`
FROM staging_library_data
WHERE `Home Library Code
home_library_code` IS NOT NULL
ON DUPLICATE KEY UPDATE
	home_library_definition = VALUES(home_library_definition);

INSERT INTO patron_types (patron_type_code, patron_type_definition)
SELECT DISTINCT 
		`Patron Type Code
patron_type_code`,
	`Patron Type Definition`
FROM staging_library_data
WHERE `Patron Type Code
patron_type_code` IS NOT NULL
ON DUPLICATE KEY UPDATE
	patron_type_definition = VALUES(patron_type_definition);

INSERT INTO patrons (patron_type_code, age_range, registered_year, notice_medium_code, has_email, within_sf_county)
SELECT DISTINCT
	`Patron Type Code
patron_type_code`, 
	`Age Range`, 
	`Year Patron Registered`,
    `Notification Preference Code
notification_medium_code`,
	CASE WHEN `Provided Email Address` = 'Yes' THEN 1 ELSE 0 END,
    CASE WHEN `Within San Francisco County` = 'Yes' THEN 1 ELSE 0 END
FROM staging_library_data
WHERE `Patron Type Code
patron_type_code` IS NOT NULL;

INSERT INTO patron_activity (patron_id, home_library_code, checkout_total, renewal_total, active_month, active_year)
SELECT 
	(
	SELECT p.patron_id
    FROM patrons p
    WHERE p.patron_type_code = s.`Patron Type Code
patron_type_code`
		AND p.age_range = s.`Age Range`
        AND p.registered_year = s.`Year Patron Registered`
        AND p.notice_medium_code = s.`Notification Preference Code
notification_medium_code`
		LIMIT 1
	) AS patron_id,
    s.`Home Library Code
home_library_code` AS home_library_code,     
    s.`Total Checkouts
checkout_total`,     
    s.`Total Renewals
renewal_total`,     
    NULLIF(s.`Circulation Active Month`, ''),     
    NULLIF(s.`Circulation Active Year`, '') 
FROM staging_library_data s;





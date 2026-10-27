DROP DATABASE IF EXISTS SF_library;
CREATE DATABASE SF_library;
USE SF_library;

CREATE TABLE libraries (
	home_library_code VARCHAR(10) PRIMARY KEY,
    home_library_definition VARCHAR(25) NOT NULL
);

CREATE TABLE patron_types (
	patron_type_code INT PRIMARY KEY,
    patron_type_definition VARCHAR(25) NOT NULL
);

CREATE TABLE patrons (
	patron_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_type_code INT,
    age_range VARCHAR(25),
    registered_year INT,
    notice_medium_code VARCHAR(10),
    has_email BOOLEAN DEFAULT FALSE,
    within_sf_county BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (patron_type_code) REFERENCES patron_types(patron_type_code),
    INDEX idx_patron_age (age_range)
);

CREATE TABLE patron_activity (
	activity_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_id INT NOT NULL,
    home_library_code VARCHAR(10) NOT NULL,
    checkout_total INT DEFAULT 0,
    renewal_total INT DEFAULT 0,
    active_month VARCHAR(25),
    active_year INT,
    
    FOREIGN KEY (patron_id) REFERENCES patrons(patron_id) ON DELETE CASCADE,
    FOREIGN KEY (home_library_code) REFERENCES libraries(home_library_code) ON DELETE CASCADE,
    
    INDEX idx_timeline (active_year, active_month),
    INDEX idx_lib_traffic (home_library_code)
);

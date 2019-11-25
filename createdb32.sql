CREATE TABLE IF NOT EXISTS building 
(
   building_id INT(11) AUTO_INCREMENT NOT NULL,
   street VARCHAR(255) DEFAULT NULL,
   city VARCHAR(255) DEFAULT NULL,
   postcode VARCHAR(10) DEFAULT NULL,
   capacity INT(11) DEFAULT NULL,
   PRIMARY KEY(building_id)
);

CREATE TABLE IF NOT EXISTS emergency_contact
(
	emergency_contact_id BIGINT AUTO_INCREMENT NOT NULL,
	emergency_contact_number BIGINT NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	INDEX(emergency_contact_id),
	PRIMARY KEY(emergency_contact_id)
);

CREATE TABLE IF NOT EXISTS skill
(
	skill_id INT NOT NULL,
	skill_name VARCHAR(255) NOT NULL,
	INDEX(skill_id),
	PRIMARY KEY(skill_id)
);

CREATE TABLE IF NOT EXISTS lease 
(
	lease_id BIGINT AUTO_INCREMENT NOT NULL,
	contract VARCHAR(25) NOT NULL,
	start_date DATE NOT NULL,
	expected_duration INT NOT NULL,
	monthly_rent_apartment INT(11) NOT NULL,
	is_signed TINYINT(1) DEFAULT 0 NOT NULL,
	is_live TINYINT(1) DEFAULT 0 NOT NULL,
	INDEX(lease_id),
	PRIMARY KEY(lease_id)
);

CREATE TABLE IF NOT EXISTS person
(	
	person_id BIGINT AUTO_INCREMENT NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	emergency_contact_id BIGINT NOT NULL,
	INDEX(person_id),
	PRIMARY KEY(person_id),
	FOREIGN KEY(emergency_contact_id) REFERENCES emergency_contact(emergency_contact_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS tenant
(
	person_id BIGINT NOT NULL,
	bank_account_num BIGINT NOT NULL,
	INDEX(person_id),
	PRIMARY KEY(person_id),
	FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employee
(
	person_id BIGINT NOT NULL,
	monthly_salary DECIMAL NOT NULL,
	INDEX(person_id),
	PRIMARY KEY(person_id),
	FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS manager
(
	person_id BIGINT NOT NULL,
	office_apartment_number INT NOT NULL,
	office_building_id INT NOT NULL,
	INDEX(person_id),
	PRIMARY KEY(person_id),
	FOREIGN KEY(person_id) REFERENCES employee(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS technician
(
	person_id BIGINT NOT NULL,
	INDEX(person_id),
	PRIMARY KEY(person_id),
	FOREIGN KEY(person_id ) REFERENCES employee(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS apartment
(
	apartment_number INT NOT NULL,
	building_id INT(11) NOT NULL,
	number_of_bedroom INT (10) NOT NULL,
	number_of_bathroom INT (10) NOT NULL,
	total_area BIGINT NOT NULL,
	person_id BIGINT NOT NULL,
	INDEX (apartment_number, building_id),
	PRIMARY KEY(apartment_number, building_id),
	FOREIGN KEY(building_id) REFERENCES building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS technician_skill
(
	person_id BIGINT NOT NULL,
	skill_id INT NOT NULL,
	INDEX(person_id, skill_id),
	PRIMARY KEY (skill_id, person_id),
	FOREIGN KEY(skill_id) REFERENCES skill(skill_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(person_id) REFERENCES technician(person_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS apartment_lease
(	
	lease_id BIGINT NOT NULL,
	apartment_number INT NOT NULL,
	building_id int(11) NOT NULL,
	INDEX(apartment_number, lease_id, building_id),
	PRIMARY KEY(lease_id),
	FOREIGN KEY(apartment_number, building_id) REFERENCES apartment(apartment_number, building_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(lease_id) REFERENCES lease(lease_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS manager_lease
(
	person_id BIGINT NOT NULL,
	lease_id BIGINT NOT NULL,
	PRIMARY KEY (lease_id),
	FOREIGN KEY(person_id) REFERENCES manager(person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(lease_id) REFERENCES lease(lease_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS tenant_lease
(
	person_id BIGINT NOT NULL,
	lease_id BIGINT NOT NULL,
	INDEX(person_id, lease_id),
	PRIMARY KEY (person_id, lease_id),
	FOREIGN KEY(person_id) REFERENCES tenant(person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(lease_id) REFERENCES lease(lease_id) ON DELETE CASCADE ON UPDATE CASCADE
);
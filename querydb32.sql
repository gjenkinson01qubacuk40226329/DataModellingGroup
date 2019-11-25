SELECT person.person_id AS 'Person ID', person.first_name AS 'First name', person.last_name AS 'Last name', emergency_contact.emergency_contact_id AS 'Emergency contact ID', emergency_contact.emergency_contact_number AS 'Emergency contact number', emergency_contact.first_name AS 'Emergency contact first name', emergency_contact.last_name AS 'Emergency contact last name' FROM person
INNER JOIN emergency_contact ON emergency_contact.emergency_contact_id = person.emergency_contact_id
WHERE  emergency_contact.emergency_contact_id = person.emergency_contact_id
AND person.person_id IN (SELECT technician_skill.person_id FROM technician_skill WHERE technician_skill.skill_id = '201');


SELECT person.person_id AS 'Person ID', person.first_name AS 'First name', person.last_name AS 'Last name', building.postcode AS 'Post code', apartment_lease.apartment_number AS 'Apartment number' FROM person
INNER JOIN tenant_lease ON person.person_id = tenant_lease.person_id
INNER JOIN manager_lease ON tenant_lease.lease_id = manager_lease.lease_id
INNER JOIN apartment_lease ON apartment_lease.lease_id = manager_lease.lease_id
INNER JOIN building ON apartment_lease.building_id = building.building_id
WHERE person.person_id = tenant_lease.person_id AND manager_lease.lease_id = tenant_lease.lease_id
AND apartment_lease.lease_id = manager_lease.lease_id AND apartment_lease.building_id = building.building_id
AND manager_lease.person_id IN (SELECT person.person_id FROM person WHERE person.first_name = 'Matthew' AND person.last_name = 'Collins');


UPDATE employee SET monthly_salary = (monthly_salary * 1.05)
WHERE employee.person_id IN (SELECT technician_skill.person_id
FROM technician_skill GROUP BY technician_skill.person_id HAVING COUNT(technician_skill.person_id) > 1);


SELECT building.postcode AS 'Post code', (building.capacity - COUNT(building.postcode)) AS 'Rooms Left'  FROM building
INNER JOIN apartment ON apartment.building_id = building.building_id
INNER JOIN apartment_lease ON apartment.building_id = apartment_lease.building_id
INNER JOIN lease ON apartment_lease.lease_id = lease.lease_id
WHERE building.building_id = apartment_lease.building_id
AND apartment_lease.lease_id = lease.lease_id
AND lease.is_live = 1
AND building.postcode = 'BT95BW'
GROUP BY building.postcode;













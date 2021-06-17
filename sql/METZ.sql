USE ntuadb;

CREATE INDEX visit_date_and_time on Visit(date_time_of_entrance, date_time_of_exit);  -- (μου το ζηταει πιο πριν δλδ αυτο το index υπαρχει ηδη στην βαση αμα δεις τα αρχεια
																				      -- απλα σε js δεν ξερω αν το παιρνει κλπ τεσταρε το

SELECT hotel_room_ID, name_of_the_room, date_time_of_entrance, date_time_of_exit	-- ΓΙΑ ΤΟ 9 (ΜΑΖΙ ΜΕ ΤΟ ΙΝΤΕΞ)
FROM Visit USE INDEX(visit_date_and_time) JOIN Hotel_rooms USING (hotel_room_ID)
WHERE Visit.NFC_ID = 1;  -- εδω βαζεις το ιδ που θες καθε φορα

SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "20-40" AS AGE_GROUP -- 11β αλλαζεις το 30 με 365 και εισαι κομπλε
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "40-60" AS AGE_GROUP 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "61+" AS AGE_GROUP 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP
ORDER BY AGE_GROUP, Used_times DESC;

-- 11γ

SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "20-40" AS AGE_GROUP FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "41-60" AS AGE_GROUP FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "61+" AS AGE_GROUP FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP
ORDER BY AGE_GROUP, Users_using_this_service DESC;

SELECT * FROM Servises;  -- 7 απλα υπηρεσιες
SELECT * FROM Services_that_need_registration;  -- αυτα τα 2 ειναι με το κριτηριο ειδος υπηρεσιας
SELECT * FROM Services_that_dont_need_registration;

SELECT hotel_room_ID, description_of_position, service_description  -- αυτο ειναι με δεδομενη ημερομηνια
FROM Visit
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Provided_to USING (hotel_room_ID)
JOIN Services USING (service_ID)
WHERE service_ID <> 0 AND (DATE(Visit.date_time_of_entrance) = '2021-04-23'); --βαζεις το date που θες

SELECT DISTINCT service_ID, service_description, amount   -- αναλογα το ποσό
FROM Charge_for_service
JOIN Services USING (service_ID)
WHERE service_ID <> 0 AND (service_ID IN (SELECT service_ID from Services_that_need_registration));

-- το 11α δεν καταλαβα τι θελει να του βγαλω

-- επισης εφτιαξα ολα τα δεδομενα να εχουν σωστους χρονους ως προς την ημερομηνια που εχουμε
-- εβαλα και εξτρα triggers και το τελευταιο view
-- επισης στο customerController ελεγα να βαλουμε αυτο 
-- function getAllCustomers (req, res) {
--    get_All_Customers = `SELECT c.NFC_ID, c.firstname, c.lastname, c.number_of_indentification_document FROM Customer as c;`
--    εδω ελεγα να βαλουμε αυτο `SELECT * FROM Customer JOIN Customer_phones USING (NFC_ID) JOIN Customer_emails USING (NFC_ID);`
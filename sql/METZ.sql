USE ntuadb;

CREATE INDEX visit_date_and_time on Visit(date_time_of_entrance, date_time_of_exit);  -- (μου το ζηταει πιο πριν δλδ αυτο το index υπαρχει ηδη στην βαση αμα δεις τα αρχεια
																				      -- απλα σε js δεν ξερω αν το παιρνει κλπ τεσταρε το

SELECT hotel_room_ID, name_of_the_room, date_time_of_entrance, date_time_of_exit	-- ΓΙΑ ΤΟ 9 (ΜΑΖΙ ΜΕ ΤΟ ΙΝΤΕΞ)
FROM Visit USE INDEX(visit_date_and_time) JOIN Hotel_rooms USING (hotel_room_ID)
WHERE Visit.NFC_ID = 1;  -- εδω βαζεις το ιδ που θες καθε φορα

-- 11a
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "20-40" AS AGE_GROUP, "Last year" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "41-60" AS AGE_GROUP, "Last year" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "61+" AS AGE_GROUP, "Last year" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "20-40" AS AGE_GROUP, "Last month" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "41-60" AS AGE_GROUP, "Last month" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT hotel_room_ID, name_of_the_room, description_of_position, COUNT(hotel_room_ID) AS NO_of_People_visited, "61+" AS AGE_GROUP, "Last month" AS TIMEFRAME
FROM Hotel_rooms
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY hotel_room_ID, AGE_GROUP, TIMEFRAME
ORDER BY TIMEFRAME, AGE_GROUP, NO_of_People_visited DESC;


SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "20-40" AS AGE_GROUP, "Last year" AS TIMEFRAME -- 11β 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "40-60" AS AGE_GROUP , "Last year" AS TIMEFRAME
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "61+" AS AGE_GROUP , "Last year" AS TIMEFRAME
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "20-40" AS AGE_GROUP, "Last month" AS TIMEFRAME 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "40-60" AS AGE_GROUP, "Last month" AS TIMEFRAME 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(service_ID) AS Used_times, "61+" AS AGE_GROUP, "Last month" AS TIMEFRAME 
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30)
GROUP BY service_ID, AGE_GROUP, TIMEFRAME
ORDER BY TIMEFRAME, AGE_GROUP, Used_times DESC;

-- 11γ

SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "20-40" AS AGE_GROUP, "Last year" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "41-60" AS AGE_GROUP, "Last year" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "61+" AS AGE_GROUP, "Last year" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365))) T
group by service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "20-40" AS AGE_GROUP, "Last month" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30))) T
group by service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "41-60" AS AGE_GROUP, "Last month" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 41 AND 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30))) T
group by service_ID, AGE_GROUP, TIMEFRAME
UNION
SELECT service_ID, service_description, COUNT(*) as Users_using_this_service, "61+" AS AGE_GROUP, "Last month" AS TIMEFRAME FROM(
SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) > 60) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 30))) T
group by service_ID, AGE_GROUP, TIMEFRAME
ORDER BY TIMEFRAME, AGE_GROUP, Users_using_this_service DESC;


--                    ERWTHMA 10 -----------------------------------

SELECT distinct ts.NFC_ID AS Possibly_exposed_customer_ID, ts.hotel_room_ID AS Exposed_room_ID, ts.date_time_of_entrance, ts.date_time_of_exit, 
				tb.NFC_ID AS Exposed_Customer, tb.date_time_of_entrance, tb.date_time_of_exit
FROM Visit tb JOIN Visit ts
ON  tb.NFC_ID = 4 AND  -- 4 -> 2 κρουσματα // 
	tb.NFC_ID <> ts.NFC_ID AND
    tb.hotel_room_ID = ts.hotel_room_ID AND
    ((ts.date_time_of_entrance BETWEEN tb.date_time_of_entrance AND ADDTIME(tb.date_time_of_entrance, "72:00:00")) OR -- ΕΒΑΛΑ 72 ΩΡΕΣ ΜΕΤΑ ΤΟ ΠΕΡΙΣΤΑΤΙΚΟ
	(ts.date_time_of_exit BETWEEN tb.date_time_of_entrance AND ADDTIME(tb.date_time_of_entrance, "72:00:00")));



SELECT * FROM Services;  -- 7 απλα υπηρεσιες
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
USE ntuadb;

CREATE INDEX visit_date_and_time on Visit(date_time_of_entrance, date_time_of_exit);  -- (μου το ζηταει πιο πριν δλδ αυτο το index υπαρχει ηδη στην βαση αμα δεις τα αρχεια
																				      -- απλα σε js δεν ξερω αν το παιρνει κλπ τεσταρε το

SELECT hotel_room_ID, name_of_the_room, date_time_of_entrance, date_time_of_exit	-- ΓΙΑ ΤΟ 9 (ΜΑΖΙ ΜΕ ΤΟ ΙΝΤΕΞ)
FROM Visit USE INDEX(visit_date_and_time) JOIN Hotel_rooms USING (hotel_room_ID)
WHERE Visit.NFC_ID = 1;  -- εδω βαζεις το ιδ που θες καθε φορα

SELECT service_ID, service_description, COUNT(service_ID) AS Used_times -- 11β αλλαζεις ηλικιες και το 30 με 365 και εισαι κομπλε
FROM Services
JOIN Provided_to USING (service_ID)
JOIN Hotel_rooms USING (hotel_room_ID)
JOIN Visit USING (hotel_room_ID)
JOIN Customer USING (NFC_ID)
WHERE number_of_beds = 0 AND (YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365)
GROUP BY service_ID
ORDER BY COUNT(service_ID) DESC;

-- προσπαθησα και το 11γ και βγαλω ολα τα unique pairs μεταξυ service id και nfc_id απλα δεν μπορεσα να τα μετρησω ωστε να βρουμε ποια υπηρεσια 
-- εχει τους περισσοτερους 

SELECT DISTINCT Charge_for_service.NFC_ID, Service_ID, service_description
FROM Charge_for_service
JOIN Customer USING (NFC_ID)
JOIN Services USING (service_ID) 
JOIN Provided_to USING (service_ID)
JOIN Visit USING (hotel_room_ID)
WHERE service_ID <>0 AND ((YEAR(NOW()) - YEAR(Customer.dateofbirth) BETWEEN 20 AND 40) AND (DATE(NOW()) - DATE(Visit.date_time_of_entrance) < 365));

-- το 11α δεν καταλαβα τι θελει να του βγαλω
-- επισης εφτιαξα ολα τα δεδομενα να εχουν σωστους χρονους ως προς την ημερομηνια που εχουμε
-- εβαλα και εξτρα triggers και το τελευταιο view
-- επισης στο customerController ελεγα να βαλουμε αυτο 
-- function getAllCustomers (req, res) {
--    get_All_Customers = `SELECT c.NFC_ID, c.firstname, c.lastname, c.number_of_indentification_document FROM Customer as c;`
--    εδω ελεγα να βαλουμε αυτο `SELECT * FROM Customer JOIN Customer_phones USING (NFC_ID) JOIN Customer_emails USING (NFC_ID);`
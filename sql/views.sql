CREATE VIEW sales_of_services AS
SELECT Services.service_description, count(Registered_to_services.service_ID)
FROM Registered_to_services, Services
WHERE Services.service_ID IN (Registered_to_services.service_ID)
GROUP BY Services.service_ID;

CREATE VIEW customer_info AS
SELECT DISTINCT Customer.NFC_ID, Customer.firstname, Customer.lastname, Customer.dateofbirth,
Customer.number_of_indentification_document, Customer.type_of_indentification_document, 
Customer.issuing_authority, Customer_emails.email, Customer_phones.phone
FROM Customer, Customer_emails, Customer_phones
WHERE Customer.NFC_ID = Customer_emails.NFC_ID;
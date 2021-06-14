CREATE VIEW sales_of_services AS
SELECT Services.service_description, count(Registered_to_services.service_ID)
FROM Registered_to_services, Services
WHERE Services.service_ID IN (Registered_to_services.service_ID)
GROUP BY Services.service_ID;
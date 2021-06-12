USE ntuadb;

INSERT INTO Customer (firstname, lastname, dateofbirth, number_of_indentification_document, type_of_indentification_document, issuing_authority) VALUES
                ('Konstantinos', 'Antoniou', '1998-07-06', 'AL-344513', 'ID', 'T.A. EVOIAS'),
                ('Zacharias', 'Anastasakis', '1998-05-03', 'AI-339213', 'ID', 'T.A. HRAKLEIOU'),
                ('Ioannis', 'Metzakis', '1998-02-17', 'AK-635524', 'ID', 'T.A. HRAKLEIOU'),
                ('Giorgos', 'Anastasiou', '1998-01-23', 'AL-632593', 'ID', 'T.A. EVOIAS'),
                ('Apostolis', 'Molivdas', '1998-05-25', 'AE0052412', 'Passport', 'A.E.A./D.D.-N.P.C'),
                ('Theofanis', 'Padazis', '1997-01-11', 'AP-995513', 'ID', 'T.A. Athens'),
                ('Paris', 'Dariveris', '1998-03-06', 'AI-355241', 'ID', 'T.A. EVOIAS'),
                ('Nikos', 'Apostolidis', '2000-04-09', 'AI-125478', 'ID', 'T.A. Thessalonikis'),
                ('Nikos', 'Arseniou', '1985-01-25', 'AP-852145', 'ID', 'T.A. Athens'),
                ('Konstantinos', 'Anastasiou', '1960-12-12', 'AL-236525', 'ID', 'T.A. Thessalonikis');


INSERT INTO Customer_emails(NFC_ID, email) VALUES 
        (1, 'kostas.an2016@gmail.com'),
        (2, 'zacharias_anastasakis@gmail.com'),
        (3, 'metzakis_ioannis@gmail.com'),
        (4, 'giorgos_anastasiou@gmail.com'),
        (5, 'apostolos_molyvdas@gmail.com'),
        (6, 'fanis_padazis@gmail.com'),
        (7, 'paris_dariveris@gmail.com'),
        (8, 'nikos_apostolidis@gmail.com'),
        (9, 'nikos_arseniou@gmail.com'),
        (10, 'konstantinos_anastasiou@gmail.com');

INSERT INTO Customer_phones(NFC_ID, phone) VALUES 
        (1, '6976522415'),
        (2, '6978546990'),
        (3, '6974510090'),
        (4, '6941258840'),
        (5, '6936699512'),
        (6, '6942200589'),
        (7, '6974125836'),
        (8, '6973624582'),
        (9, '6974662556'),
        (10, '6988554025');

INSERT INTO Services(service_description) VALUES
        ('bar'),
        ('restaurant'),
        ('hair salon'),
        ('gym'),
        ('conference room'),
        ('sauna');

INSERT INTO Services_that_need_registration(service_ID) VALUES
        (4),
        (5),
        (6);

INSERT INTO Services_that_dont_need_registration(service_ID) VALUES
        (1),
        (2),
        (3);

-- INSERT INTO Hotel_rooms(hotel_room_ID, number_of_beds, name_of_the_room, description_of_position) VALUES
--        ('');

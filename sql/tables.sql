DROP DATABASE IF EXISTS ntuadb;
CREATE DATABASE ntuadb;

USE ntuadb;

CREATE TABLE Customer(
    NFC_ID INT NOT NULL IDENTITY(1,1),
    firstname VARCHAR(200) NOT NULL,
    lastname VARCHAR(200) NOT NULL,
    dateofbirth DATE NOT NULL,
    number_of_indentification_document INT NOT NULL,
    type_of_indentification_document VARCHAR(200) NOT NULL,
    issuing_authority VARCHAR(200) NOT NULL,
    PRIMARY KEY (NFC_ID)
);

CREATE TABLE Customer_emails(
    NFC_ID INT NOT NULL,
    email VARCHAR(200) NOT NULL,
    PRIMARY KEY (NFC_ID, email), FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE
);

CREATE TABLE Customer_phones(
    NFC_ID INT NOT NULL,
    phone BIGINT NOT NULL,
    PRIMARY KEY (NFC_ID, phone), FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE
);

CREATE TABLE Facilities(
    facility_ID INT NOT NULL,
    facility_description VARCHAR(20) NOT NULL,
    PRIMARY KEY (facility_ID)
);

CREATE TABLE Facilities_that_need_registration(
    facility_ID INT NOT NULL,
    PRIMARY KEY (facility_ID),
    FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID) ON DELETE CASCADE
);

CREATE TABLE Facilities_that_dont_need_registration(
    facility_ID INT NOT NULL,
    PRIMARY KEY (facility_ID),
    FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID) ON DELETE CASCADE
);

CREATE TABLE Hotel_rooms(
    hotel_room_ID INT NOT NULL PRIMARY KEY,
    number_of_beds INT NOT NULL,
    name_of_the_room VARCHAR(25) NOT NULL,
    description_of_position VARCHAR(25) NOT NULL
);

CREATE TABLE Have_access(
    NFC_ID INT NOT NULL,
    hotel_room_ID INT NOT NULL,
    starting_time TIME(0) NOT NULL,
    ending_time TIME(0) NOT NULL,
    PRIMARY KEY (NFC_ID, hotel_room_ID),
    FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE,
    FOREIGN KEY (hotel_room_ID) REFERENCES Hotel_rooms(hotel_room_ID) ON DELETE CASCADE
);

CREATE TABLE Visit(
    NFC_ID INT NOT NULL,
    hotel_room_ID INT NOT NULL,
    time_of_entrance TIME(0) NOT NULL,
    time_of_exit TIME(0) NOT NULL,
    PRIMARY KEY (NFC_ID, hotel_room_ID),
    FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE,
    FOREIGN KEY (hotel_room_ID) REFERENCES Hotel_rooms(hotel_room_ID) ON DELETE CASCADE
);

CREATE TABLE Registered_to_facilities(
    NFC_ID INT NOT NULL,
    facility_ID INT NOT NULL,
    datetime_of_registration DATETIME NOT NULL,
    PRIMARY KEY (NFC_ID, facility_ID),
    FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE,
    FOREIGN KEY (facility_ID) REFERENCES Facilities_that_need_registration(facility_ID) ON DELETE CASCADE
);

CREATE TABLE Provided_to(
    hotel_room_ID INT NOT NULL,
    facility_ID INT NOT NULL,
    PRIMARY KEY (hotel_room_ID, facility_ID),
    FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID) ON DELETE CASCADE,
    FOREIGN KEY (hotel_room_ID) REFERENCES Hotel_rooms(hotel_room_ID) ON DELETE CASCADE
);

CREATE TABLE Charge_for_facility(
    datetime_of_the_event DATETIME NOT NULL,
    charge_description VARCHAR(25) NOT NULL,
    amount FLOAT NOT NULL,
    NFC_ID INT NOT NULL,
    facility_ID INT NOT NULL,
    PRIMARY KEY (datetime_of_the_event, facility_ID, NFC_ID),
    FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID) ON DELETE CASCADE,
    FOREIGN KEY (NFC_ID) REFERENCES Customer(NFC_ID) ON DELETE CASCADE
);



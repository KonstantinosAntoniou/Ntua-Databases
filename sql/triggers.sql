USE ntuadb;

DELIMITER $$

CREATE TRIGGER check_email_validity1 
BEFORE UPDATE ON Customer_emails
    FOR EACH ROW
    BEGIN
        if (new.email not like '%@%.%' or new.email like '@%' or new.email like '%@%@%' ) THEN
			signal sqlstate '45000' set message_text = 'Wrong email format inserted';
		end if;
	end;
$$

CREATE TRIGGER check_email_validity2 
BEFORE INSERT ON Customer_emails
    FOR EACH ROW
    BEGIN
        if (new.email not like '%@%.%' or new.email like '@%' or new.email like '%@%@%' ) THEN
			signal sqlstate '45000' set message_text = 'Wrong email format inserted';
		end if;
	end;

$$

CREATE TRIGGER check_phone_validity1 
BEFORE UPDATE ON Customer_phones
    FOR EACH ROW
    BEGIN
        if (length(new.phone) <> 10) THEN
			signal sqlstate '45000' set message_text = 'Wrong phone inserted';
		end if;
	end;

$$

CREATE TRIGGER check_phone_validity2
BEFORE INSERT ON Customer_phones
    FOR EACH ROW
    BEGIN
        if (length(new.phone) <> 10) THEN
			signal sqlstate '45000' set message_text = 'Wrong phone inserted';
		end if;
	end;
    
 $$
 
CREATE TRIGGER check_beds_validity1
BEFORE INSERT ON Hotel_rooms
    FOR EACH ROW
    BEGIN
        if (new.number_of_beds >=7) THEN
        signal sqlstate '45000' set message_text = 'Our hotel doesnt have rooms with more than 7 beds';
		end if;
	end;

$$

CREATE TRIGGER check_beds_validity2
BEFORE UPDATE ON Hotel_rooms
    FOR EACH ROW
    BEGIN
        if (new.number_of_beds >=7) THEN
        signal sqlstate '45000' set message_text = 'Our hotel doesnt have rooms with more than 7 beds';
		end if;
	end;

$$

CREATE TRIGGER check_for_have_access_validity1
BEFORE INSERT ON Have_access
    FOR EACH ROW
    BEGIN
        if (new.starting_time_date > new.ending_time_date) THEN
        signal sqlstate '45000' set message_text = 'Ending date cant be smaller than starting date (Have_access table)';
		end if;
	end;

$$

CREATE TRIGGER check_for_have_access_validity2
BEFORE UPDATE ON Have_access
    FOR EACH ROW
    BEGIN
        if (new.starting_time_date > new.ending_time_date) THEN
        signal sqlstate '45000' set message_text = 'Ending date cant be smaller than starting date (Have_access table)';
		end if;
	end;

$$

CREATE TRIGGER check_for_visit_validity1
BEFORE UPDATE ON Visit
    FOR EACH ROW
    BEGIN
        if (new.date_time_of_entrance > new.date_time_of_exit) THEN
        signal sqlstate '45000' set message_text = 'Ending date cant be smaller than starting date (Visit table)';
		end if;
	end;

$$

CREATE TRIGGER check_for_visit_validity2
BEFORE INSERT ON Visit
    FOR EACH ROW
    BEGIN
        if (new.date_time_of_entrance > new.date_time_of_exit) THEN
        signal sqlstate '45000' set message_text = 'Ending date cant be smaller than starting date (Visit table)';
		end if;
	end;

$$

CREATE TRIGGER check_for_amount_validity1
BEFORE INSERT ON Charge_for_service
    FOR EACH ROW
    BEGIN
        if (new.amount <= 0) THEN
        signal sqlstate '45000' set message_text = 'Amount cant be lower or equal to zero';
		end if;
	end;

$$

CREATE TRIGGER check_for_amount_validity2
BEFORE UPDATE ON Charge_for_service
    FOR EACH ROW
    BEGIN
        if (new.amount <= 0) THEN
        signal sqlstate '45000' set message_text = 'Amount cant be lower or equal to zero';
		end if;
	end;

$$

CREATE TRIGGER check_reservation 
BEFORE INSERT ON Have_access
    FOR EACH ROW
    BEGIN
        IF (EXISTS (SELECT * FROM Have_access WHERE new.hotel_room_ID = hotel_room_ID AND NOT (new.ending_time_date <= starting_time_date OR new.starting_time_date >= ending_time_date))) THEN
        signal sqlstate '45000' set message_text = 'Room is already occupied';
		end if;
	end;

$$


DELIMITER ;
use railway_reservation_system;

-- CREATE PROCEDURE
-- Procedure to Insert a New Passenger if Email Doesn’t Exist
DELIMITER //

CREATE PROCEDURE AddPassenger (
    IN p_name VARCHAR(100),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    -- Check if email exists
    IF NOT EXISTS (
        SELECT 1 FROM Passenger WHERE Email = p_email
    ) THEN
        INSERT INTO Passenger (Name, Address, Phone_No, Email, Password)
        VALUES (p_name, p_address, p_phone, p_email, p_password);
    ELSE
        SELECT 'Passenger with this email already exists.' AS Message;
    END IF;
END //

DELIMITER ;

-- Call the procedure:
CALL AddPassenger('Ravi Kumar', '123 Market Street', '9876543210', 'ravi@example.com', 'ravipass');

-- CREATE FUNCTION
-- Function to Calculate Discounted Fare
DELIMITER //

CREATE FUNCTION GetDiscountedFare (
    base_fare DECIMAL(10,2),
    discount_percent INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE final_fare DECIMAL(10,2);
    SET final_fare = base_fare - (base_fare * discount_percent / 100);
    RETURN final_fare;
END //

DELIMITER ;

-- Use the function:
SELECT GetDiscountedFare(2000, 10) AS DiscountedFare;

-- Conditional Logic
-- CASE
SELECT 
    Fare,
    CASE 
        WHEN Fare < 1000 THEN 'Low Fare'
        WHEN Fare BETWEEN 1000 AND 2000 THEN 'Medium Fare'
        ELSE 'High Fare'
    END AS Fare_Status
FROM Booking;








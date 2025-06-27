--ALTER TABLE Customers ADD (IsVIP CHAR(1) DEFAULT 'N' CHECK (IsVIP IN ('Y','N')));


BEGIN
    FOR cust IN (SELECT CustomerID, Balance FROM Customers)
    LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
/

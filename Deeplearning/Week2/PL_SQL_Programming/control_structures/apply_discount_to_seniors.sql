DECLARE
    v_customer_age NUMBER;
BEGIN
    FOR cust IN (SELECT c.CustomerID, c.DOB, l.LoanID, l.InterestRate
                 FROM Customers c
                 JOIN Loans l ON c.CustomerID = l.CustomerID)
    LOOP
        v_customer_age := TRUNC(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12);
        
        IF v_customer_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = cust.LoanID;
        END IF;
    END LOOP;
    COMMIT;
END;
/

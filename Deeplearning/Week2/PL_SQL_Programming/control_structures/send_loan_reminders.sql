DECLARE
    v_due_date DATE := SYSDATE + 30;
BEGIN
    FOR loan_rec IN (
        SELECT c.Name, l.LoanID, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND v_due_date
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder for ' || loan_rec.Name || 
            ': Loan #' || loan_rec.LoanID || 
            ' is due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD')
        );
    END LOOP;
END;
/

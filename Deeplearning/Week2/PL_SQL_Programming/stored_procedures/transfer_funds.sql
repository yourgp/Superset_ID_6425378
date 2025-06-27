CREATE OR REPLACE PROCEDURE TransferFunds(
    p_source_acc      IN NUMBER,
    p_destination_acc IN NUMBER,
    p_amount          IN NUMBER
) IS
    v_source_bal NUMBER;
BEGIN
    --Lock source account for update
    SELECT Balance INTO v_source_bal
    FROM Accounts 
    WHERE AccountID = p_source_acc
    FOR UPDATE;
    
    IF v_source_bal < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds');
    END IF;
    
    -- Deduct from source
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_source_acc;
    
    --Add to_destination
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_destination_acc;
    
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid account ID');
END;
/

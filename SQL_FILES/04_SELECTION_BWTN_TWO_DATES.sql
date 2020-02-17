
--===========================================================================================
--BUSINESS INTELLIGENCE : SESSION_2
--===========================================================================================
--We create a PL / SQL procedure that receives two dates and supplies the fact table from
--operational for all orders made between two dates.


CREATE OR REPLACE PROCEDURE disply_data(sdate IN varchar2,edate IN varchar2) AS
    
    CURSOR C1 IS 
        SELECT client_id, product_id,zip_code ,quantity,price 
            FROM PURCHASE
                WHERE CAST(time_stamp AS DATE)  Between TO_DATE(sdate,'DD-MM-YYYY') 
                AND TO_DATE(edate,'DD-MM-YYYY');
                
        V_PRICE purchase.price%TYPE;
        V_CUSTID purchase.client_id%TYPE; 
        V_PRODUCTID purchase.product_id%TYPE;
        V_QUANTITY PURCHASE.QUANTITY%TYPE;
        V_ZIPCODE PURCHASE.ZIP_CODE%TYPE;
BEGIN
        DBMS_OUTPUT.PUT_LINE('ProductId'||'    '||'CustomerId'||'    '||'Zipcode'||'    '||'Quantity'||'    '||'Price');
        OPEN C1;
            LOOP
             FETCH C1 INTO V_PRODUCTID,V_CUSTID,V_ZIPCODE,V_QUANTITY,V_PRICE;
                EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(V_PRODUCTID||'    '||V_CUSTID||'    '||V_ZIPCODE||'    '||V_QUANTITY||'    '||V_PRICE);
            END LOOP;
        CLOSE C1;
END;
/

SET SERVEROUTPUT ON
EXEC disply_data(sdate=>'02-Jan-2003',edate=>'02-Dec-2004');
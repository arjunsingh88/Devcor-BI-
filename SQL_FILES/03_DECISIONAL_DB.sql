--=====================================================***************========================================================
--===================================================== START * START ========================================================
--=====================================================***************========================================================
 CONNECT session_1/session_1;

--grant  connect, resource, dba to session_2;
--GRANT UNLIMITED TABLESPACE TO session_2;

GRANT SELECT ON COUNTRY TO session_2; 
GRANT SELECT ON CITY TO session_2; 
GRANT SELECT ON CLIENTS TO session_2;
GRANT SELECT ON DEPARTMENT TO session_2;
GRANT SELECT ON PRODUCT TO session_2;
GRANT SELECT ON PURCHASE TO session_2;
GRANT SELECT ON REGION TO session_2;

--===========================================================================================
-- CREATE the user account session_2
-- Grant connect, resource and DBA privileges
-- connecting to DBA
--===========================================================================================
--CREATE  USER session_2 IDENTIFIED BY session_2;
--GRANT  CONNECT, RESOURCE TO session_2;



CONNECT session_2/session_2;

--===========================================================================================
--DROPING TABLES IF EXISTS
--===========================================================================================
DROP TABLE PLACE CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE DATES CASCADE CONSTRAINTS;
DROP TABLE CLIENTS CASCADE CONSTRAINTS;
DROP TABLE PURCHASE CASCADE CONSTRAINTS;

--===========================================================================================
--  ************************************CREATING TABLES**************************************
--===========================================================================================

-- ============================================================
--   TABLE : PLACE                                        
-- ============================================================
CREATE TABLE PLACE
(
    ZIP_CODE NUMBER(9) NOT NULL,
	DEPARTMENT_NAME VARCHAR2(60),
	REGION_NAME VARCHAR2(60),
    COUNTRY_NAME VARCHAR2(60),
    CONSTRAINTS pk_country PRIMARY KEY (ZIP_CODE)
);
-- ============================================================
--   TABLE : PRODUCT                                           
-- ============================================================
CREATE TABLE PRODUCT
(
    PRODUCT_ID NUMBER(9) NOT NULL,
    PROD_PRICE NUMBER(9) NOT NULL,
    PROD_TYPE VARCHAR2(9) NOT NULL,
    CONSTRAINTS pk_product_ref PRIMARY KEY (PRODUCT_ID)
);
-- ============================================================
--   TABLE : DATES
-- ============================================================
CREATE TABLE DATES
(
    TIME_STAMP TIMESTAMP NOT NULL,
    HOURS NUMBER(20),
	DAYOFWEEK VARCHAR2(60),
	DAYOFYEAR VARCHAR2(60),
	WEEK VARCHAR2(60),
	MONTHS VARCHAR2(60),
	QUARTER NUMBER(20),
	SEMESTER NUMBER(20),
	YEARS NUMBER(20),
	CONSTRAINTS pk_region PRIMARY KEY (TIME_STAMP)
);


-- ============================================================
--   TABLE : CLIENTS                                            
-- ============================================================
CREATE TABLE CLIENTS
(
    CLIENT_ID NUMBER(9) NOT NULL,
    AGE VARCHAR2(10),
    GENDER VARCHAR2(5),
	ZIP_CODE NUMBER(9),
	DEPARTMENT_NAME VARCHAR2(60),
	REGION_NAME VARCHAR2(60),
	COUNTRY_NAME VARCHAR2(60),
    CONSTRAINTS pk_clients PRIMARY KEY (CLIENT_ID)
);
-- ============================================================
--   TABLE : PURCHASE
-- ============================================================
CREATE TABLE PURCHASE
(
    QUANTITY NUMBER(9) NOT NULL,
    PRICE NUMBER(9) NOT NULL,
	ZIP_CODE NUMBER(9) NOT NULL,
	TIME_STAMP TIMESTAMP NOT NULL,
	PRODUCT_ID NUMBER(9) NOT NULL,
	CLIENT_ID NUMBER(9)NOT NULL
);



-- ============================================================
--   FOREIGN KEYS : ALL TABLES                                          
--   PLACE, PRODUCT, PURCHASE, DATES, CLIENT
-- ============================================================



ALTER TABLE PURCHASE ADD CONSTRAINTS fk1_purchase FOREIGN KEY (ZIP_CODE)
       REFERENCES PLACE(ZIP_CODE);

ALTER TABLE PURCHASE ADD CONSTRAINTS fk2_purchase FOREIGN KEY (TIME_STAMP)
       REFERENCES DATES(TIME_STAMP);
       
ALTER TABLE PURCHASE ADD CONSTRAINTS fk3_purchase FOREIGN KEY (PRODUCT_ID)
       REFERENCES PRODUCT(PRODUCT_ID);

ALTER TABLE PURCHASE ADD CONSTRAINTS fk4_purchase FOREIGN KEY (CLIENT_ID)
       REFERENCES CLIENTS(CLIENT_ID);


--===========================================================================================
--************************************ INSERTING  DATAE *************************************
--===========================================================================================




-- Creating trigger in session_2
CREATE OR REPLACE TRIGGER insert_data_product
AFTER INSERT ON SESSION_1.product
FOR EACH ROW
BEGIN
INSERT INTO SESSION_2.product (PRODUCT_ID,PROD_PRICE,PROD_TYPE) VALUES (:NEW.PRODUCT_ID,:NEW.PROD_PRICE,:NEW.PROD_TYPE);
END;
/

--===========================================================================================
-- CREATING A PROCEDURE INSERTING DATA INTO ALL DECISIONAL TABLES
--===========================================================================================


CREATE OR REPLACE PROCEDURE data_decisional  AS 

	BEGIN


			--===========================================================================================
			-- PRODUCT TABLE
			--===========================================================================================

				INSERT INTO PRODUCT (PRODUCT_ID,PROD_PRICE,PROD_TYPE)
					SELECT PRODUCT_ID, PROD_PRICE,PROD_TYPE FROM session_1.PRODUCT ORDER BY PRODUCT_ID ASC;
				
			--===========================================================================================
			-- PLACE TABLE
			--===========================================================================================

			INSERT INTO PLACE (ZIP_CODE, DEPARTMENT_NAME, REGION_NAME, COUNTRY_NAME)
				SELECT
				city.ZIP_CODE AS ZIP_CODE
				, department.DEPARTMENT_NAME AS DEPARTMENT_NAME
				, region.REGION_NAME AS REGION_NAME
				, country.COUNTRY_NAME AS COUNTRY_NAME
				FROM
					session_1.city
						INNER JOIN session_1.department 
							USING(DEPARTMENT_ID)
						INNER JOIN session_1.region
							USING(REGION_ID)
						INNER JOIN session_1.country
							USING(COUNTRY_ID)
						ORDER BY
							ZIP_CODE ASC;

			--===========================================================================================
			-- CLIENTS TABLE
			--===========================================================================================

			INSERT INTO CLIENTS (CLIENT_ID, AGE, GENDER, ZIP_CODE, DEPARTMENT_NAME, REGION_NAME, COUNTRY_NAME)
				SELECT 
				 clients.CLIENT_ID AS CLIENT_ID,
				 round(months_between(TRUNC(to_date(clients.BIRTHDATE,'DD-MON-YY')),(sysdate))/12 ) as AGE,
				 clients.GENDER AS GENDER,
				 city.ZIP_CODE AS ZIP_CODE,
				 department.DEPARTMENT_NAME AS DEPARTMENT_NAME,
				 region.REGION_NAME AS REGION_NAME,
				 country.COUNTRY_NAME AS COUNTRY_NAME
				FROM 
					session_1.clients
						INNER JOIN session_1.city
							ON clients.ZIP_CODE = city.ZIP_CODE
						INNER JOIN session_1.department 
							USING(DEPARTMENT_ID)
						INNER JOIN session_1.region
							USING(REGION_ID)
						INNER JOIN session_1.country
							USING(COUNTRY_ID)
						ORDER BY
							CLIENT_ID ASC;
							
			--===========================================================================================
			-- DATE TABLE
			--===========================================================================================
				
			INSERT INTO DATES (TIME_STAMP, HOURS, DAYOFWEEK, DAYOFYEAR, WEEK, MONTHS,QUARTER,SEMESTER,YEARS)
				SELECT TIME_STAMP AS TIME_STAMP,
						EXTRACT (HOUR FROM TIME_STAMP) AS HOURS, 
						TO_CHAR(TIME_STAMP,'DY') AS DAYOFWEEK, 
						TO_CHAR(TIME_STAMP, 'DDD') AS DAYOFYEAR, 
						TO_CHAR(TIME_STAMP, 'IW') AS WEEK, 
						TO_CHAR(TIME_STAMP,'MON')AS MONTHS, 
						TO_CHAR(TIME_STAMP, 'Q') AS QUARTER,  
						(CEIL(EXTRACT(MONTH FROM TIME_STAMP)/6)) AS SEMESTER,
						TO_CHAR(TIME_STAMP, 'IYYY') AS YEARS
							FROM session_1.PURCHASE;

			--===========================================================================================
			-- PURCHASE TABLE - FACT TABLE
			--===========================================================================================
				
			INSERT INTO PURCHASE (QUANTITY, PRICE, ZIP_CODE, TIME_STAMP,PRODUCT_ID,CLIENT_ID)
			SELECT PURCHASE.QUANTITY AS QUANTITY,
				   PRODUCT.PROD_PRICE AS PRICE,
				   PURCHASE.ZIP_CODE AS ZIP_CODE,
				   PURCHASE.TIME_STAMP AS TIME_STAMP,
				   PURCHASE.PRODUCT_ID AS PRODUCT_ID,
				   PURCHASE.CLIENT_ID AS CLIENT_ID
			  FROM session_1.PURCHASE
				   INNER JOIN session_1.PRODUCT
						ON PURCHASE.PRODUCT_ID = PRODUCT.PRODUCT_ID 
							ORDER BY CLIENT_ID ASC;
				
END data_decisional;
/				

EXEC data_decisional;	
	
	

--===========================================================================================
-- SELECTING DATA FROM TABLES AS A COUNT
--===========================================================================================	
	DESC PLACE;
	SELECT COUNT(*) FROM PLACE;
	DESC PRODUCT;
	SELECT COUNT(*) FROM PRODUCT;
	DESC CLIENTS;
	SELECT COUNT(*) FROM CLIENTS;
	DESC DATES;
	SELECT COUNT(*) FROM DATES;
	DESC PURCHASE;
	SELECT COUNT(*) FROM PURCHASE;
	
	SELECT * From DBA_DATA_FILES;
	
--===========================================================================================
-- 3.1  Expression of needs
--===========================================================================================	
--The sales manager wants:

-- ----------------------------To study the turnover and sales volume ------------------------
	-- By product and Family.
SELECT PRODUCT.PRODUCT_ID,
	   PRODUCT.PROD_TYPE,
	   (PURCHASE.QUANTITY*PURCHASE.PRICE) AS TURNOVER 
	   FROM PURCHASE
			INNER JOIN PRODUCT 
				ON  PURCHASE.PRODUCT_ID = PRODUCT.PRODUCT_ID 
					ORDER BY PRODUCT.PROD_TYPE ASC;
-- Per week, month and year.			
SELECT  PRODUCT_ID,
		TO_CHAR(TIME_STAMP, 'IW') AS WEEKS,
		TO_CHAR(TIME_STAMP, 'MON') AS MONTHS,
		TO_CHAR(TIME_STAMP, 'IYYY') AS YEARS,
		(QUANTITY*PRICE) AS TURNOVER
			FROM PURCHASE
				ORDER BY PRODUCT_ID ASC;

-- By department and region.
SELECT PLACE.DEPARTMENT_NAME AS DEPARTMENT,
	   PLACE.REGION_NAME AS REGION,
	   (PURCHASE.QUANTITY*PURCHASE.PRICE) AS TURNOVER
			FROM PLACE
				INNER JOIN PURCHASE
					ON PLACE.ZIP_CODE = PURCHASE.ZIP_CODE
						ORDER BY PLACE.DEPARTMENT_NAME ASC;
	
--===========================================================================================
-- 4.1 Supplying a table of facts
--===========================================================================================	
-- We log on the system account (system , eisti0001)

-- CONNECTING TO SYSTEM 
    CONN SYSTEM/SYSTEM;
	
-- CREATING TABLESPACE TO SESSION_1
CREATE TABLESPACE TS_session_1 datafile'H:\Masters\ADEO-2\1-1\Advance Database\PROJECT-FINAL\FINAL\TS_session_1.dbf' size 3M;

-- CREATING TABLESPACE TO SESSION_2
CREATE TABLESPACE TS_session_2 datafile'H:\Masters\ADEO-2\1-1\Advance Database\PROJECT-FINAL\FINAL\TS_session_2.dbf' size 3M;

-- ASSIGNING TABLESPACE TO SESSION_1	
ALTER USER session_1  DEFAULT TABLESPACE TS_session_1;

-- ASSIGNING TABLESPACE TO SESSION_2
ALTER USER session_2  DEFAULT TABLESPACE TS_session_2;


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


--=====================================================***************========================================================
--===================================================== END * END ========================================================
--=====================================================***************========================================================
	
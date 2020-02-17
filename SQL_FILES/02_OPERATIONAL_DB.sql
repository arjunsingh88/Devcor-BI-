--=====================================================***************========================================================
--===================================================== START * START ========================================================
--=====================================================***************========================================================
--===========================================================================================
-- Create the user account session_1
-- Grant connect, resource and DBA privileges
-- connecting to DBA
--===========================================================================================
--CREATE  USER session_1 IDENTIFIED BY session_1;
--GRANT  CONNECT, RESOURCE, dba TO session_1;
--GRANT SELECT ANY TABLE TO Session_2;
CONNECT session_1/session_1;

--===========================================================================================
--DROPING TABLES IF EXISTS
--===========================================================================================
DROP TABLE COUNTRY	 CASCADE CONSTRAINTS;
DROP TABLE REGION CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE CITY CASCADE CONSTRAINTS;
DROP TABLE CLIENTS CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE PURCHASE CASCADE CONSTRAINTS;

--===========================================================================================
--DROPING SEQUENCE IF EXISTS
--===========================================================================================

DROP SEQUENCE seq_country;
DROP SEQUENCE seq_region;
DROP SEQUENCE seq_department;
DROP SEQUENCE seq_city;
DROP SEQUENCE seq_clients;
DROP SEQUENCE seq_product;
DROP SEQUENCE seq_purchase;

--===========================================================================================
--DROPING PROCEDURE IF EXISTS
--===========================================================================================
DROP PROCEDURE data_city;
DROP PROCEDURE data_region;
DROP PROCEDURE data_client;
DROP PROCEDURE data_product;
DROP PROCEDURE data_purchase;
DROP PROCEDURE data_department;


--===========================================================================================
--  ************************************CREATING TABLES**************************************
--===========================================================================================

--===========================================================================================
--   Table : COUNTRY                                        
--===========================================================================================
CREATE TABLE COUNTRY
(
    COUNTRY_ID  VARCHAR(5)   NOT NULL, 
    COUNTRY_NAME  VARCHAR2(62) ,   
    CONSTRAINT pk_country PRIMARY KEY (COUNTRY_ID)
);

--===========================================================================================
--   Table : REGION
--===========================================================================================
CREATE TABLE REGION
(
    REGION_ID  NUMBER(9)  NOT NULL, 
    REGION_NAME  VARCHAR2(62) , 
    COUNTRY_ID VARCHAR(5),   
    CONSTRAINT pk_region PRIMARY KEY (REGION_ID)
);


--===========================================================================================
--   Table : DEPARTMENT                                            
--===========================================================================================
CREATE TABLE DEPARTMENT
(
    DEPARTMENT_ID  NUMBER(9)  NOT NULL, 
    DEPARTMENT_NAME VARCHAR2(62) ,
    REGION_ID  NUMBER(9),
    CONSTRAINT pk_department PRIMARY KEY (DEPARTMENT_ID)
);



--===========================================================================================
--   Table : CITY                                        
--===========================================================================================
CREATE TABLE CITY
(
ZIP_CODE	 NUMBER(9) NOT NULL,
CITY_NAME  VARCHAR2(10) ,
DEPARTMENT_ID  NUMBER(9),
CONSTRAINT pk_zip_city PRIMARY KEY (ZIP_CODE, CITY_NAME)
);

--===========================================================================================
--   Table : CLIENT                                            
--===========================================================================================
CREATE TABLE CLIENTS
(
    CLIENT_ID  NUMBER(9)   NOT NULL,
    FIRST_NAME   VARCHAR(62)   NOT NULL,
    LAST_NAME  VARCHAR(62)   NOT NULL,
    BIRTHDATE  DATE,
    GENDER   VARCHAR2(5) ,
    ZIP_CODE	 NUMBER(9),
    CITY_NAME  VARCHAR2(10) ,
    CONSTRAINT  pk_clients PRIMARY KEY (CLIENT_ID)
);

--===========================================================================================
--   Table : PRODUCT                                           
--===========================================================================================
CREATE TABLE PRODUCT
(
    PRODUCT_ID  NUMBER(9)  NOT NULL, 
    PROD_DESCRIPTION   VARCHAR2(30)   NOT NULL,
    PROD_PRICE   NUMBER(9)  NOT NULL,
    PROD_TYPE  VARCHAR2(9) NOT NULL,
    CONSTRAINT pk_product_id PRIMARY KEY (PRODUCT_ID)
);

--===========================================================================================
--   Table : PURCHASE
--===========================================================================================
CREATE TABLE PURCHASE
(
    QUANTITY  NUMBER(9)   NOT NULL,
    ZIP_CODE	 NUMBER(9),
    CITY_NAME  VARCHAR2(10),
    CLIENT_ID  NUMBER(9),
    PRODUCT_ID  NUMBER(9), 
    TIME_STAMP  TIMESTAMP  NOT NULL
);



--===========================================================================================
--   FOREIGN KEYS : ALL TABLES                                          
--   COUNTRY, REGION, DEPARTMENT, CITY, CLIENT, DELIVERY, PRODUCT
--===========================================================================================

ALTER TABLE REGION ADD CONSTRAINT fk1_region FOREIGN KEY (COUNTRY_ID)
       REFERENCES COUNTRY (COUNTRY_ID);
---------------------------------------------------------------------------------------
ALTER TABLE DEPARTMENT ADD CONSTRAINT fk1_department  FOREIGN KEY (REGION_ID)
       REFERENCES REGION (REGION_ID);
---------------------------------------------------------------------------------------
ALTER TABLE  CITY  ADD CONSTRAINT fk1_city  FOREIGN KEY (DEPARTMENT_ID)
       REFERENCES DEPARTMENT (DEPARTMENT_ID);
---------------------------------------------------------------------------------------
ALTER TABLE  CLIENTS  ADD CONSTRAINT fk2_clients FOREIGN KEY (ZIP_CODE, CITY_NAME)
       REFERENCES CITY (ZIP_CODE, CITY_NAME);
---------------------------------------------------------------------------------------
ALTER TABLE  PURCHASE  ADD CONSTRAINT fk1_purchase FOREIGN KEY (ZIP_CODE, CITY_NAME)
       REFERENCES CITY (ZIP_CODE, CITY_NAME);
---------------------------------------------------------------------------------------
ALTER TABLE PURCHASE  ADD CONSTRAINT fk2_purchase FOREIGN KEY (CLIENT_ID)
       REFERENCES CLIENTS(CLIENT_ID);
---------------------------------------------------------------------------------------       
ALTER TABLE  PURCHASE ADD CONSTRAINT fk3_purchase  FOREIGN KEY (PRODUCT_ID)
       REFERENCES PRODUCT(PRODUCT_ID);

--===========================================================================================
-- CREATING SEQUENCE
--===========================================================================================

CREATE SEQUENCE seq_country;
CREATE SEQUENCE seq_region;
CREATE SEQUENCE seq_department;
CREATE SEQUENCE seq_city;
CREATE SEQUENCE seq_clients;
CREATE SEQUENCE seq_product;
CREATE SEQUENCE seq_purchase;

--===========================================================================================
-- TURNING SERVER ON
--===========================================================================================

SET SERVEROUTPUT ON

--===========================================================================================
--***************************** INSERTING  DATA INTO COUNTRY TABLE*************************
--===========================================================================================


INSERT INTO  COUNTRY  VALUES ('AF', 'Afghanistan');
INSERT INTO  COUNTRY  VALUES ('AL', 'Albania');
INSERT INTO  COUNTRY  VALUES ('DZ', 'Algeria');
INSERT INTO  COUNTRY  VALUES ('DS', 'American Samoa');
INSERT INTO  COUNTRY  VALUES ('AD', 'Andorra');
INSERT INTO  COUNTRY  VALUES ('AO', 'Angola');
INSERT INTO  COUNTRY  VALUES ('AI', 'Anguilla');
INSERT INTO  COUNTRY  VALUES ('AQ', 'Antarctica');
INSERT INTO  COUNTRY  VALUES ('AG', 'Antigua and Barbuda');
INSERT INTO  COUNTRY  VALUES ('AR', 'Argentina');
INSERT INTO  COUNTRY  VALUES ('AM', 'Armenia');
INSERT INTO  COUNTRY  VALUES ('AW', 'Aruba');
INSERT INTO  COUNTRY  VALUES ('AU', 'Australia');
INSERT INTO  COUNTRY  VALUES ('AT', 'Austria');
INSERT INTO  COUNTRY  VALUES ('AZ', 'Azerbaijan');
INSERT INTO  COUNTRY  VALUES ('BS', 'Bahamas');
INSERT INTO  COUNTRY  VALUES ('BH', 'Bahrain');
INSERT INTO  COUNTRY  VALUES ('BD', 'Bangladesh');
INSERT INTO  COUNTRY  VALUES ('BB', 'Barbados');
INSERT INTO  COUNTRY  VALUES ('BY', 'Belarus');
INSERT INTO  COUNTRY  VALUES ('BE', 'Belgium');
INSERT INTO  COUNTRY  VALUES ('BZ', 'Belize');
INSERT INTO  COUNTRY  VALUES ('BJ', 'Benin');
INSERT INTO  COUNTRY  VALUES ('BM', 'Bermuda');
INSERT INTO  COUNTRY  VALUES ('BT', 'Bhutan');
INSERT INTO  COUNTRY  VALUES ('BO', 'Bolivia');
INSERT INTO  COUNTRY  VALUES ('BA', 'Bosnia and Herzegovina');
INSERT INTO  COUNTRY  VALUES ('BW', 'Botswana');
INSERT INTO  COUNTRY  VALUES ('BV', 'Bouvet Island');
INSERT INTO  COUNTRY  VALUES ('BR', 'Brazil');
INSERT INTO  COUNTRY  VALUES ('IO', 'British Indian Ocean Territory');
INSERT INTO  COUNTRY  VALUES ('BN', 'Brunei Darussalam');
INSERT INTO  COUNTRY  VALUES ('BG', 'Bulgaria');
INSERT INTO  COUNTRY  VALUES ('BF', 'Burkina Faso');
INSERT INTO  COUNTRY  VALUES ('BI', 'Burundi');
INSERT INTO  COUNTRY  VALUES ('KH', 'Cambodia');
INSERT INTO  COUNTRY  VALUES ('CM', 'Cameroon');
INSERT INTO  COUNTRY  VALUES ('CA', 'Canada');
INSERT INTO  COUNTRY  VALUES ('CV', 'Cape Verde');
INSERT INTO  COUNTRY  VALUES ('KY', 'Cayman Islands');
INSERT INTO  COUNTRY  VALUES ('CF', 'Central African Republic');
INSERT INTO  COUNTRY  VALUES ('TD', 'Chad');
INSERT INTO  COUNTRY  VALUES ('CL', 'Chile');
INSERT INTO  COUNTRY  VALUES ('CN', 'China');
INSERT INTO  COUNTRY  VALUES ('CX', 'Christmas Island');
INSERT INTO  COUNTRY  VALUES ('CC', 'Cocos (Keeling) Islands');
INSERT INTO  COUNTRY  VALUES ('CO', 'Colombia');
INSERT INTO  COUNTRY  VALUES ('KM', 'Comoros');
INSERT INTO  COUNTRY  VALUES ('CD', 'Democratic Republic of the Congo');
INSERT INTO  COUNTRY  VALUES ('CG', 'Republic of Congo');
INSERT INTO  COUNTRY  VALUES ('CK', 'Cook Islands');
INSERT INTO  COUNTRY  VALUES ('CR', 'Costa Rica');
INSERT INTO  COUNTRY  VALUES ('HR', 'Croatia (Hrvatska)');
INSERT INTO  COUNTRY  VALUES ('CU', 'Cuba');
INSERT INTO  COUNTRY  VALUES ('CY', 'Cyprus');
INSERT INTO  COUNTRY  VALUES ('CZ', 'Czech Republic');
INSERT INTO  COUNTRY  VALUES ('DK', 'Denmark');
INSERT INTO  COUNTRY  VALUES ('DJ', 'Djibouti');
INSERT INTO  COUNTRY  VALUES ('DM', 'Dominica');
INSERT INTO  COUNTRY  VALUES ('DO', 'Dominican Republic');
INSERT INTO  COUNTRY  VALUES ('TP', 'East Timor');
INSERT INTO  COUNTRY  VALUES ('EC', 'Ecuador');
INSERT INTO  COUNTRY  VALUES ('EG', 'Egypt');
INSERT INTO  COUNTRY  VALUES ('SV', 'El Salvador');
INSERT INTO  COUNTRY  VALUES ('GQ', 'Equatorial Guinea');
INSERT INTO  COUNTRY  VALUES ('ER', 'Eritrea');
INSERT INTO  COUNTRY  VALUES ('EE', 'Estonia');
INSERT INTO  COUNTRY  VALUES ('ET', 'Ethiopia');
INSERT INTO  COUNTRY  VALUES ('FK', 'Falkland Islands (Malvinas)');
INSERT INTO  COUNTRY  VALUES ('FO', 'Faroe Islands');
INSERT INTO  COUNTRY  VALUES ('FJ', 'Fiji');
INSERT INTO  COUNTRY  VALUES ('FI', 'Finland');
INSERT INTO  COUNTRY  VALUES ('FR', 'France');
INSERT INTO  COUNTRY  VALUES ('FX', 'France, Metropolitan');
INSERT INTO  COUNTRY  VALUES ('GF', 'French Guiana');
INSERT INTO  COUNTRY  VALUES ('PF', 'French Polynesia');
INSERT INTO  COUNTRY  VALUES ('TF', 'French Southern Territories');
INSERT INTO  COUNTRY  VALUES ('GA', 'Gabon');
INSERT INTO  COUNTRY  VALUES ('GM', 'Gambia');
INSERT INTO  COUNTRY  VALUES ('GE', 'Georgia');
INSERT INTO  COUNTRY  VALUES ('DE', 'Germany');
INSERT INTO  COUNTRY  VALUES ('GH', 'Ghana');
INSERT INTO  COUNTRY  VALUES ('GI', 'Gibraltar');
INSERT INTO  COUNTRY  VALUES ('GK', 'Guernsey');
INSERT INTO  COUNTRY  VALUES ('GR', 'Greece');
INSERT INTO  COUNTRY  VALUES ('GL', 'Greenland');
INSERT INTO  COUNTRY  VALUES ('GD', 'Grenada');
INSERT INTO  COUNTRY  VALUES ('GP', 'Guadeloupe');
INSERT INTO  COUNTRY  VALUES ('GU', 'Guam');
INSERT INTO  COUNTRY  VALUES ('GT', 'Guatemala');
INSERT INTO  COUNTRY  VALUES ('GN', 'Guinea');
INSERT INTO  COUNTRY  VALUES ('GW', 'Guinea-Bissau');
INSERT INTO  COUNTRY  VALUES ('GY', 'Guyana');
INSERT INTO  COUNTRY  VALUES ('HT', 'Haiti');
INSERT INTO  COUNTRY  VALUES ('HM', 'Heard and Mc Donald Islands');
INSERT INTO  COUNTRY  VALUES ('HN', 'Honduras');
INSERT INTO  COUNTRY  VALUES ('HK', 'Hong Kong');
INSERT INTO  COUNTRY  VALUES ('HU', 'Hungary');
INSERT INTO  COUNTRY  VALUES ('IS', 'Iceland');
INSERT INTO  COUNTRY  VALUES ('IN', 'India');
INSERT INTO  COUNTRY  VALUES ('IM', 'Isle of Man');
INSERT INTO  COUNTRY  VALUES ('ID', 'Indonesia');
INSERT INTO  COUNTRY  VALUES ('IR', 'Iran (Islamic Republic of)');
INSERT INTO  COUNTRY  VALUES ('IQ', 'Iraq');
INSERT INTO  COUNTRY  VALUES ('IE', 'Ireland');
INSERT INTO  COUNTRY  VALUES ('IL', 'Israel');
INSERT INTO  COUNTRY  VALUES ('IT', 'Italy');
INSERT INTO  COUNTRY  VALUES ('CI', 'Ivory Coast');
INSERT INTO  COUNTRY  VALUES ('JE', 'Jersey');
INSERT INTO  COUNTRY  VALUES ('JM', 'Jamaica');
INSERT INTO  COUNTRY  VALUES ('JP', 'Japan');
INSERT INTO  COUNTRY  VALUES ('JO', 'Jordan');
INSERT INTO  COUNTRY  VALUES ('KZ', 'Kazakhstan');
INSERT INTO  COUNTRY  VALUES ('KE', 'Kenya');
INSERT INTO  COUNTRY  VALUES ('KI', 'Kiribati');
INSERT INTO  COUNTRY  VALUES ('KP', 'Korea, Democratic People''s Republic of');
INSERT INTO  COUNTRY  VALUES ('KR', 'Korea, Republic of');
INSERT INTO  COUNTRY  VALUES ('XK', 'Kosovo');
INSERT INTO  COUNTRY  VALUES ('KW', 'Kuwait');
INSERT INTO  COUNTRY  VALUES ('KG', 'Kyrgyzstan');
INSERT INTO  COUNTRY  VALUES ('LA', 'Lao People''s Democratic Republic');
INSERT INTO  COUNTRY  VALUES ('LV', 'Latvia');
INSERT INTO  COUNTRY  VALUES ('LB', 'Lebanon');
INSERT INTO  COUNTRY  VALUES ('LS', 'Lesotho');
INSERT INTO  COUNTRY  VALUES ('LR', 'Liberia');
INSERT INTO  COUNTRY  VALUES ('LY', 'Libyan Arab Jamahiriya');
INSERT INTO  COUNTRY  VALUES ('LI', 'Liechtenstein');
INSERT INTO  COUNTRY  VALUES ('LT', 'Lithuania');
INSERT INTO  COUNTRY  VALUES ('LU', 'Luxembourg');
INSERT INTO  COUNTRY  VALUES ('MO', 'Macau');
INSERT INTO  COUNTRY  VALUES ('MK', 'North Macedonia');
INSERT INTO  COUNTRY  VALUES ('MG', 'Madagascar');
INSERT INTO  COUNTRY  VALUES ('MW', 'Malawi');
INSERT INTO  COUNTRY  VALUES ('MY', 'Malaysia');
INSERT INTO  COUNTRY  VALUES ('MV', 'Maldives');
INSERT INTO  COUNTRY  VALUES ('ML', 'Mali');
INSERT INTO  COUNTRY  VALUES ('MT', 'Malta');
INSERT INTO  COUNTRY  VALUES ('MH', 'Marshall Islands');
INSERT INTO  COUNTRY  VALUES ('MQ', 'Martinique');
INSERT INTO  COUNTRY  VALUES ('MR', 'Mauritania');
INSERT INTO  COUNTRY  VALUES ('MU', 'Mauritius');
INSERT INTO  COUNTRY  VALUES ('TY', 'Mayotte');
INSERT INTO  COUNTRY  VALUES ('MX', 'Mexico');
INSERT INTO  COUNTRY  VALUES ('FM', 'Micronesia, Federated States of');
INSERT INTO  COUNTRY  VALUES ('MD', 'Moldova, Republic of');
INSERT INTO  COUNTRY  VALUES ('MC', 'Monaco');
INSERT INTO  COUNTRY  VALUES ('MN', 'Mongolia');
INSERT INTO  COUNTRY  VALUES ('ME', 'Montenegro');
INSERT INTO  COUNTRY  VALUES ('MS', 'Montserrat');
INSERT INTO  COUNTRY  VALUES ('MA', 'Morocco');
INSERT INTO  COUNTRY  VALUES ('MZ', 'Mozambique');
INSERT INTO  COUNTRY  VALUES ('MM', 'Myanmar');
INSERT INTO  COUNTRY  VALUES ('NA', 'Namibia');
INSERT INTO  COUNTRY  VALUES ('NR', 'Nauru');
INSERT INTO  COUNTRY  VALUES ('NP', 'Nepal');
INSERT INTO  COUNTRY  VALUES ('NL', 'Netherlands');
INSERT INTO  COUNTRY  VALUES ('AN', 'Netherlands Antilles');
INSERT INTO  COUNTRY  VALUES ('NC', 'New Caledonia');
INSERT INTO  COUNTRY  VALUES ('NZ', 'New Zealand');
INSERT INTO  COUNTRY  VALUES ('NI', 'Nicaragua');
INSERT INTO  COUNTRY  VALUES ('NE', 'Niger');
INSERT INTO  COUNTRY  VALUES ('NG', 'Nigeria');
INSERT INTO  COUNTRY  VALUES ('NU', 'Niue');
INSERT INTO  COUNTRY  VALUES ('NF', 'Norfolk Island');
INSERT INTO  COUNTRY  VALUES ('MP', 'Northern Mariana Islands');
INSERT INTO  COUNTRY  VALUES ('NO', 'Norway');
INSERT INTO  COUNTRY  VALUES ('OM', 'Oman');
INSERT INTO  COUNTRY  VALUES ('PK', 'Pakistan');
INSERT INTO  COUNTRY  VALUES ('PW', 'Palau');
INSERT INTO  COUNTRY  VALUES ('PS', 'Palestine');
INSERT INTO  COUNTRY  VALUES ('PA', 'Panama');
INSERT INTO  COUNTRY  VALUES ('PG', 'Papua New Guinea');
INSERT INTO  COUNTRY  VALUES ('PY', 'Paraguay');
INSERT INTO  COUNTRY  VALUES ('PE', 'Peru');
INSERT INTO  COUNTRY  VALUES ('PH', 'Philippines');
INSERT INTO  COUNTRY  VALUES ('PN', 'Pitcairn');
INSERT INTO  COUNTRY  VALUES ('PL', 'Poland');
INSERT INTO  COUNTRY  VALUES ('PT', 'Portugal');
INSERT INTO  COUNTRY  VALUES ('PR', 'Puerto Rico');
INSERT INTO  COUNTRY  VALUES ('QA', 'Qatar');
INSERT INTO  COUNTRY  VALUES ('RE', 'Reunion');
INSERT INTO  COUNTRY  VALUES ('RO', 'Romania');
INSERT INTO  COUNTRY  VALUES ('RU', 'Russian Federation');
INSERT INTO  COUNTRY  VALUES ('RW', 'Rwanda');
INSERT INTO  COUNTRY  VALUES ('KN', 'Saint Kitts and Nevis');
INSERT INTO  COUNTRY  VALUES ('LC', 'Saint Lucia');
INSERT INTO  COUNTRY  VALUES ('VC', 'Saint Vincent and the Grenadines');
INSERT INTO  COUNTRY  VALUES ('WS', 'Samoa');
INSERT INTO  COUNTRY  VALUES ('SM', 'San Marino');
INSERT INTO  COUNTRY  VALUES ('ST', 'Sao Tome and Principe');
INSERT INTO  COUNTRY  VALUES ('SA', 'Saudi Arabia');
INSERT INTO  COUNTRY  VALUES ('SN', 'Senegal');
INSERT INTO  COUNTRY  VALUES ('RS', 'Serbia');
INSERT INTO  COUNTRY  VALUES ('SC', 'Seychelles');
INSERT INTO  COUNTRY  VALUES ('SL', 'Sierra Leone');
INSERT INTO  COUNTRY  VALUES ('SG', 'Singapore');
INSERT INTO  COUNTRY  VALUES ('SK', 'Slovakia');
INSERT INTO  COUNTRY  VALUES ('SI', 'Slovenia');
INSERT INTO  COUNTRY  VALUES ('SB', 'Solomon Islands');
INSERT INTO  COUNTRY  VALUES ('SO', 'Somalia');
INSERT INTO  COUNTRY  VALUES ('ZA', 'South Africa');
INSERT INTO  COUNTRY  VALUES ('GS', 'South Georgia South Sandwich Islands');
INSERT INTO  COUNTRY  VALUES ('SS', 'South Sudan');
INSERT INTO  COUNTRY  VALUES ('ES', 'Spain');
INSERT INTO  COUNTRY  VALUES ('LK', 'Sri Lanka');
INSERT INTO  COUNTRY  VALUES ('SH', 'St. Helena');
INSERT INTO  COUNTRY  VALUES ('PM', 'St. Pierre and Miquelon');
INSERT INTO  COUNTRY  VALUES ('SD', 'Sudan');
INSERT INTO  COUNTRY  VALUES ('SR', 'Suriname');
INSERT INTO  COUNTRY  VALUES ('SJ', 'Svalbard and Jan Mayen Islands');
INSERT INTO  COUNTRY  VALUES ('SZ', 'Swaziland');
INSERT INTO  COUNTRY  VALUES ('SE', 'Sweden');
INSERT INTO  COUNTRY  VALUES ('CH', 'Switzerland');
INSERT INTO  COUNTRY  VALUES ('SY', 'Syrian Arab Republic');
INSERT INTO  COUNTRY  VALUES ('TW', 'Taiwan');
INSERT INTO  COUNTRY  VALUES ('TJ', 'Tajikistan');
INSERT INTO  COUNTRY  VALUES ('TZ', 'Tanzania, United Republic of');
INSERT INTO  COUNTRY  VALUES ('TH', 'Thailand');
INSERT INTO  COUNTRY  VALUES ('TG', 'Togo');
INSERT INTO  COUNTRY  VALUES ('TK', 'Tokelau');
INSERT INTO  COUNTRY  VALUES ('TO', 'Tonga');
INSERT INTO  COUNTRY  VALUES ('TT', 'Trinidad and Tobago');
INSERT INTO  COUNTRY  VALUES ('TN', 'Tunisia');
INSERT INTO  COUNTRY  VALUES ('TR', 'Turkey');
INSERT INTO  COUNTRY  VALUES ('TM', 'Turkmenistan');
INSERT INTO  COUNTRY  VALUES ('TC', 'Turks and Caicos Islands');
INSERT INTO  COUNTRY  VALUES ('TV', 'Tuvalu');
INSERT INTO  COUNTRY  VALUES ('UG', 'Uganda');
INSERT INTO  COUNTRY  VALUES ('UA', 'Ukraine');
INSERT INTO  COUNTRY  VALUES ('AE', 'United Arab Emirates');
INSERT INTO  COUNTRY  VALUES ('GB', 'United Kingdom');
INSERT INTO  COUNTRY  VALUES ('US', 'United States');
INSERT INTO  COUNTRY  VALUES ('UM', 'United States minor outlying islands');
INSERT INTO  COUNTRY  VALUES ('UY', 'Uruguay');
INSERT INTO  COUNTRY  VALUES ('UZ', 'Uzbekistan');
INSERT INTO  COUNTRY  VALUES ('VU', 'Vanuatu');
INSERT INTO  COUNTRY  VALUES ('VA', 'Vatican City State');
INSERT INTO  COUNTRY  VALUES ('VE', 'Venezuela');
INSERT INTO  COUNTRY  VALUES ('VN', 'Vietnam');
INSERT INTO  COUNTRY  VALUES ('VG', 'Virgin Islands (British)');
INSERT INTO  COUNTRY  VALUES ('VI', 'Virgin Islands (U.S.)');
INSERT INTO  COUNTRY  VALUES ('WF', 'Wallis and Futuna Islands');
INSERT INTO  COUNTRY  VALUES ('EH', 'Western Sahara');
INSERT INTO  COUNTRY  VALUES ('YE', 'Yemen');
INSERT INTO  COUNTRY  VALUES ('ZM', 'Zambia');
INSERT INTO  COUNTRY  VALUES ('ZW', 'Zimbabwe');


--===========================================================================================
--***************************** INSERTING  DATA INTO REGION TABLE *************************
--===========================================================================================
CREATE OR REPLACE PROCEDURE data_region  AS 
	M_REGION_NAME  VARCHAR2(62); 
    M_REGION_ID  NUMBER(9);
	M_COUNTRY_ID VARCHAR(10);
	BEGIN
		FOR i IN 1..2460 
			LOOP
				M_REGION_ID  := seq_region.nextval;
				SELECT dbms_random.STRING('A', 10) INTO M_REGION_NAME FROM dual;
				SELECT COUNTRY_ID INTO M_COUNTRY_ID  FROM ( SELECT COUNTRY_ID FROM COUNTRY ORDER BY dbms_random.value ) WHERE rownum = 1;
				INSERT INTO REGION VALUES(M_REGION_ID,M_REGION_NAME, M_COUNTRY_ID);  
			END LOOP;
  
	END data_region;
	/

	EXEC data_region;
	
SELECT COUNT(*) FROM REGION;
--===========================================================================================
--***************** INSERTING  DATA INTO DEPARTMENT TABLE *************************
--===========================================================================================

CREATE OR REPLACE PROCEDURE data_department  AS 

    M_DEPARTMENT_ID  NUMBER(9);
    M_DEPARTMENT_NAME VARCHAR2(62);
    M_REGION_ID  NUMBER(9);
	num_1 INTEGER;
BEGIN
FOR i IN 1..1000
  LOOP
   ------------ CREATING RANDOM DEPARTMENT  ------------
    	num_1 := dbms_random.value(1,31);
	    M_DEPARTMENT_NAME  := (CASE num_1
		WHEN 1 THEN 'deptname1'
		WHEN 2 THEN 'deptname2'
		WHEN 3 THEN 'deptname3'
		WHEN 4 THEN 'deptname4'
		WHEN 5 THEN 'deptname5'
		WHEN 6 THEN 'deptname6'
		WHEN 7 THEN 'deptname7'
		WHEN 8 THEN 'deptname8'
		WHEN 10 THEN 'deptname9'
		WHEN 11 THEN 'deptname10'
		WHEN 12 THEN 'deptname11'
		WHEN 13 THEN 'deptname12'
		WHEN 14 THEN 'deptname13'
		WHEN 15 THEN 'deptname14'
		WHEN 16 THEN 'deptname15'
		WHEN 17 THEN 'deptname16'
		WHEN 18 THEN 'deptname17'
		WHEN 19 THEN 'deptname18'
		WHEN 20 THEN 'deptname19'
		WHEN 21 THEN 'deptname20'
		WHEN 22 THEN 'deptname21'
		WHEN 23 THEN 'deptname22'
		WHEN 24 THEN 'deptname23'
		WHEN 25 THEN 'deptname24'
		WHEN 26 THEN 'deptname25'
		WHEN 27 THEN 'deptname26'
		WHEN 28 THEN 'deptname27'
		WHEN 29 THEN 'deptname28'
		WHEN 30 THEN 'deptname29'
		WHEN 31 THEN 'deptname30'
	END); 
	
		M_DEPARTMENT_ID  := seq_department.nextval;
		SELECT REGION_ID INTO M_REGION_ID  FROM ( SELECT REGION_ID FROM REGION ORDER BY dbms_random.value ) WHERE rownum = 1;
        INSERT INTO department VALUES(M_DEPARTMENT_ID,M_DEPARTMENT_NAME, M_REGION_ID);
 END LOOP;
  
END data_department;
/

EXEC data_department;

SELECT COUNT(*) FROM DEPARTMENT;
--===========================================================================================
--*********************** INSERTING  DATA INTO CITY TABLE **********************************
--===========================================================================================
CREATE OR REPLACE PROCEDURE data_city  AS 

    M_ZIP_CODE	 NUMBER(9);
    M_CITY_NAME  VARCHAR2(10); 
	M_DEPARTMENT_ID  NUMBER(9);
	num_1 INTEGER;
	
BEGIN	
FOR i IN 1..2000
  LOOP
	  ------------ CREATING RANDOM ZIPCODE  ------------
	
	M_ZIP_CODE  := seq_department.nextval;
             ------------ CREATING RANDOM CITY  ------------ 
	num_1 := dbms_random.value(1,20);
	 M_CITY_NAME  := (CASE num_1
		WHEN 1 THEN 'city1'
		WHEN 2 THEN 'city2'
        WHEN 3 THEN 'city3'
		WHEN 4 THEN 'city4'
		WHEN 5 THEN 'cityy5'
        WHEN 6 THEN 'city6 '
        WHEN 7 THEN 'city7 '
        WHEN 8 THEN 'city8 '
        WHEN 9 THEN 'city9 '
        WHEN 10 THEN 'city10 '
        WHEN 11 THEN 'city11 '
        WHEN 12 THEN 'city12 '
        WHEN 13 THEN 'city13 '
        WHEN 14 THEN 'city14 '
        WHEN 15 THEN 'city15 '
        WHEN 16 THEN 'city16 '
        WHEN 17 THEN 'city17 '
        WHEN 18 THEN 'city18 '
        WHEN 19 THEN 'city19 '
        WHEN 20 THEN 'city20 '
        WHEN 21 THEN 'city21 '
        WHEN 22 THEN 'city22 '
        WHEN 23 THEN 'city23 '
        WHEN 24 THEN 'city24 '
        WHEN 25 THEN 'city25 '
        WHEN 26 THEN 'city26 '
        WHEN 27 THEN 'city27 '
        WHEN 28 THEN 'city28 '
        WHEN 29 THEN 'city29 '
        WHEN 30 THEN 'city30 '
        WHEN 31 THEN 'city31 '
        WHEN 32 THEN 'city32 '
        WHEN 33 THEN 'city33 '
        WHEN 34 THEN 'city34 '
        WHEN 35 THEN 'city35 '
        WHEN 36 THEN 'city36 '
        WHEN 37 THEN 'city37 '
        WHEN 38 THEN 'city38 '
        WHEN 39 THEN 'city39 '
        WHEN 40 THEN 'city40 '
        WHEN 41 THEN 'city41 '
        WHEN 42 THEN 'city42 '
        WHEN 43 THEN 'city43 '
        WHEN 44 THEN 'city44 '
        WHEN 45 THEN 'city45 '
        WHEN 46 THEN 'city46 '
        WHEN 47 THEN 'city47 '
        WHEN 48 THEN 'city48 '
        WHEN 49 THEN 'city49'
        WHEN 50 THEN 'city50 '     
	END); 
		
	  SELECT DEPARTMENT_ID INTO M_DEPARTMENT_ID  FROM ( SELECT DEPARTMENT_ID FROM DEPARTMENT ORDER BY dbms_random.value ) WHERE rownum = 1;	
	  
      INSERT INTO city VALUES(M_ZIP_CODE,M_CITY_NAME,M_DEPARTMENT_ID);
	
	  END LOOP;
  
END data_city;
/

EXEC data_city;

SELECT COUNT(*) FROM CITY;
--===========================================================================================
--*********************** INSERTING  DATA INTO CLIENT TABLE **********************************
--===========================================================================================

CREATE OR REPLACE PROCEDURE data_client  AS
	M_ZIP_CODE	 NUMBER(9);
    M_CITY_NAME  VARCHAR2(10); 
	num_1 INTEGER;
    M_CLIENT_ID  NUMBER(9);
    M_FIRST_NAME   VARCHAR(62);
    M_LAST_NAME  VARCHAR(62);
    M_BIRTHDATE  DATE;
    M_GENDER   VARCHAR2(5); 
	
BEGIN		
FOR i IN 1..2500
  LOOP
    ------------ CREATING RANDOM GENDER  ------------
    num_1  := dbms_random.value(1,2);
	M_GENDER  := (CASE num_1
		WHEN 1 THEN 'M'
		WHEN 2 THEN 'F'
	END);
	SELECT TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '1970-01-01','J')
                                    ,TO_CHAR(DATE '2019-12-31','J')
                                    )
                    ),'J'
               ) INTO M_BIRTHDATE FROM DUAL;
	
   M_CLIENT_ID  := seq_clients.nextval;
   
   
   SELECT ZIP_CODE, CITY_NAME INTO M_ZIP_CODE,M_CITY_NAME FROM ( SELECT city.ZIP_CODE, city.CITY_NAME FROM city WHERE city.CITY_NAME LIKE '%' 
   ORDER BY dbms_random.value ) WHERE ROWNUM < 2; 
   
   SELECT dbms_random.STRING('A', 10) into M_FIRST_NAME from dual;
   SELECT dbms_random.STRING('A', 10) into M_LAST_NAME from dual;
   
   INSERT INTO clients  VALUES(M_CLIENT_ID,M_FIRST_NAME, M_LAST_NAME,M_BIRTHDATE,M_GENDER,M_ZIP_CODE,M_CITY_NAME); 
	
   
	  END LOOP;
  
END data_client;
/

EXEC data_client;

SELECT COUNT(*) FROM CLIENTS;



--===========================================================================================
--*********************** INSERTING  DATA INTO PRODUCT TABLE **********************************
--===========================================================================================	
	
	CREATE OR REPLACE PROCEDURE data_product  AS
	
	M_PRODUCT_ID  NUMBER(9);
    M_PROD_DESCRIPTION   VARCHAR2(30);
    M_PROD_PRICE   NUMBER(9);
    M_PROD_TYPE  VARCHAR2(9);
	M_QUANTITY  NUMBER(9);
	num_1 INTEGER;
	
	BEGIN

	FOR i IN 1..3000
		LOOP
 
	
    
		------------ CREATING RANDOM PRODUCT DESCRIPTION  ------------
		num_1 := dbms_random.value(1,5);
		M_PROD_DESCRIPTION  := (CASE num_1
		WHEN 1 THEN 'Proddes1'
		WHEN 2 THEN 'Proddes2'
		WHEN 3 THEN 'Proddes3'
		WHEN 4 THEN 'Proddes4'
		WHEN 5 THEN 'Proddes5'
		END);
    
		------------ CREATING RANDOM PRODUCT PRICE  ------------
		num_1 := round(dbms_random.value(1,9999));
		M_PROD_PRICE  := num_1;
     
    -	----------- CREATING RANDOM PRODUCT TYPE  ------------
    	num_1 := dbms_random.value(1,5);
		M_PROD_TYPE  := (CASE num_1
		WHEN 1 THEN 'prod1'
		WHEN 2 THEN 'prod2'
		WHEN 3 THEN 'prod3'
		WHEN 4 THEN 'prod4'
		WHEN 5 THEN 'prod5'
		END);
		
		M_PRODUCT_ID  := seq_product.nextval;
		
		   INSERT INTO PRODUCT VALUES(M_PRODUCT_ID,M_PROD_DESCRIPTION,M_PROD_PRICE,M_PROD_TYPE);
		
		  END LOOP;
  
END data_product;
/

EXEC data_product;

SELECT COUNT(*) FROM PRODUCT;	
--===========================================================================================
--*********************** INSERTING  DATA INTO PURCHASE TABLE **********************************
--===========================================================================================	
	

CREATE OR REPLACE PROCEDURE data_purchase  AS 
	
    M_ZIP_CODE	 NUMBER(9);
    M_CITY_NAME  VARCHAR2(10); 
    M_CLIENT_ID  NUMBER(9);
    M_QUANTITY  NUMBER(9);  
    M_TIME_STAMP  TIMESTAMP;
    M_PRODUCT_ID  NUMBER(9);
    num_1 INTEGER;
     
BEGIN

  FOR i IN 1..3000
  LOOP
  
  	------------ CREATING RANDOM QUANTITY  ------------
		num_1 := round(dbms_random.value(1,100));
		
		M_QUANTITY  := num_1;
		
   SELECT ZIP_CODE, CITY_NAME INTO M_ZIP_CODE,M_CITY_NAME FROM ( SELECT city.ZIP_CODE, city.CITY_NAME FROM city WHERE city.CITY_NAME LIKE '%' 
   ORDER BY dbms_random.value ) WHERE ROWNUM < 2; 
   
   SELECT CLIENT_ID INTO M_CLIENT_ID FROM ( SELECT CLIENT_ID FROM CLIENTS ORDER BY dbms_random.value ) WHERE rownum = 1;
   SELECT PRODUCT_ID INTO M_PRODUCT_ID FROM ( SELECT PRODUCT_ID FROM PRODUCT ORDER BY dbms_random.value ) WHERE rownum = 1;
   SELECT TO_DATE('01-01-2009','mm-dd-yyyy') + dbms_random.VALUE(0,86400*(to_date('01-JAN-2009', 'dd-mm-yyyy') -
	to_date('10-DEC-2019', 'dd-mm-yyyy'))+1)/86400 INTO M_TIME_STAMP FROM dual; 	
   INSERT INTO purchase VALUES(M_QUANTITY,M_ZIP_CODE,M_CITY_NAME, M_CLIENT_ID,  M_PRODUCT_ID,M_TIME_STAMP); 
    
  end loop;
  
END data_purchase;
/

EXEC data_purchase;

SELECT COUNT(*) FROM PURCHASE;	
--===========================================================================================
--*********************** SELECTING DATA IN COUNT **********************************
--===========================================================================================	

desc COUNTRY;	
SELECT COUNT(*) FROM COUNTRY;
desc REGION;
SELECT COUNT(*) FROM REGION;
desc DEPARTMENT;
SELECT COUNT(*) FROM DEPARTMENT;
desc CITY;
SELECT COUNT(*) FROM CITY;
desc CLIENTS;
SELECT COUNT(*) FROM CLIENTS;
desc PRODUCT;
SELECT COUNT(*) FROM PRODUCT;
desc PURCHASE;
SELECT COUNT(*) FROM PURCHASE;


SELECT * From DBA_DATA_FILES;


--=====================================================***************========================================================
--===================================================== END * END ========================================================
--=====================================================***************========================================================

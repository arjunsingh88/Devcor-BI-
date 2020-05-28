# Devcor BI(database modeling and building)
The purpose of this project is to implement the learnings from PL/SQL and apply it to demo case of DEVECOR. Our objective is to build operational database do the ETL and build warehouse with DataMart’s. But for this case we replicate the framework of data warehouse with 2 databases and pushing the data after cleaning and then building the small tables needed by the respective department.

## Requirements

1.	Operational database for company 
    1. The script for creating tables in the operational database 
    2. The script of my procedure that will generate the dataset. 
    3. And finally you give the privileges to the session 2 to read the contents of the created tables

2.	Decisional database for the management of the company
    1. The script for creating the tables of the decision database 
    2. The script of the procedure that will select to give them from the operational database to put them in the decision-making database (ETL).

3.	Expression of needs 
The sales manager wants: 
    1. To study the turnover and sales volume 
    2. By product and Family. 
    3. Per week, month and year. 
    4. By department and region. 

4.	A procedure to generate
    1. Supply chain analysis (Inventory, sales in a given time period) 

## Data Model
|Type|Data Model|
|--|--|
|`Operational Database`|![db1](https://user-images.githubusercontent.com/45566835/83139404-9a51ce80-a0ec-11ea-8855-6fa470dd6a9d.jpg)|
|`Decisional Database`|![DB2](https://user-images.githubusercontent.com/45566835/83139405-9aea6500-a0ec-11ea-91f4-11f49461460f.jpg)|

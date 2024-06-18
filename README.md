# World Layoffs in mySQL
Since 2020, there has been a significant increase in layoffs around the world. This database shows layoffs from multiple companies at various stages of development worldwide. I was interested in undertaking this project to understand which countries have seen the highest number of layoffs and in which types of industries and companies the most layoffs have occurred.

# Data Cleaning
After converting my CSV file to a JSON file, these were the steps I followed to clean the data:
1. Create a copy of the database.
2. Delete duplicates from databases: using a Common Table Expression (CTEs).
3. Standardize the data:
   * Used the TRIM function because there were leading spaces in some data.
   * Used the DISTINCT function because there were inconsistencies in the format of the industry column.
   * Used UPDATE and STR_TO_DATE to change the date format to %m, %d, %Y.
5. Check if there were any blank or NULL data in the database to remove them or populate them if posible.
   * When converting the CSV file to JSON, we first had to convert the string "NULL" to a NULL value using the UPDATE function.
   * Populated the data for companies like Airbnb that had usable data in other rows.
7. Remove unnecessary columns from the database (mostly the columns I created in the first step to review the duplicates).

See code: https://github.com/liannfinlayson26/World-Layoffs-Analysis-SQL/blob/main/Data%20Cleaning%201.sql

# Data Exploration
See code: https://github.com/liannfinlayson26/World-Layoffs-Analysis-SQL/blob/main/Data_Exploration_Layoffs.sql

Antes de hacer queries realice una conversión de los datos de columnas que tenían formato text a integer utilizando la función ALTER TABLE. Luego realice múltiples queries para obtener la siguiente información: 
1. La máxima cantidad de despidos en un día: 12,000
2. Reconocer cuáles compañías tenían un laifoff total: Katerra is the company with the most laid off people 2,434
3. Cuáles son los fondos raised in millions de estas compañías: companies like Britishvolt and Quibi got funds by 2.4B and 1.8B 
4. Las companías con mayor cantidad de layoffs: Amazon con 18,


# Visualization
To see the Interactive Tableau visualization go to:
https://public.tableau.com/app/profile/liann.finlayson4647/viz/WorldLayoffs_17186015941360/Dashboard1


# Sources:
Alex the Analyst database
CSV to JSON converter: https://csvjson.com/csv2json

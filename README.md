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

Before running queries, I converted data from columns formatted as text to integer using the ALTER TABLE function. Then, I ran multiple queries to obtain the following information:

1. The maximum number of layoffs in a single day: 12,000
2. Identified companies with total layoffs: Katerra is the company with the most layoffs, 2,434 people.
3. Funds raised in millions by these companies: Companies like Britishvolt and Quibi raised funds of 2.4B and 1.8B, respectively.
4. Companies with the highest number of layoffs: Amazon with 18,150 layoffs, followed by Google with 12,000 and Meta with 11,000.
5. Understanding the date range: From the year 2020 (pandemic) to the year 2023.
6. Industries most affected: Consumer and Retail.
7. Industries least affected: Manufacturing, Fin-tech, Aerospace, Energy.
8. Country with the highest number of layoffs: United States with 256,559 people.
9. Country with the lowest number of layoffs: Poland with 25 people.
10. Total layoffs each year:
    - Year 2020: 80,998
    - Year 2021: 15,823
    - Year 2022: 160,661
    - Year 2023: 125,677
    <br/>Concluding that 2022 had the highest number of layoffs with 160k.
11. The highest number of layoffs per company during each year 2020, 2021, 2022, and 2023:
    - Year 2020: Uber with 7,525 layoffs
    - Year 2021: Bytedance with 3,600 layoffs
    - Year 2022: Meta with 11,000 layoffs
    - Year 2023: Google with 12,000 layoffs

# Visualization
To see the Interactive Tableau visualization go to:
<br/>https://public.tableau.com/app/profile/liann.finlayson4647/viz/WorldLayoffs_17186015941360/Dashboard1

# Sources:
Alex the Analyst database
<br/>CSV to JSON converter: https://csvjson.com/csv2json

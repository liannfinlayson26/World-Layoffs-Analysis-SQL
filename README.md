# World Layoffs in mySQL
Since 2020, there has been a significant increase in layoffs around the world. This database shows layoffs from multiple companies at various stages of development worldwide. I was interested in undertaking this project to understand which countries have seen the highest number of layoffs and in which types of industries and companies the most layoffs have occurred.

# Data Cleaning
</br> After converting my CSV file to a JSON file, these were the steps I followed to clean the data::

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

</br> 



# Visualization
</br> To see the Interactive Tableau visualization go to:
https://public.tableau.com/app/profile/liann.finlayson4647/viz/WorldLayoffs_17186015941360/Dashboard1



# Sources:
</br> Alex the Analyst database

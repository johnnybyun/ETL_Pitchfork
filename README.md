# **ETL Pitchfork Project Report**


<img src="assets\rolling_stone_icon.png" width="200"> <img src="assets\plus-sign-png.png" width="50"> <img src="assets\pitchfork.svg" width="200">

## **Team Members:  Satvik Ajmera, John Byun, Molly Cox**

## **Project Description:**
We chose 2 datasets found on Kaggle:  a .csv file with *__Rolling Stone Magazine's top 500 albums of all time__*, 
and a .sqlite database of online magazine *__Pitchfork's__* album reviews.  The goal was to join the Rolling Stones Albums
to the corresponding Pitchfork reviews.

Pitchfork data can be found at:  	https://www.kaggle.com/nolanbconaway/pitchfork-data  
Rolling Stone data can be found at: https://www.kaggle.com/notgibs/500-greatest-albums-of-all-time-rolling-stone   

## **E**xtracting Data
First, we loaded the Pitchfork data into a Pandas dataframe.  For the sqlite database, we imported sqlite3 to read the files.
The database contains 6 tables, each with a review id to link all the files together.  We selected fields from the
reviews table (reviewid, title, artist, url, score, author, and pub_date) and the genres table (genre), joining the 
2 tables by reviewid.

Second, we loaded the Rolling Stone Album data from a .csv file into a Pandas dataframe using pd.read_csv(csv_file,encoding= 'unicode_escape'). 
From this dataset, we were interested in 5 fields (Number, Year, Album, Artist, Subgenre)
Once the data was loaded into pandas dataframes, we renamed some of the columns for consistency. The Pitchfork table had duplicate review ids, 
so we dropped the duplicates.

## **T**ransforming Data
The tricky part came next: 

In order to join the tables on album name, it was apparent from an initial glance that the album name data would need to be cleaned before attempting a merge.  First, we would need to match cases.  We lowercased the album names in the Rolling Stone table to match the all-lowercase Pitchfork data.  We tried the merge and came up with only 93 matches.  Furthermore, many of those were false matches because of cases where different artists used the same album names (e.g. "greatest hits", etc.).  To resolve this, we concatenated the artist names with album names to generate more unique values.  Also we removed whitespaces and non alphanumeric characters to minimize the effect of punctuation and spacing differences.  This time we got 94 matches,  but these were true exact matches which was an improvement of about 10%.  

We could see just from visual inspection of the data that there were many more albums that were not being matched due to slight differences in the way the albums were named in each table (e.g. "princepurplerain" vs "princepurpleraindeluxeedition").  We did some googling to see if there were any tools that could match strings that are similar but not exactly the same. We found a library called "fuzzywuzzy" that, given two strings, outputs a so called "Levenshtein distance" (which is a similarity score between -1 and 100, with 100 being an exact match) and pulls in all matches above a threshold that you choose.  We first chose a threshold of 65, which pulled in 249 matches but there were many false matches.  We tried again with a threshold of 80, which pulled in 121 matches.  This resulted in 10 false matches.  So we manually dropped the 10 falsely matched rows and ended up with 111 matches, which was another 15%.  We were now at about 25% improvement from our starting point we decided to stop here and just move on with our project. 

Rolling Stone row with a matching Pitchfork row. Out of the 500 artists/albums in the Rolling Stones dataset, we found only 93 matches.
We kept all 500 Rolling Stone rows and added the Pitchfork data if it matched.

Looking at the artist names, out of the 289 unique artist names, 165 were found in the Pitchfork database.
Looking at the album names, the Rolling Stone album name was more generic, while the Pitchfork album name added words like 
":40th Anniversary addition" and "Deluxe Addition". Can these be considered the same albums?

## **L**oading Data
Finally, we created  3 tables in Postgres: a rolling_stone table, a pitchfork_reviews table, and a merged table of all 500 Rolling Stone albums with the matching Pitchfork reviews.  

## **Files used:**
- Jupyter Notebook to perform the Extract/Transform/Load:  etl_notebook_final.ipynb
- Rolling Stone 500 Albums:                               \Resources\albumlist.csv  
- Pitchfork Reviews:                                       \Resources\database.sqlite
- Postgres database schema:                                schema.sql
- Postgres database:                                       etl_music_db

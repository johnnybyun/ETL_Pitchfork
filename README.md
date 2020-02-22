# ETL Pitchfork Project Report

Rolling Stone Magazine:
<!--![Image of Rolling Stone]
(https://lh3.googleusercontent.com/proxy/zJc85AzYK0YeFmDrEAXiaSRGysj5k2SdZ5PbQl0zX_UGOh6oEjxmBpamYUrAmHDreVIYKFQLOzszyjyXQu-yFPkSydmScHv1pR54Jh-Kv0O-5M5DSJQ) -->
<img src="https://lh3.googleusercontent.com/proxy/zJc85AzYK0YeFmDrEAXiaSRGysj5k2SdZ5PbQl0zX_UGOh6oEjxmBpamYUrAmHDreVIYKFQLOzszyjyXQu-yFPkSydmScHv1pR54Jh-Kv0O-5M5DSJQ" width="200">

Pitchfork:
<!--![Image of Pitchfork](https://image.flaticon.com/icons/svg/96/96351.svg)-->
<img src="https://image.flaticon.com/icons/svg/96/96351.svg" width="200">

## Team Members:  Satvik Ajmera, John Byun, Molly Cox

##Project Description:
We chose 2 datasets found on Kaggle:  a .csv file with *__Rolling Stone Magazine's top 500 albums of all time__*, 
and a .sqlite database of online magazine *__Pitchfork's__* album reviews.  The goal was to join the Rolling Stones Albums
to the corresponding Pitchfork reviews.

Pitchfork data can be found at:  	https://www.kaggle.com/nolanbconaway/pitchfork-data
Rolling Stone data can be found at: https://www.kaggle.com/notgibs/500-greatest-albums-of-all-time-rolling-stone 

First, we loaded the Pitchfork data into a Pandas dataframe.  For the sqlite database, we imported sqlite3 to read the files.
The database contains 6 tables, each with a review id to link all the files together.  We selected fields from the
reviews table (reviewid, title, artist, url, score, author, and pub_date) and the genres table (genre), joining the 
2 tables by reviewid.

Second, we loaded the Rolling Stone Album data from a .csv file into a Pandas dataframe using pd.read_csv(csv_file,encoding= 'unicode_escape'). 
From this dataset, we were interested in 5 fields (Number, Year, Album, Artist, Subgenre)
Once the data was loaded into pandas dataframes, we renamed some of the columns for consistency. The Pitchfork table had duplicate review ids, 
so we dropped the duplicates.

The tricky part came next:  we concatenated the artist and album fields in both datasets, made them all lower case, and joined the 
Rolling Stone row with a matching Pitchfork row. Out of the 500 artists/albums in the Rolling Stones dataset, we found only 93 matches.
We kept all 500 Rolling Stone rows and added the Pitchfork data if it matched.

Looking at the artist names, out of the 289 unique artist names, 165 were found in the Pitchfork database.
Looking at the album names, the Rolling Stone album name was more generic, while the Pitchfork album name added words like 
":40th Anniversary addition" and "Deluxe Addition". Can these be considered the same albums?

Finally, we created tables in Postgres, and loaded the merged dataset into that database.

Jupyter Notebook to perform the Extract/Transform/Load:  etl_john_2.19.ipynb

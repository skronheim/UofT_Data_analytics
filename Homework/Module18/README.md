## Table of Contents

1. Purpose
2. Data Sources
3. Data Cleaning Instructions
4. Analysis

## Purpose

This code is written in Python for use with Pandas and several other packages to clean CitiBike data and output a cleaned, sampled dataset into a csv file for use with Tableau Public to fulfill the Module 18 Challenge homework assignment in the UofT data analytics course. 

The code in this repository is used to clean and output the data, which can then be loaded into Tableau Public for analysis. The analysis below refers to the visualizations made in Tableau Public, which can be found at **https://public.tableau.com/app/profile/sarah.kronheim/viz/CitiBikeAnalysis_16828914924020/CitiBike2022Analysis?publish=yes**

The visualizations, dashboards, and the story can be viewed as tabs at the above link. There are 18 individual visualizations, 2 dashboards, and 1 story. The story contains both dashboards and two additional visualizations.

## Data Sources

The CitiBike data was sourced from https://s3.amazonaws.com/tripdata/index.html
The zipcodes added to the data were sourced using Nominatim to convert latitude and longitude values to zipcodes.

## Data Cleaning Instructions 

To clean the data, run the 'citibike_data_cleaning.ipynb' file. This will take time, as converting latitude and longitudes to zip codes takes time and is subject to a mandatory 1 second delay between each conversion.

## CitiBike Analysis

* The Tableau page can be accessed using **https://public.tableau.com/app/profile/sarah.kronheim/viz/CitiBikeAnalysis_16828914924020/CitiBike2022Analysis?publish=yes**

* The map of all stations in 2022, colored by zipcode and sized by popularity, is shown first. This shows that there were many CitiBike stations in New York City in 2022, especially clustered in Manhattan. Several stations in Jerzy City are included in this dataset; these are the Jerzy City stations that several individuals finished their rides at, when starting from New York City. 
    * The map reveals a bias in the locations of CitiBike stations, with more stations in Manhattan and fewer in other Boroughs of NYC. 
        * This may not be a problem as the Manhattan stations are also the most popular as shown by their larger size relative to some of the further stations in places such as Brooklyn.
        * No information was available relating to the number of bikes at each station, however, so the lower usage of stations outside of Manhattan relative to those inside of Mnahattan may be due in part to fewer available bikes. To properly draw a conclusion about this, the number of available bikes at each station is required.

* The 10 most popular stations to start and end a CitiBike ride are the same, and are all in central and lower Manhattan. 
    * Each of these stations are utilized primarily by members of CitiBike, though all have some use by non-members. 
        * Interestingly, the 1st Ave & E 68th Street station has a lower proportion of casual users to members than the other most popular stations, indicating that this station may be of more interest to locals and/ or commuters than to casual bikers. 
        * This is contrasted with the West St & Chambers St station, which while still dominated by members is utilized by more casual riders than any of the other top 10 stations, both to start and end trips.
* The 10 least popular stations are less centrally located than the most popular stations.
    * The least popular start stations are all in NYC, and most were used more than once during 2022 (though none were used more than 8 times).
    * In contrast, the least popular ending stations aare largely in Jerzy City and all were only used once in 2022. 
        * This indicates that trips are more likely to start in a more populated place. Trips are more likely to end in a less central location than they are to start there, so more bikes should be stocked at more central locations. 

* The number of CitiBike rides increases dramatically in the summer, spring, and fall months as compared to winter, and most rides are attributed to members. 
    * CitiBike riders would rather bike when the weather is nice than in the winter.
    * While the number of rides never drops below 400,000 members and 72,000 casual riders in a month, the number of rides peaks in August with ~1.3 million rides by members and ~400,000 rides by casual users and is lowest in January at ~400,000 member rides and only ~72,000 casual rides.
        * This indicates that fewer bikes are required in the winter months, so maintenance can be done and bikes removed from circulation from ~January - March (the months with the lowest ridership). 
* Furthermore, members take significantly more rides overall than casual users.

* CitiBike appears to be used by members for commuting purposes.
    * The number of rides started peaks sharply at 8 am for members, the time when many would be on the way to work in the morning, and peaks again at 5-6 pm, when many leave work. 
        * These peaks are only notable for members, as casual use increases gradually throughout the day, reaching a maximum at 5-6 pm as well. The casual maximum may be due to nicer weather at 5-6 pm or perhaps a desire to take a bike ride after work.
    * Further supporting this finding, most rides are short - 0-15 minutes long, as members perhaps use a bike to transit between a train or other transportation and their workplace - perhaps using a CitiBike to travel their final distances.
        * Similarly for shorter rides, members take more rides than casual users.
        * However, casual users make up most of the longer duration rides despite the much higher number of member rides when compared to casual rides. 
            * Only 200,000 more member rides than casual rides were recorded for rides of 30-45 minutes in duration, while almost equal numbers of member and casual rides were recorded at 45-60 minutes in duration. More casual rides were recorded in 2022 than member rides when the duration increased to 60 minutes and above. 
    * Finally, only casual users were recorded having used docked bikes in 2022. 
        * This could indicate that members need the flexibility of undocked bikes more than casual users, lending further credence to the conclusion that members are commuting.
    * This all indicates that CitiBike should tailor its marketing and bikes to commuters (in Manhattan, from the first conclusion, as Manhattan is the most popular area for CitiBike users), and expect many more shorter rides than longer ones. 
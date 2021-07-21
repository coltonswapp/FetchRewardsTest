# FetchRewardsTest
#iOS Coding exercise issued by FetchRewards. 


Thank you so much for checking out the project that I made for this coding exercise! I had a lot of fun putting this together and adding my own little bit of spice in areas that I felt could use it. 

## Here is a what I built, with screenshots
- The first view is a UITableViewController that uses a UISearchBar to make an network call to the SeatGeek API and fetch events for the search term.
- The events return displayed with information relevant to the user. 
- An event that the user has favorited will appear with a small red heart.
- An added piece of flair from myself was adding a little tag, denoting what type an event is ("NHL", or "CONCERT" etc).

![](Images/TableSearchSG.gif) 
<img src = "Images/IMG_7097.PNG" width = "300">

- I also added some custom swipe actions for favoriting and unfavoriting events.
<img src = "Images/IMG_7098.PNG" width = "200">

- The detail view shows a wonderful little screen for the event details, along with a button for viewing the location on a map(using MapKit), and favoriting an event.
<img src = "Images/IMG_7100.PNG" width = "200">

- The MapKit view also creates a MKAnnotation from the event to display the CLLocation(latitude + longitude) on the map.
<img src = "Images/IMG_7104.PNG" width = "200">

- All of this persists using JSON persistence.

##### Thanks so much! Can't wait to hear from you :)








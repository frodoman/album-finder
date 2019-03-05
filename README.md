# Album Finder
This is an iOS demo app allowing user to search albums using API from one of the big content provider.

# How to run
Please open the AlbumFinder.xcworkspace file using Xcode 10.1 or later. 
To run the test, please select the 'AlbumFinder' from the target list drop down in the top left corner, 
then click 'Test' from the drop down menu of the most top left section of Xcode. 

# Project Structure 
There are two projects in this work space: 
* 'AlbumSDK' consists of all the data model, logic and networking stuff; 
* 'AlbumFinder' has all the UI level codes (UIViews, view controllers...). 

Each project comes with a test target as well 
(unit test for 'AlbumSDK' and UI test for 'AlbumFinder'). 

# Test coverage (Last update on March 5, 2019) 
* 100% for unit testing
* 97.7% for UI testing

# Implementation: 
This project is developed using only native iOS frameworks 
with Swift 4.2 and Xcode 10.1. 

In this project you will find these iOS dev topics: 
* Creating dynamic frameworks to be shared by other projects
* Creating work space to include multiple projects
* Network request to download data from server
* Passing raw data from server to decodable objects 
* Working with UITableView, UISearchBar
* Programmatically use of autolayout 
* Fetching image from server 
* Use of inheritance, extension, enum, protocol, genaric...

Unit test related: 
* Use mock objects, data/dependency injection to test networking without hinting the real server 
* Use local Json files for unit testing
* Test error handling of networking function

UI test related
* UI test basic implementation
* Entering text to a search bar 
* Functions to wait until an XCUIElement is visible/hidden
* Logic to scroll a table view till a certain cell is visible

# This app allows users to 
1. Enter keywords and hit 'Search'.
2. Show album search result in a table view.
3. Show details(image, artist and more info url) of the selected album in a details view. 
4. Show the related website of the album when 'More Information' is tapped.


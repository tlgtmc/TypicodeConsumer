# TypicodeConsumer

**Users**

1. Fetch a list of users from https://jsonplaceholder.typicode.com/users

An example of the data that will be returned looks like this:


    [
    	{
    	"id": 1,  
    	"name": "Leanne Graham", "username": "Bret",  
    	"email": "Sincere@april.biz", "address": {
    		"street": "Kulas Light", 
    		"suite": "Apt. 556", 
    		"city": "Gwenborough", 
    		"zipcode": "92998-3874", 											
    		"geo": {
    			"lat": "-37.3159",
    			"lng": "81.1496" 
    		}
    },  
    	"phone": "1-770-736-8031 x56442", 
    	"website": 
    	"hildegard.org", 
    	"company": {
    		"name": "Romaguera-Crona",  
    		"catchPhrase": "Multi-layered client-server neural-net", 
    		"bs": "harness real-time e-markets"
    }

2.  Parse the JSON into a list of objects
    
3.  Display a list of user names and addresses in an activity, displaying a list.
    
4.  If you click on any of the user rows we should see a detail view, displaying all the fields and information of the selected user
    

**Posts**

5.  Fetch a list of posts from https://jsonplaceholder.typicode.com/posts
    
6.  Parse the JSON into a list of objects
    
7.  Filter the list of post objects so it will only contain the posts for the selected user
    
8.  Show the posts of the user at the detail view (below or at another tab)
    

**Comments**

9. If you click on any of the posts you should see another view, displaying the selected post

10. Fetch a list of comments from https://jsonplaceholder.typicode.com/comments 11. Parse the JSON into a list of objects

11. Filter the list of comment objects so it will only contain the comments for the selected post

12. Show the comments of the user at the post detail view

**Progress and UI**

13. Show a progress indicator when fetching data from an endpoint  

14. Display an error message if no data could be fetched (Because of a missing internet connection for example)

**Testing**

16. Develop unit test(s) for fetching user data  

17. Develop unit test(s) for fetching and for filtering post data  

18. Develop UI test(s) to demonstrate the app can fetch a list of users and navigate to a detail view.

**Show it on a map**

19. Create another view where you display the users from step 1 on a map view with pin points, using the lat/lng information. Display the name of the user on a call out if you click on a pin point.

**Albums and photo’s**

20.  Fetch a list of albums from https://jsonplaceholder.typicode.com/albums
    
21.  Parse the JSON into a list of album objects
    
22.  In another view display the list of albums (for a single user or all users; that is up to you)
    
23.  If you click on an album you show go to another view where you can view the content of the album.
    
24.  Fetch a list of photos from https://jsonplaceholder.typicode.com/photos
    
25.  Parse the JSON into a list of photo objects
    
26.  Display all photo images in a grid, having 2 or 3 columns
    
27.  Download and display the image for each photo object, using the value for the
    
    ‘thumbnailUrl’ property. Do this in such a way that it will not block the user from
    
    scrolling through the grid while images are downloading.
    
28.  Make sure all photo’s take the aspect ratio into account.

**App bonus**

1.  Create a new framework within a workspace, that also contains the iOS project that you have created previously (If you have chosen to use CocoaPods it may also contain the Pods project).
    
2.  Migrate the code that that you have created for steps 1+2+5+6+10+11+12+16+17+18 by making it available through the framework only.
    
3.  Once you have migrated the code to the framework you should remove it from the app project and create a dependency from the app to the framework using Xcode.
    
4.  Verify that your app still builds and verify if the results are the same with the new framework approach.
    
5.  Now create a distributable version of your framework (resulting in a .framework file). Save it somewhere locally.
    
6.  Remove the framework project from the workspace, turning it into a stand alone project.
    
7.  Update the Cocoapods Pods file (or use Carthage or another dependency management tool if you prefer) in such a way that it contains a reference to the distributable framework that you have created.
    
8.  Update the dependencies (By running Pod install if you have choosen to use Cocoapods) and make sure the app still builds and runs if you are using your distributed framework file.
    
9.  Verify or make sure that the app can be archived (Either by choosing the Archive option from the Build Menu in Xcode or by using command line tools) and that the end result of it will be an .ipa or .xcarchive file.
    

**CI/CD**

Application contains a .travis.yml file.

If you would like to setup a CI pipeline, you could use it. 

Expectations :

-   Pipeline should run automatically when a branch is pushed to the github repo
    
-   Build the App in userdebug mode
    
-   Run the Unit tests
    
-   Fail the pipeline if the build or the unit tests execution fails.

# RottenTomatoes
Rotten Tomatoes Client . Week 1 for CodePath

Time spent: 12hr

####Features
#####Required

   * User can view a list of movies. Poster images load asynchronously. (**Completed**)
   * User can view movie details by tapping on a cell. (**Completed**)
   * User sees loading state while waiting for the API. (**Completed**)
   * User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C (**Completed**)
   * User can pull to refresh the movie list. (**Completed**)

#####Optional

   * Add a tab bar for Box Office and DVD. (**Completed**)
   * Implement segmented control to switch between list view and grid view. (**Completed**)
   * Add a search bar.(**Completed**)
   * All images fade in. (**Completed**)
   * For the large poster, load the low-res image first, switch to high-res when complete. (**Completed**)
   * Customize the highlight and selection effect of the cell. (**Completed**)
   * Customize the navigation bar. (**Completed**)

#####Walkthrough

![Video Walkthrough](Rotten_Tomatoes.gif)

If we use the high res version of the image in tableview , we wont be able to provide the low res version followed by high res version in the detailed view controller since its already cached. If we are ok with that then we can use an activiyindicatorview while loading the highres image in the tableview.

![Video Walkthrough](Rotten_Tomatoes_1.gif)
#####Credits
   * [Rotten Tomatoes API](http://developer.rottentomatoes.com/)
   * [AFNetworking](https://github.com/AFNetworking/AFNetworking)
   * [SVProgressHUD](http://samvermette.com/199)
   * [iconfinder](https://www.iconfinder.com/)

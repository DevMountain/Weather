# Weather

### Level 2

Students will build an app to get the current weather in a user-requested city to practice asyncronous network requests, working with JSON data, and closures.

Students who complete this project independently are able to:

* use NSURLSession to make aysncronous network calls
* parse JSON data and generate model object from the data
* use closures to execute code when an asyncronous task is complete

### Storyboard

Set up a scene to allow the user to search for a city and then see the results of their weather search.

1. Using the documentation of the API at [OpenWeatherMap](http://openweathermap.org), determine what information you can get from the API. What information might be useful for someone interested in the current weather? How are you going to allow the user to search for a city? Zip Code? City Name? Latitude/Longitude? Go to a sample endpoint and see what JSON you will get back.
2. Using this information from (1), build out the single view. It should have a search bar (UITextField), labels to display the information, and an image view (Black Diamond).
3. Add a class file for this scene called ```WeatherViewController.swift``` and assign the scene in the Storyboard.

### Implement Model

Create a Weather model class that will hold the information to display to the user

1. Create a ```Weather.swift``` class file and define a new ```Weather``` class
2. Add properties for main, description, iconString, iconImage: UIImage? (Black Diamond), temperatureK: Float?, cityName, temperatureC: Float?
3. Give initial values to main, description, iconString, and cityName
4. Make temperatureC be a computed variable that computes it's value from temperatureK.
5. Using a sample endpoint, create an initWithJSON method. This will take one parameter, a dictionary, and create an initialized weather object. This will parse through the dictionary to set the Properties of a new Weather object.

### Network Controller

Create a NetworkController class. This will have methods to build the different URLs you might want and it should have a method to return NSData from a URL.

1. The NetworkController should have some static constant that represents your API key and your baseURL.
2. Write a function that will take in a search term (the solution code uses a city name) and return an NSURL endpoint, remember to escape the search term if needed.
3. Write a function that will take an NSURL and a completion closure (dataAtURL:completion:). The parameter of the completion closure should be of type NSData? and the closure should return Void. This method will make the network call and if successful will call the completion closure with the NSData from the network call as it's parameter. If it is unsuccessful, the completion closure should still be called, but nil should be the parameter.
4. At this point you should be testing your network controller method dataAtURL to see if you are getting data returned.

As of iOS 9, Apple is boosting security and trying to require developers to use https. For this API, you must have a paid API account to use https. For the sake of this app and learning, we will turn off this security feature. The error message should describe the issue about App Transport Security blocking a cleartext HTTP. A workaround to Apple's requirements is to add a key-value pair to your Info.plist. This key-value pair should be: App Transport Security Settings : [Allow Arbitrary Loads : YES].

### Weather Controller

Create a WeatherController class. This will have methods that are called by the view controller to "return" the weather data through completion closures.

1. The WeatherController should have a method on it that allows the developer to pass in the search parameter and, through a completion closure, provide a Weather object.
    * This method should use the NetworkController to get the NSURL.
    * This method should call the NetworkController's dataAtURL method to get the NSData at the URL created in the previous bullet point.
    * In the closure of the dataAtURL check to make sure you actually get NSData back, not a nil value. If nil, call this methods completion with nil as the value for the Weather? parameter, else continue.
    * ```try``` (<- *Hint, Hint) to serialize the NSData to JSON objects. If we ```catch``` an exeception, call the completion closure with nil as the Weather? parameter. If the NSData can be serialized, create a Weather object and call the completion closure with the newly created Weather object.

### Code for WeatherViewContoller

Implement the WeatherViewController class. Wire up the views, add methods to perform the search and update the views.

1. Wire up the views in Storyboard to the IBOutlets in the view controller.
2. Conform to the UISearchBarDelegate. Can you find the method that is going to be called when the user wants to search?
    * How about ```searchBarSearchButtonClicked:```
3. Implement the delegate method found in step (2) above. You should call your WeatherController's search method. In the completion closure, you *should* have the Weather object as a parameter (unless something went wrong, in which case the Weather? object will be nil). Using this Weather object and Grand Central Dispatch, update the appropriate views.


### Black Diamonds

* After serializing the Weather object, you should may have noticed that there is a key-value pair for an iconString. Use this iconString to get an image representing the current weather conditions. Use the API documentation, a new method (which you will need to write) in the NetworkController that will provide the NSURL for the icon, a new method in WeatherController that will provide you an image in the completion closure.
* Allow the user to search in a different way than you initially implemented above. For example if you allowed the user to search by city, let them search by zip (or post) code.
* If no Weather was "returned," notify the user that a search failed.

## Contributions

Please refer to CONTRIBUTING.md.


## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.
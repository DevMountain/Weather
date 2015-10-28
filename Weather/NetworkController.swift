//
//  NetworkController
//  Weather
//
//  Updated by Taylor Mott on 10/12/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    
    private static let API_KEY = "4e63f48bb2d090d7fb7d80f6447ace6a"
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    static func searchURLByCity(city: String) -> NSURL {
        let escapedCityString = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        
        return NSURL(string: baseURL + "?q=\(escapedCityString!)" + "&appid=\(API_KEY)")!
    }
    
    static func urlForIcon(iconString: String) -> NSURL {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconString).png")!
    }
    
    static func dataAtURL(url: NSURL, completion:(resultData: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            
            guard let data = data  else {
                print(error?.localizedDescription)
                completion(resultData: nil)
                return
            }
            
            completion(resultData: data)
        }
        
        dataTask.resume()
    }
}
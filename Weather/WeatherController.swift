//
//  WeatherController.swift
//  Weather
//
//  Updated by Taylor Mott on 10/12/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class WeatherController {
    
    static func weatherBySearchCity(city: String, completion:(result: Weather?) -> Void) {
        
        let url = NetworkController.searchURLByCity(city)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            
            guard let resultData = resultData
                else {
                    print("NO DATA RETURNED")
                    completion(result: nil)
                    return
            }
            
            do {
                let weatherAnyObject = try NSJSONSerialization.JSONObjectWithData(resultData, options: NSJSONReadingOptions.AllowFragments)
                
                var weatherModelObject: Weather?
                
                if let weatherDictionary = weatherAnyObject as? [String : AnyObject] {
                    weatherModelObject = Weather(jsonDictionary: weatherDictionary)
                }
                
                completion(result: weatherModelObject)
                
            } catch {
                completion(result: nil)
            }

        }
    }
}

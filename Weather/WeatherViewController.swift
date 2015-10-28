//
//  WeatherViewController.swift
//  Weather
//
//  Updated by Taylor Mott on 10/12/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            WeatherController.weatherBySearchCity(searchText) { (result) in
                guard let weatherResult = result else { return }
                
                dispatch_async(dispatch_get_main_queue()) { () in
                    self.cityNameLabel.text = weatherResult.cityName
                    if let temperatureC = weatherResult.temperatureC {
                        self.temperatureLabel.text = String(temperatureC) + " °C"
                    } else {
                        self.temperatureLabel.text = "No temperature available"
                    }
                    self.mainLabel.text = weatherResult.main
                    self.descriptionLabel.text = weatherResult.description
                }
                
                WeatherController.weatherIconForIconCode(weatherResult.iconString, completion: { (image) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.iconImageView.image = image
                    })
                })
            }
        }
        
        searchBar.resignFirstResponder()
    }
}

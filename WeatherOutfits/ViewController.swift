//
//  ViewController.swift
//  WeatherOutfits
//
//  Created by LydiaKim on 2017-02-25.
//  Copyright © 2017 LydiaKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchButton: UISearchBar!
    @IBOutlet weak var SeeOutfits: UIButton!
    
    var weather = DataModel() // from DataModel.Swift
    var cityLocation: String! // location that user searches
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "myKey")
        weather.loc = token ?? "Vancouver"
        weather.setURL()
        weather.downloadData {
            self.updateUI()
        }
        searchButton.delegate = self;
        self.hideKeyboardWhenTappedAround()
        SeeOutfits.layer.cornerRadius = 7
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func updateUI() {
        tempLabel.text = "\(weather.temp)"
        locationLabel.text = weather.location
        weatherLabel.text = weather.weather
        weatherImage.image = UIImage(named: weather.weather)
    }
    
    func searchBarSearchButtonClicked(_ searchButton: UISearchBar)
    {
        cityLocation = searchButton.text
        cityLocation = cityLocation.removeWhiteSpace() // ex. New York -> NewYork
        weather.loc = cityLocation

        let defaults = UserDefaults.standard
        defaults.set(cityLocation, forKey: "myKey") // save the search result
        defaults.synchronize()
    
        
        weather.setURL() // update API with new city location
        weather.downloadData {
            self.updateUI()
        }
        searchButton.resignFirstResponder() // dismiss keyboard
        
    }
}

/* Remove whitespaces in a string */
extension String {
    func removeWhiteSpace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

/* Dismiss keyboard when user taps the background */
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}



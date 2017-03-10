//
//  DataModel.swift
//  WeatherOutfits
//
//  Created by LydiaKim on 2017-02-26.
//  Copyright © 2017 LydiaKim. All rights reserved.
//

import Foundation
import Alamofire

class DataModel {
    var _date: Double?
    var _temp: String?
    var _location: String?
    var _weather: String?
    var loc: String = ""
    var url: URL!
    typealias JSONStandard = Dictionary<String, AnyObject>
        
    func setURL() {
        url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(loc)&appid=89d10b2ad50629401facb9005b179f28")!
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }
    
    func downloadData(completed: @escaping ()-> ()) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
            
            if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                
                self._temp = String(format: "%.0f °C", temp - 273.15)
                self._weather = weather
                self._location = "\(name), \(country)"
                self._date = dt
                
            }
            
            completed()
        })
    }
}

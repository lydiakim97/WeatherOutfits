//
//  MaleOutfit.swift
//  WeatherOutfits
//
//  Created by LydiaKim on 2017-03-08.
//  Copyright © 2017 LydiaKim. All rights reserved.
//

import UIKit

class MaleOutfit: UIViewController {
    
    @IBOutlet weak var maleOutfitImage: UIImageView!
    var weather = DataModel() // from DataModel.Swift
    var homepage = ViewController()
    
    var temperature: String = ""
    var condition: String = ""
    var temp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "myKey")
        weather.loc = token ?? "Vancouver"
        weather.setURL()
        weather.downloadData {
            self.updateOutfits()
        }
    }

    func updateOutfits() {
        temperature = "\(weather.temp)"
        condition =  weather.weather
        
        let endIndex = temperature.index(temperature.endIndex, offsetBy: -3) // 2 °C -> 2
        temp = temperature.substring(to: endIndex)
        
        
        if(condition == "Rain" || condition == "Snow") {
            if(Int(temp)! < 5) {
                maleOutfitImage.image = UIImage(named: "man-outfit6") // cold
            } else if(Int(temp)! >= 5 && Int(temp)! < 15)  {
                maleOutfitImage.image = UIImage(named: "man-outfit4") // normal
            } else if(Int(temp)! >= 15){
                maleOutfitImage.image = UIImage(named: "man-outfit2") // warm
            }
        } else {
            if(Int(temp)! < 5) {
                maleOutfitImage.image = UIImage(named: "man-outfit5") // cold
            } else if (Int(temp)! >= 5 && Int(temp)! < 15) {
                maleOutfitImage.image = UIImage(named: "man-outfit3") // normal
            } else if (Int(temp)! >= 15) {
                maleOutfitImage.image = UIImage(named: "man-outfit1") // warm
            }
        }
        
    }

    
    
}

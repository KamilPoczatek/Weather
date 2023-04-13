//
//  ShowWeatherViewController.swift
//  Weather
//
//  Created by Kamil Początek on 12/04/2023.
//

import UIKit

class ShowWeatherViewController: UIViewController {

    var weatherModel: WeatherModel?
    
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = "\(weatherModel!.cityName) (\(weatherModel!.country))"
        
        weatherTemperature.text = String(format: "%1.f°C", weatherModel!.temperature)
        weatherTemperature.textColor = weatherModel!.textColor
        
        if #available(iOS 13.0, *) {
            weatherIcon.image = UIImage(systemName: weatherModel!.weatherImageName)
            weatherIcon.tintColor = weatherModel!.textColor
        } else {
            weatherIcon.isHidden = true
        }
    }
}

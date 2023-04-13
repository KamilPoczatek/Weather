//
//  WeatherModel.swift
//  Weather
//
//  Created by Kamil Początek on 12/04/2023.
//

import Foundation
import UIKit

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let weatherId: Int
    let country: String
    
    var textColor: UIColor {
        switch temperature {
        case ..<10:
            return .blue
        
        case 10...20:
            return .black
        
        default:
            return .red
        }
    }
    
    var weatherImageName: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
            
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "questionmark"
        }
    }
}

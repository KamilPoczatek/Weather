//
//  OpenWeatherManager.swift
//  Weather
//
//  Created by Kamil Początek on 11/04/2023.
//

import Foundation

protocol OpenWeatherManagerDelegate{
    func updateWeather (_ weather: WeatherModel)
}

struct OpenWeatherManager{
    let decoder = JSONDecoder()
    // TODO: Extrack url, key and metric system - move
    let getWeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d9f39ac6a7cd1b7621f5af8666af0fc1&units=metric"
    
    var delegate: OpenWeatherManagerDelegate?
    
    func getWeather (cityName: String){
        if let url = URL(string: "\(getWeatherURL)&q=\(cityName)"){
            
            let session = URLSession(configuration: .default)
            
            // TODO: Add error handler
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    if let notNilData = data{
                        if let weather = parceJSONtoModel(notNilData){
                            self.delegate?.updateWeather(weather)
                            return
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parceJSONtoModel (_ data: Data) -> WeatherModel?{
        do{
            let decoded = try decoder.decode(OpenWeatherData.self, from: data)
            
            return WeatherModel (
                cityName: decoded.name,
                temperature: decoded.main.temp,
                weatherId: decoded.weather[0].id,
                country: decoded.sys.country)
            
        }catch{
            // TODO: Add error handler
            return nil
        }
    }
}

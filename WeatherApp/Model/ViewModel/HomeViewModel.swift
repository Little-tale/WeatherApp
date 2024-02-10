//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

struct HomeViewModel {
    let cityName: String
    let temperature : String
    let description : String
    let maxTemp : String
    let minTemp : String
    
    
    init(model: WeatherAPIcurrentModel) {
        self.cityName = model.cityName
        self.temperature = TempAssistance.maxOrMin(temp: model.main.temp).get
        self.description = model.weather.first?.description ?? "뭔가 잘못됨 확인해"
        self.maxTemp = "최고 : \(model.main.tempMax - 273.15)"
        self.minTemp = minTemp
    }
}

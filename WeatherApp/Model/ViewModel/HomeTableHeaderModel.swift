//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

// 메인화면에 필요한 정보를 여기서 가공을 해볼 예정이다.
// 메인화면 위에있는 CityName, temp, maxTemp, minTemp
// 3시간 간격은 어떻게 해야하는지 알아봐야 할듯 하다.
// -> forecast 가 3시간 간격의 데이터로 5일간의 일기예보를 알수있다.
struct HomeTableHeaderModel {
    let cityName: String
    let temperature : String
    let description : String
    let maxTemp : String
    let minTemp : String
    let coord : Coord
    let clouds : String
    let giap : String
    let supdo : String
    let wind : String
    let gust : String
    
    init(model: WeatherAPIcurrentModel) {
        self.cityName = model.cityName
        self.temperature = TempAssistance.temp(temp: model.main.temp).get
        self.description = model.weather.first?.description ?? "뭔가 잘못됨 확인해"
        self.maxTemp = "최고 :" + TempAssistance.max(temp: model.main.tempMax).get
        self.minTemp = "최소:" + TempAssistance.min(temp: model.main.tempMin).get
        self.coord = model.coord
        self.clouds = "\(model.clouds.all)%"
        self.supdo = "\(model.main.humidity)%"
        self.giap = "\(model.main.pressure)hpa"
        self.wind = "\(model.wind.speed)m/s"
        self.gust = "강풍:\(model.wind.gust ?? 0)m/s"
    }
}

struct WeatherHomeViewModel {
    let cityName: String
    let temperature : String
    let description : String
    let maxTemp : String
    let minTemp : String
    let coord : Coord
    let clouds : String
    let giap : String
    let supdo : String
    let wind : String
    let gust : String
    
    init(model: AllInOneModel) {
        self.cityName = model.cityName
        self.temperature = TempAssistance.temp(temp: model.main.temp).get
        self.description = model.weather.first?.description ?? "뭔가 잘못됨 확인해"
        self.maxTemp = "최고 :" + TempAssistance.max(temp: model.main.tempMax).get
        self.minTemp = "최소:" + TempAssistance.min(temp: model.main.tempMin).get
        self.coord = model.coord
        self.clouds = "\(model.clouds.all)%"
        self.supdo = "\(model.main.humidity)%"
        self.giap = "\(model.main.pressure)hpa"
        self.wind = "\(model.wind.speed)m/s"
        self.gust = "강풍:\(model.wind.gust ?? 0)m/s"
    }
}

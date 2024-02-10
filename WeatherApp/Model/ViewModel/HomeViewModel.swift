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
struct HomeViewModel {
    let cityName: String
    let temperature : String
    let description : String
    let maxTemp : String
    let minTemp : String
    
    
    init(model: WeatherAPIcurrentModel) {
        self.cityName = model.cityName
        self.temperature = TempAssistance.temp(temp: model.main.temp).get
        self.description = model.weather.first?.description ?? "뭔가 잘못됨 확인해"
        self.maxTemp = TempAssistance.max(temp: model.main.tempMax).get
        self.minTemp = TempAssistance.min(temp: model.main.tempMin).get
    }
}

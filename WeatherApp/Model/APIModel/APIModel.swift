//
//  APIModel.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

protocol WeatherInfomation{
    var weather: [Weather] {get}
    var main: Main {get}
    var wind: Wind {get}
}

// MARK: - WeatherAPIModel -> currentAPI,CurrentCity
struct WeatherAPIcurrentModel: Decodable, WeatherInfomation{
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
   
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
}
struct List: Decodable, WeatherInfomation {
    let dt: Int // 예측된 시간
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let clouds : Clouds // 흐림정도
    let visibility: Int
    let pop: Double // 강수 확률
    // let sys: Sys // ? 하루중 일부?
    let dtTxt: String
    // let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop//, sys
        case dtTxt = "dt_txt"
       //  case rain
    }
}

// MARK: - ForeCastAPI, ForeCastCity
struct WeatherAPIForecastModel: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}





////////////////////////////////////
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord -> 위경도
struct Coord: Decodable { //
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather -> 날씨 핵심
struct Weather: Decodable {
    /// main = 날씨 descroption = 더 자세한 날씨
    let main, description, icon: String
}

// MARK: - Wind -> 바람 세기, 나머지는 뭘까용?
struct Wind: Decodable {
    let speed: Double // 바람세기
    let deg: Int // ???
    let gust: Double // 돌풍
}

////
///

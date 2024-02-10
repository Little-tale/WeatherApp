//
//  APIModel.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

// MARK: - WeatherAPIModel
struct WeatherAPIModel: Decodable {
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

// MARK: - Coord -> 위경도
struct Coord: Decodable {
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


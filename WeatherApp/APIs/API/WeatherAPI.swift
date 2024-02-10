//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

enum APIManagerRequestError: Error{
    case noData
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
    case unknownError
    case componentsError
}

/*
 URL Session 의 컴포넌트 방식으로 하지만
 BaseUrl를 구현하라고 한 이유는 만일의 사태일때 그것으로 대체하라는 의미에 두었습니다.
 */
protocol UrlSession{
    // var baseUrl : String {get}
    var query : [URLQueryItem?] {get}
    // var header : [String: String] {get}
    var method : String {get}
    
    var schem : String{get}
    var host: String {get}
    var path: String {get}
}
// https://api.openweathermap.org/data/2.5/weather
enum WeatherApi:UrlSession {
    case current(lat : Double, Lon: Double)
    case currentCity(id: Int)
    case foreCase(lat: Double, Lon: Double)
    case foreCaseCity(id: Int)
    
    var schem : String {
        switch self {
        default: return "https"
        }
    }
    
    var query: [URLQueryItem?] {
        var queryItems:[URLQueryItem] = [URLQueryItem(name: "appid", value: APIKey.weather.key)]
        
        switch self {
        case .current(let lat, let Lon), .foreCase(let lat, let Lon):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(Lon)"),
            ])
        case .currentCity(let id), .foreCaseCity(id: let id):
            queryItems.append(URLQueryItem(name: "id", value: "\(id)"))
        }
        return queryItems
    }
    
    var method: String {
        switch self {
        default: return "GET"
        }
    }
    
    var host: String {
        switch self {
        default: return "api.openweathermap.org"
        }
    }
    
    var path: String{
        switch self {
        case .current, .currentCity:
            return "/data/2.5/weather"
        case .foreCase, .foreCaseCity:
            return "/data/2.5/forecast"
       
        }
    }
    
}

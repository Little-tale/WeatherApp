//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

//enum APIManagerRequestError: Error{
//    case unknownError
//    case componentsError
//}
enum APIComponentsError: Error {
    case noQuery
    case componentsToUrlFail
}
enum URLError: Error {
    case noData
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
}
enum errorCode:Error {
    case _400
    case _401
    case _404
    case _429
    case _5xx
    case not200
    
    var message: String {
        switch self {
        case ._400:
            "잘못된 요청입니다."
        case ._401:
            "API 토큰이 승인되지 않았거나 엑세스 권한없음"
        case ._404:
            "위치를 찾을 수 없거나, 등록되지 않은 지역입니다."
        case ._429:
            "요청이 너무 많습니다."
        case ._5xx:
            "예상치 못한 에러입니다."
        case .not200:
            "예상치 못한 에러가 발생했습니다 관리자에게 문의 바랍니다."
        }
    }
}

/*
 URL Session 의 컴포넌트 방식으로 하지만
 BaseUrl를 구현하라고 한 이유는 만일의 사태일때 그것으로 대체하라는 의미에 두었습니다.
 */
protocol UrlSession{
    // var baseUrl : String {get}
    var query : [URLQueryItem]? {get}
    // var header : [String: String] {get}
    var method : String {get}
    
    var scheme : String{get}
    var host: String {get}
    var path: String {get}
}
// https://api.openweathermap.org/data/2.5/weather
enum WeatherApi:UrlSession {
    case current(lat : Double, Lon: Double)
    case currentCity(id: Int)
    case foreCase(lat: Double, Lon: Double)
    case foreCaseCity(id: Int)
    
    var scheme : String {
        switch self {
        default: return "https"
        }
    }
    
    var query: [URLQueryItem]? {
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
        queryItems.append(URLQueryItem(name: "lang", value: "kr"))
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

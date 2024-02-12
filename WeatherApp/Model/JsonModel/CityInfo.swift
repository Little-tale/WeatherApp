//
//  File.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit


struct CityInfoModel: Decodable {
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord: CoordLocation
}
struct CoordLocation: Decodable {
    let lon, lat: Double
}

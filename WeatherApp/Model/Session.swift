//
//  Session.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import Foundation


enum homeSession: CaseIterable {
    case threeTimeInterval
    case fiveDayaInterval
    case location
    
    var title: String {
        switch self {
        case .threeTimeInterval:
            "3시간 간격의 일기예보"
        case .fiveDayaInterval:
            "5일 간의 일기예보"
        case .location:
            "위치"
        }
    }
}

// MARK: 로직 개선 작업 1
enum HomeTableViewSection {
    case currentWeather(HomeTableHeaderModel)
    case threeDatForecast([List])
    case detailInfo(HomeTableHeaderModel)
}



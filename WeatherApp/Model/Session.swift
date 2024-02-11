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
    
    var title: String {
        switch self {
        case .threeTimeInterval:
            "3시간 간격의 일기예보"
        case .fiveDayaInterval:
            "5일 간의 일기예보"
        }
    }
}

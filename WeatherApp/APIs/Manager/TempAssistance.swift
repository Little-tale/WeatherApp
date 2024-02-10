//
//  TempAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import UIKit


enum TempAssistance {
    case max(temp: Double)
    case temp(temp:Double)
    case min(temp: Double)
    var get : String {
        // 123.00
        
        switch self {
        case .max(let temp):
            var tempBefore = temp - 273.15
            tempBefore *= 10
            tempBefore = tempBefore.rounded()
            let after = tempBefore / 10
            return "최고:\(after)°"
            
        case .temp(let temp):
            var tempBefore = temp - 273.15
            tempBefore *= 10
            tempBefore = tempBefore.rounded()
            let after = tempBefore / 10
            return "\(after)°"
        case .min(let temp):
            var tempBefore = temp - 273.15
            tempBefore *= 10
            tempBefore = tempBefore.rounded()
            let after = tempBefore / 10
            return "최저:\(after)°"
        }
    
    }
    
    
}

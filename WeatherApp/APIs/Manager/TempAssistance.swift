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
    
    // MARK: 각 케이스마다 해당하는 글자를 맞추어 줍니다.
    var get : String {
        // 123.00
        switch self {
        case .max(let temp):
            let after = tempCalc(temp: temp)
            return "최고:\(after)°"
            
        case .temp(let temp):
            let after = tempCalc(temp: temp)
            return "\(after)°"
        case .min(let temp):
            let after = tempCalc(temp: temp)
            return "최저:\(after)°"
        }
    
    }
    //MARK: 화씨를 섭씨로 변경 해줍니다.
    private func tempCalc(temp: Double) -> Double{
        var tempBefore = temp - 273.15
        tempBefore *= 10
        tempBefore = tempBefore.rounded()
        let after = tempBefore / 10
        return after
    }
    
    
}

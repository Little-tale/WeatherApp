//
//   TemperatureAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import Foundation

enum TemperatureAssistance {
    case max([List])
    case min([List])
    
    var getAverage: String{
        switch self {
        case .max(let list):
            maxAverage(list: list)
        case .min(let list):
            minAverage(list: list)
        }
    }
    
    private func maxAverage(list: [List]) -> String{
        var total = 0.0
        for item in list{
            total += item.main.tempMax
        }
        // 예상값 : 3.3132314123
        let average = total / Double(list.count)
        let round =  average.rounded()
        return String(round)
    }
    private func minAverage(list: [List]) -> String{
        var total = 0.0
        for item in list{
            total += item.main.tempMin
        }
        // 예상값 : 3.3132314123
        let average = total / Double(list.count)
        let round =  average.rounded()
        return String(round)
    }
    
   
}

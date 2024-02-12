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
    // MARK: 가장 큰놈을 골라드립니다.
    /// [List]-> List<tempMax> -> maxinm
    private func maxAverage(list: [List]) -> String{
        var numList:[Double] = []
        for datas in list {
            numList.append(datas.main.tempMax - 273.15)
        }
        let max = numList.max() ?? 0
       
        return String( max.rounded()) + "°"
    }
    // MARK: 가장 작은놈을 골랃립니다.
    private func minAverage(list: [List]) -> String{
        var numList:[Double] = []
        for datas in list {
            numList.append(datas.main.tempMin - 273.15)
        }
        let min = numList.min() ?? 0
       
        return String( min.rounded()) + "°"
    }
    
   
}

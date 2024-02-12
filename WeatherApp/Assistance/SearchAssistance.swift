//
//  SearchAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit

struct SearchAssistance {
    
    // 검색된 단어를 찾아서 모델로 다시 보내드립니다.
    func findCity(for searchText: String, cityModel: cityInfoModels) -> cityInfoModels{
        let filterCityModel = cityModel.filter { model in
            model.name.contains(searchText)
        }
        print(filterCityModel)
        return filterCityModel
    }
    
}

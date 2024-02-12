//
//  ImageAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import Foundation

enum imageAssistanceError: Error{
    case cantThisChangeUrl
}

struct ImageAssistance {
    let baseImageUrl =  "https://openweathermap.org/img/wn/"
    let behindUrl = "@2x.png"
    func getImageUrl(imageName: String) throws-> URL{
        let urlString = baseImageUrl + imageName + behindUrl
        let url = URL(string: urlString)
        if let url = url  {
            return url
        }
        throw imageAssistanceError.cantThisChangeUrl
    }
}

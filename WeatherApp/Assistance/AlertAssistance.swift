//
//  AlertAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit



extension UIViewController {
    func showAlert(error: apiError) {
        var alert = UIAlertController()
        alert.title = "통신에러"
        
        switch error{
        case .noQuery:
            alert.message = "검색하신 도시의 정보가 없습니다."
        case .componentsToUrlFail:
            alert.message = "통신에 문제가 있습니다. 잠시후 부탁드립니다."
        }
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}

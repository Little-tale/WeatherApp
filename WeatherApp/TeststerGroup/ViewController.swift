//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        URLSessionManager.shared.fetch(type: WeatherAPIForecastModel.self, api: WeatherApi.foreCaseCity(id: 1835847)) { result in
            switch result{
            case .success(let model):
                print(model)
            case .failure(let errors):
                print(errors)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}


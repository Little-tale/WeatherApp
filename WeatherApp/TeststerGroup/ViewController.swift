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
        
        URLSessionManager.shared.fetch(type: WeatherAPIcurrentModel.self, api: WeatherApi.currentCity(id: 1835847)) { result in
            switch result{
            case .success(let model):
                print(model)
                let goViewModel = HomeViewModel(model: model)
                self.test(viewModel: goViewModel)
            case .failure(let errors):
                print(errors)
            }
        }
        URLSessionManager.shared.fetch(type: WeatherAPIForecastModel.self, api: WeatherApi.foreCaseCity(id: 1835847)) { result in
            switch result{
            case .success(let success):
                print(success) // 이 부분에서 파싱이 이루어져아 할것 같음
                // print("🤩",success.list.first?.dtTxt)
            case .failure(let error):
                print(error)
            }
        }
    }
    func test(viewModel: HomeViewModel ) {
        print(viewModel.cityName)
        print(viewModel.description)
        print(viewModel.maxTemp)
        print(viewModel.minTemp)
        print(viewModel.temperature)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}


//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit

class ViewController: UIViewController {
    var dateAssistance: DateAssistance = .init(timeZone: 0)
    var dateDictionry = dataDictionry() {
        didSet{
            dateAssistance.devideTime(DateDic: dateDictionry)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // MARK: 현재 날씨 데이터 요청
        URLSessionManager.shared.fetch(type: WeatherAPIcurrentModel.self, api: WeatherApi.currentCity(id: 1833788)) { result in
            switch result{
            case .success(let model):
                // print(model)
                let goViewModel = HomeViewModel(model: model)
              
                self.dateAssistance = DateAssistance(timeZone: model.timezone)
                self.test(viewModel: goViewModel)
            case .failure(let errors):
                print(errors)
            }
        }
        // MARK: 주간 날씨 데이터 요청
        URLSessionManager.shared.fetch(type: WeatherAPIForecastModel.self, api: WeatherApi.foreCaseCity(id: 1833788)) { result in
            switch result{
            case .success(let success):
                let divideDate = self.dateAssistance.devideCalendar(dateList: success.list)
                switch divideDate {
                case .success(let success):
                    self.dateDictionry = success
                case .failure(let fail):
                    print(fail)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func test(viewModel: HomeViewModel ) {
//        print(viewModel.cityName)
//        print(viewModel.description)
//        print(viewModel.maxTemp)
//        print(viewModel.minTemp)
//        print(viewModel.temperature)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}


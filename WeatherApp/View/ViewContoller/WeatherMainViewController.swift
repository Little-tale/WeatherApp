//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit

class WeatherMainViewController: UIViewController {
    let homeView = MainHomeView()
    var currentModel: HomeTableHeaderModel? = nil
    
    override func loadView() {
        self.view = homeView
    }
    
    var dateAssistance: DateAssistance = .init(timeZone: 0)
    var dateDictionry = dateDictionryForString() {
        didSet{
            dateIndexDictioary = dateAssistance.getSortedIndexList(DateDic: dateDictionry)
            
            
        }
    }
    var dateIndexDictioary = [Int:[List]]() {
        didSet{
            if let test = dateIndexDictioary[0]?.first?.dtTxt  {
                let tester = dateAssistance.getOnlyTime(dtText: test)
                print(tester)
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableViewRegister()
        // MARK: 현재 날씨 데이터 요청
        let group = DispatchGroup()
        group.enter()
        URLSessionManager.shared.fetch(type: WeatherAPIcurrentModel.self, api: WeatherApi.currentCity(id: 1833788)) { result in
            switch result{
            case .success(let model):
                // print(model)
                self.currentModel = HomeTableHeaderModel(model: model)
              
                self.dateAssistance = DateAssistance(timeZone: model.timezone)
                
            case .failure(let errors):
                print(errors)
            }
            group.leave()
        }
        group.enter()
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
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.homeView.tableView.reloadData()
        }
        
        
    }
    func tableViewRegister(){
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
extension WeatherMainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusableIdentifier) else {
            
            return UITableViewCell(style: .subtitle, reuseIdentifier: "잘못된 셀")
        }
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let i = currentModel else {
            print("모델이 없음.")
            return UIView()
        }
        homeView.currentView.settingView(city: i.cityName, temp: i.temperature, weatherInfo: i.description, maxTemp: i.maxTemp, minTemp: i.minTemp)
        return homeView.currentView
    }
    
}

//#Preview{
//    WeatherMainViewController()
//}

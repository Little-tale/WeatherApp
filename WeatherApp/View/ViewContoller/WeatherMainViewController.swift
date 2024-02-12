//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit

typealias dateNumDic = [Int:[List]]

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
    var dateIndexDictioary = dateNumDic()
    var threeModel = [List]()
    
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
    // MARK: 테이블뷰 딜리게이트 데이타 소스 + 오토레이아웃
    func tableViewRegister(){
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.estimatedRowHeight = 100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // homeView.tableView.layoutIfNeeded()
    }
    
    private func threeItems() -> [List] {
        
        // 키 0,1,2,3,4 .... 처럼 정렬
        let sortedKey = dateIndexDictioary.keys.sorted()
        // 앞에서 3개만 가져올겨
        let threeTimes = sortedKey.prefix(3)
        // [0, 1, 2] -> 3일치 임
        // print(threeTimes)
        let threeTimeItems = threeTimes.compactMap { myKey in
            dateIndexDictioary[myKey]
        }
        // dump(threeTimeItems)
        var totalItem = [List]()
        threeTimeItems.forEach { list in
            totalItem.append(contentsOf: list)
        }
        return totalItem
    }
    
}
// MARK: 테이블뷰 데이타
extension WeatherMainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeSession.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let secction = homeSession.allCases[indexPath.row]
        let totalItems = threeItems()
    
        threeModel = totalItems
        
        
        
        // print("asdasdasdasd")
        switch secction {
        case .threeTimeInterval:
            print(secction)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainHomeTableViewCell.reusableIdentifier, for: indexPath) as? MainHomeTableViewCell else {
                print("셀 변환 실패")
                return UITableViewCell()
            }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.topView.label.text = secction.title
            cell.backgroundColor = .gray
            cell.collectionView.reloadData()
            return cell
        case .fiveDayaInterval:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableView.reusableIdentifier) else {
                print("asdasdasdasd")
                return UITableViewCell() }
            return cell
        }
        // return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let i = currentModel else {
            print("모델이 없음.")
            return UIView()
        }
        homeView.currentView.settingView(city: i.cityName, temp: i.temperature, weatherInfo: i.description, maxTemp: i.maxTemp, minTemp: i.minTemp)
        return homeView.currentView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
// MARK: 컬렉션뷰 데이타
extension WeatherMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return threeModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesWeatherCollecionViewCell.reusableIdentifier, for: indexPath) as? TimesWeatherCollecionViewCell else {
            print("컬렉션뷰 셀 에러")
            return UICollectionViewCell()
        }
        let modelData = threeModel[indexPath.row]
        cell.tempLabel.text = TempAssistance.temp(temp: modelData.main.temp).get
       
        cell.timeLabel.text =  dateAssistance.getOnlyTime(dtText: modelData.dtTxt)
        guard let icon = modelData.weather.first?.icon else {
            print("weatherIcon 없어")
            return cell
        }
        cell.settingImage(imageName: icon)
        cell.backgroundColor = .brown
        return cell
        
        
    }
}

//#Preview{
//    WeatherMainViewController()
//}

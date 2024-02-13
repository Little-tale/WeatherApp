//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit
import CoreLocation

typealias dateNumDic = [Int:[List]]

final class WeatherMainViewController: UIViewController {
    let locationManager = CLLocationManager()
    let homeView = MainHomeView()
    var currentModel: HomeTableHeaderModel? = nil
    
    override func loadView() {
        self.view = homeView
        checkDeviceLocationAuthorization()
    }
    var cityId = 1833788 {
        didSet{
            requestData()
        }
    }
    
    var dateAssistance: DateAssistance = .init(timeZone: 32400)
    var dateDictionry = dateDictionryForString() {
        didSet{
            dateIndexDictioary = dateAssistance.getSortedIndexList(DateDic: dateDictionry)
        }
    }
    var dateIndexDictioary = dateNumDic()
    var threeModel = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableViewRegister()
        requestData()
        
        homeView.tabview.listButton.addTarget(self, action: #selector(goListView), for: .touchUpInside)
    }
    
    
    private func requestData(){
        // MARK: 현재 날씨 데이터 요청
        let group = DispatchGroup()
        
        group.enter()
        URLSessionManager.shared.fetch(type: WeatherAPIcurrentModel.self, api: WeatherApi.currentCity(id: cityId)) { result in
            switch result{
            case .success(let model):
                // print(model)
                self.currentModel = HomeTableHeaderModel(model: model)
              
                self.dateAssistance = DateAssistance(timeZone: model.timezone)
                
            case .failure(let errors):
                self.showAlert(error: errors)
            }
            group.leave()
        }
        
        group.enter()
        // MARK: 주간 날씨 데이터 요청
        URLSessionManager.shared.fetch(type: WeatherAPIForecastModel.self, api: WeatherApi.foreCaseCity(id: cityId)) { result in
            switch result{
            case .success(let success):
                let divideDate = self.dateAssistance.devideCalendar(dateList: success.list)
                switch divideDate {
                case .success(let success):
                    self.dateDictionry = success
                case .failure(let fail):
                    self.showAlert(error: fail)
                }
            case .failure(let error):
                self.showAlert(error: error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("🍌🍌🍌🍌🍌🍌🍌🍌")
            self.homeView.tableView.reloadData()
        }
    }
    
    // MARK: 다음뷰로 가서 값을 가져옵니다.
    @objc
    func goListView(){
        let vc = CityListViewController()
        vc.getCityId = {
            cityId in
            self.cityId = cityId
        }
        present(vc, animated: true)
    }
    
    
    
    // MARK: 테이블뷰 딜리게이트 데이타 소스 + 오토레이아웃
    func tableViewRegister(){
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.rowHeight = UITableView.automaticDimension
        homeView.tableView.estimatedRowHeight = 120
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // homeView.tableView.layoutIfNeeded()
    }
    //MARK: 3일치 데이터를 반환해줍니다.
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
            cell.backgroundColor = .clear
            cell.collectionView.reloadData()

            return cell
            
        case .fiveDayaInterval:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FiveDayIntervalTableCell.reusableIdentifier) as? FiveDayIntervalTableCell else {
                print("셀 변환실패 FiveDayIntervalTableCell")
                return UITableViewCell()
            }
            cell.fiveDelegate = self
            cell.label.label.text = secction.title
            cell.tableView.reloadData()
            return cell
            
        case .location:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reusableIdentifier, for: indexPath) as? LocationTableViewCell else {
                print("셀 변환실패 LocationTableViewCell")
                return UITableViewCell()
            }
            cell.header.label.text = secction.title
            cell.header.imageView.image = UIImage(systemName: "location.fill")
            guard let current = currentModel?.coord else {
                print("데이터를 불러오지 못했습니다 currentModel -> coord")
                return cell
            }
            cell.settingLocattion(lat: current.lat, lon: current.lon)
            guard let currentData = currentModel else {
                print("데이터를 불러오지 못했습니다 currentModel -> currentData")
                return cell
            }
            cell.updateInfoBoxView(cell.WindBoxView, title: "바람속도", info: currentData.wind, detail: currentData.gust)
            cell.updateInfoBoxView(cell.cloudBoxView, title: "구름", info: currentData.clouds, detail: nil)
            cell.updateInfoBoxView(cell.giappBoxView, title: "기압", info: currentData.giap, detail: nil)
            cell.updateInfoBoxView(cell.supdoBoxView, title: "습도", info: currentData.supdo, detail: nil)
            //cell.settingInfoBoxView(title: <#T##String#>, info: <#T##String#>, detail: <#T##String?#>)
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
        // cell.backgroundColor = .brown
        return cell
        
        
    }
}

extension WeatherMainViewController: FiveDayIntervalProtocol {
    func FivetableView(for FiveDayIntervalTableCell: UITableViewCell, tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🥝🥝🥝🥝🥝🥝",dateIndexDictioary.count)
        return dateIndexDictioary.count
    }
    
    func FivetableView(for FiveDayIntervalTableCell: UITableViewCell, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FiveInnerTableViewCell.reusableIdentifier , for: indexPath) as? FiveInnerTableViewCell else {
            print("FiveInnerTableViewCell 변환 실패")
            return UITableViewCell()
        }
        cell.dateWeekLabel.backgroundColor = .clear
        cell.weatherImageView.backgroundColor = .clear
        
        // cell.backgroundColor = UIColor(white: 0, alpha: 1)
        
        guard let representList = dateIndexDictioary[indexPath.row] else {
            print("데이터 받기 실패 dateIndexDictioary")
            return cell
        }
        
        guard let represent = representList.first else {
            print("대표 받기 실패")
            return cell
        }
        
        cell.settingImage(imageName: represent.weather.first?.icon ?? "")
        
        cell.dateWeekLabel.text = dateAssistance.getDayOfWeek(dtText: represent.dtTxt)
        
        let maxText = TemperatureAssistance.max(representList).getAverage
        
        cell.maxTextLabel.text = "최고 : " + maxText
        
        let minText = TemperatureAssistance.min(representList).getAverage
        
        cell.minTextlabel.text = "최소 : " + minText
        
        
        return cell
    }
    
    
}

extension WeatherMainViewController {
    
}

//#Preview{
//    WeatherMainViewController()
//}

//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit
import CoreLocation

typealias dateNumDic = [Int:[List]]

// 이제 고민할건 다른 셀들도 이 뷰에서 사용할 모델로 묶어 보자. 

final class WeatherMainViewController: UIViewController {
    let locationManager = CLLocationManager()
    let homeView = MainHomeView()
    
    var currentModel: WeatherHomeViewModel? = nil
    
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
    
    // Int:[List]
    var dateIndexDictioary = dateNumDic()
    // var dateIndexCecction: [Int:homeSession] = [:]
    
    // MARK: 로직 개선 작업 2
    var weatherViewSection : [HomeTableViewSection] = []
    
    // MARK: 이것도 왜 이렇게 했을까 궁금
    // var threeModel = [List]()
    
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
        URLSessionManager.shared.fetch(type: AllInOneModel.self, api: WeatherApi.currentCity(id: cityId)) { result in
            switch result{
            case .success(let model):
                // print(model)
                self.currentModel = WeatherHomeViewModel(model: model)
              
                self.dateAssistance = DateAssistance(timeZone: model.timezone)
                
            case .failure(let errors):
                print("🧐🧐🧐🧐🧐",errors)
                self.showAlert(error: errors)
            }
            group.leave()
        }
        
        group.enter()
        // MARK: 주간 날씨 데이터 요청
        URLSessionManager.shared.fetch(type: AllInOneModel.self, api: WeatherApi.foreCaseCity(id: cityId)) { result in
            switch result{
            case .success(let success):
                let divideDate = self.dateAssistance.devideCalendar(dateList: success.list)
                switch divideDate {
                case .success(let success):
                    // 날짜별로 나뉘어짐
                    // MARK: 이 로직 수정하는게 좋을듯 여기서 바로 순서에 맞게
                    self.dateIndexDictioary = self.dateAssistance.getSortedIndexList(DateDic: success)
//                    self.dateDictionry = success
                    // self.dateIndexCecction.
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
            guard let current = self.currentModel else {
                return
            }
            // MARK: 로직개선 4 -> 통합 모델로 변경후 재시도
            /// 각 색션별로 모델을 구분위함
            // self.logicUpdateSection(currentModel: current, forecastModel:  self.threeItems())
            self.homeView.tableView.reloadData()
        }
        
      
        
        
    }
    // MARK: 로직 개선 작업 3
//    func logicUpdateSection(currentModel: WeatherHomeViewModel, forecastModel: [List]) {
//        self.weatherViewSection = [
//            .currentWeather(currentModel),
//            .threeDatForecast(forecastModel),
//            .detailInfo(currentModel)
//        ]
//    }
    
    
    
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

        let section = homeSession.allCases[indexPath.row]
        // let totalItems = threeItems()
    
        // threeModel = totalItems
        // print("asdasdasdasd")
        switch section {
        case .threeTimeInterval:
            // print(secction)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainHomeTableViewCell.reusableIdentifier, for: indexPath) as? MainHomeTableViewCell else {
                print("셀 변환 실패")
                return UITableViewCell()
            }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.topView.label.text = section.title
            cell.backgroundColor = .clear
            cell.collectionView.reloadData()

            return cell
            
        case .fiveDayaInterval:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FiveDayIntervalTableCell.reusableIdentifier) as? FiveDayIntervalTableCell else {
                print("셀 변환실패 FiveDayIntervalTableCell")
                return UITableViewCell()
            }
            cell.fiveDelegate = self
            cell.label.label.text = section.title
            cell.tableView.reloadData()
            return cell
            
        case .location:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reusableIdentifier, for: indexPath) as? LocationTableViewCell else {
                print("셀 변환실패 LocationTableViewCell")
                return UITableViewCell()
            }
            cell.header.label.text = section.title
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
            
            cell.setModelData(model: currentData)
            return cell
        }
        // return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = currentModel else {
            print("모델이 없음.")
            return UIView()
        }
        let currentView = CurrentWeatherHeaderView()
        currentView.settingView(city: model.cityName, temp: model.temperature, weatherInfo: model.description, maxTemp: model.maxTemp, minTemp: model.minTemp)
        return currentView
    }
    // MARK: 테이블뷰셀 크기
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // MARK: 헤더뷰 크기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // 헤더뷰 동적계산 포기 없어졌다 생기는 과정에서 자동적일떄 24 여야 한다와 내부 적으론 더 커야 한다가 충돌됨
        return 240
    }
    
    
}
// MARK: 컬렉션뷰 데이타
extension WeatherMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return threeItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesWeatherCollecionViewCell.reusableIdentifier, for: indexPath) as? TimesWeatherCollecionViewCell else {
            print("컬렉션뷰 셀 에러")
            return UICollectionViewCell()
        }
        
        let modelData = threeItems()[indexPath.row]

        cell.settingCellElements(list: modelData, dateAssi: dateAssistance, image: modelData.weather.first?.icon)
    
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
        
        guard let representList = dateIndexDictioary[indexPath.row] else {
            print("데이터 받기 실패 dateIndexDictioary")
            return cell
        }
        
        guard let represent = representList.first else {
            print("대표 받기 실패")
            return cell
        }
        
        cell.settingImage(imageName: represent.weather.first?.icon ?? "")
        
        let dateWeekText = dateAssistance.getDayOfWeek(dtText: represent.dtTxt)
        
        let maxText = TemperatureAssistance.max(representList).getAverage
        
        let minText = TemperatureAssistance.min(representList).getAverage

        cell.settingLabelsText(dateWeek: dateWeekText, maxText: maxText, minText: minText)
        return cell
    }
    
    
}

//#Preview{
//    WeatherMainViewController()
//}
// MARK: 해당 변수에 쓸모가 없음
//    var dateDictionry = dateDictionryForString() {
//        didSet{
//            dateIndexDictioary = dateAssistance.getSortedIndexList(DateDic: dateDictionry)
//        }
//    }
// [Int:[List]]

// MARK: 통합모델 테스트 구역
// 통신 테스트 1차 통과 -> currentCity 안되는중
// 2차 통과 알고보니 날짜를 나눌 필요가 없었음. 그래서 날짜를 나누는 메서드에서 터진거였음
// 3차 데이터 확인 통과
// 4차 데이터 통과

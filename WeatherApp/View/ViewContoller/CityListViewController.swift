//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
class CityListViewController : BaseViewController {
    let homeview = CityListHomeView()
    var citiInfo: [CityInfoModel] = []
    
    override func loadView() {
        self.view = homeview
    }
    override func designView() {
        jsonDataLoad()
        
    }
    
    override func delegateDataSource() {
        homeview.tableView.dataSource = self
        homeview.tableView.delegate = self
        
    }
    
    ///https://jiseobkim.github.io/swift/network/2021/05/16/swift-JSON-%ED%8C%8C%EC%9D%BC-%EB%B6%88%EB%9F%AC%EC%98%A4%EA%B8%B0.html
    private func jsonDataLoad(){
        let fileName: String = "CityList1"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            print("json파일 찾기 실패")
            return
        }
        do {
            let data = try Data(contentsOf: fileLocation)
            
            do{
                let datas = try JSONDecoder().decode([CityInfoModel].self, from: data)
                citiInfo.append(contentsOf: datas)
            }catch {
                print("일단 에러처리는 나중이지만 json데이터 에러")
            }
            
        } catch {
            print("일단 에러처리는 나중이지만 json데이터 에러2")
        }
        
        print(citiInfo)
    }
}

extension CityListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.reusableIdentifier, for: indexPath) as? CityInfoTableViewCell else {
            
            print("cell CityInfoTableViewCell 실패")
            return UITableViewCell()
        }
        
        let cellInfo = citiInfo[indexPath.row]
        cell.cityNameLabel.text = cellInfo.name
        cell.countryLabel.text = cellInfo.country
        return cell
    }
    // MARK: 셀 선택시 전뷰로 가면서 해당 도시 아이디 보내줌
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


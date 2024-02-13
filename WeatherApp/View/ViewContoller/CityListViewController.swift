//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
typealias cityInfoModels = [CityInfoModel]

final class CityListViewController : BaseViewController {
    let homeview = CityListHomeView()
    var citiInfo: cityInfoModels = []
    var getCityId: ((Int) -> Void )?
    var filterModel: cityInfoModels?
    var navigationTitle: String?
    
    override func loadView() {
        self.view = homeview
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation()
        
        
    }
    
    func settingNavigation() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = leftItem
    }
    @objc
    func backButtonAction(){
        dismiss(animated: true)
    }
    override func delegateDataSource() {
        homeview.tableView.dataSource = self
        homeview.tableView.delegate = self
        homeview.searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jsonDataLoad()
        self.navigationItem.title = navigationTitle
    }
    ///https://jiseobkim.github.io/swift/network/2021/05/16/swift-JSON-%ED%8C%8C%EC%9D%BC-%EB%B6%88%EB%9F%AC%EC%98%A4%EA%B8%B0.html
    fileprivate func jsonDataLoad(){
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
        
        print("🍟🍟🍟🍟🍟🍟🍟")
    }
}

extension CityListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let filterModel = filterModel else {
            return citiInfo.count
        }
        return filterModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.reusableIdentifier, for: indexPath) as? CityInfoTableViewCell else {
            
            print("cell CityInfoTableViewCell 실패")
            return UITableViewCell()
        }
        if let filter = filterModel {
            print("'asdsadasdsadadasdsadasd")
            let cellInfo = filter[indexPath.row]
            print("😤😤😤😤😤😤",cellInfo.name,cellInfo.country)
            cell.cityNameLabel.text = cellInfo.name
            cell.countryLabel.text = cellInfo.country
            return cell
        }
        let cellInfo = citiInfo[indexPath.row]
        cell.cityNameLabel.text = cellInfo.name
        cell.countryLabel.text = cellInfo.country
        return cell
    }
    // MARK: 셀 선택시 전뷰로 가면서 해당 도시 아이디 보내줌
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let filter = filterModel {
            getCityId?( filter[indexPath.row].id)
            dismiss(animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        getCityId?(citiInfo[indexPath.row].id)
        print(citiInfo[indexPath.row].id)
        dismiss(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CityListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            homeview.endEditing(true)
            return
        }
        guard searchText != "" else {
            filterModel = nil
            print("no you have text baby")
            return
        }
        let result = SearchAssistance().findCity(for: searchText, cityModel: citiInfo)
        filterModel = result
        self.homeview.tableView.reloadData()
        homeview.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            filterModel = nil
            self.homeview.tableView.reloadData()
            return
        }
        let result = SearchAssistance().findCity(for: searchText, cityModel: citiInfo)
        filterModel = result
        self.homeview.tableView.reloadData()
    }
    
}


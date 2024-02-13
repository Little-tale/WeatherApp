//
//  CityListHomeView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit

final class CityListHomeView: BaseView {
    let titleLabel: UILabel = {
       let view = UILabel()
        view.text = " 도시"
        view.textColor = .white
        view.font = .systemFont(ofSize: 40,weight: .heavy)
        return view
    }()
    let searchBar: UISearchBar = {
       let view = UISearchBar()
        view.barStyle = .black
        view.placeholder = "도시를 검색하세요"
        view.tintColor = .white
        view.searchTextField.textColor = .white
        return view
    }()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).inset( -8 )
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    override func designView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        self.backgroundColor = .black
        self.tableView.backgroundColor = UIColor(white: 0, alpha: 1)
    }
    override func register() {
        tableView.register(CityInfoTableViewCell.self, forCellReuseIdentifier: CityInfoTableViewCell.reusableIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusableIdentifier)
    }
    
    
    
}

//
//  MainHomeView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit

class MainHomeView: BaseView {
    let currentView = CurrentWeatherHeaderView()
    let tableView = UITableView()
    let tabview = CustomTabbarView()
    override func configureHierarchy() {
        self.addSubview(tabview)
        self.addSubview(tableView)
        self.backgroundColor = .clear
        tableView.backgroundColor = .clear
        // currentView.backgroundColor = UIColor(white: 0, alpha: 1)
        
    }
    override func configureLayout() {
        tabview.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(54)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(tabview.snp.top)
        }
    }
    
    override func register() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusableIdentifier)
        tableView.register(MainHomeTableViewCell.self, forCellReuseIdentifier: MainHomeTableViewCell.reusableIdentifier)
        tableView.register(FiveDayIntervalTableCell.self, forCellReuseIdentifier: FiveDayIntervalTableCell.reusableIdentifier)
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reusableIdentifier)
    }
}

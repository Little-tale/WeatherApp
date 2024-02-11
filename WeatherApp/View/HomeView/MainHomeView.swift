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
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func register() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusableIdentifier)
        tableView.register(MainHomeTableViewCell.self, forCellReuseIdentifier: MainHomeTableViewCell.reusableIdentifier)
    }
}

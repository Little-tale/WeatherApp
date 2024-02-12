//
//  FiveDayIntervalCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit

protocol FiveDayIntervalProtocol: AnyObject {
    func FivetableView(for FiveDayIntervalTableCell: UITableViewCell, tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func FivetableView(for FiveDayIntervalTableCell: UITableViewCell, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}


class FiveDayIntervalTableCell: BaseTableCell {
    let label = IntervalLabelView()
    let tableView = UITableView()
    
    weak var fiveDelegate: FiveDayIntervalProtocol?
    
    override func configureHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(tableView)
    }
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.height.equalTo(240)
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(label.snp.bottom).inset(8)
        }
        label.backgroundColor = .black
    }
    
    override func register() {
        tableView.register(FiveInnerTableViewCell.self, forCellReuseIdentifier: FiveInnerTableViewCell.reusableIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
    }
}


extension FiveDayIntervalTableCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDelegate?.FivetableView(for: self, tableView: tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return fiveDelegate?.FivetableView(for: self, tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    
}

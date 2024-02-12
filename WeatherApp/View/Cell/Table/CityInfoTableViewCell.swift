//
//  CityInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit

class CityInfoTableViewCell: BaseTableCell {
    let shapImage = UIImageView()
    let cityNameLabel = UILabel()
    let countryLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(shapImage)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(countryLabel)
        
    }
    override func configureLayout() {
        shapImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.size.equalTo(24)
        }
        cityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(shapImage.snp.trailing).offset(12)
            make.top.equalTo(shapImage.snp.top)
            make.trailing.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(cityNameLabel.snp.leading)
            make.trailing.equalTo(cityNameLabel.snp.trailing)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(8)
            make.height.equalTo(18)
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
    }
    override func designView() {
        shapImage.image = UIImage(systemName: "number")
        shapImage.tintColor = .white
        cityNameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        countryLabel.font = .systemFont(ofSize: 20, weight: .light)
        
        cityNameLabel.textColor = .white
        countryLabel.textColor = .white
        
        self.backgroundColor = UIColor(white: 0, alpha: 1)
        contentView.backgroundColor = UIColor(white: 0, alpha: 1)
        self.selectionStyle = .gray
        
    }
    
    
}

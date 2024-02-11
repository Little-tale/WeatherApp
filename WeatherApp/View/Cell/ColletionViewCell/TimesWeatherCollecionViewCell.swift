//
//  TimesWeatherCollecionViewCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class TimesWeatherCollecionViewCell: BaseCollectionViewCell{
    let timeLabel = UILabel()
    let weatherImageView = UIImageView()
    let tempLabel = UILabel()
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(tempLabel)
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
    }
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    override func designView() {
        timeLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        timeLabel.text = "더"
        tempLabel.text = "미"
        
        timeLabel.backgroundColor = .red
        tempLabel.backgroundColor = .blue
        weatherImageView.backgroundColor = .green
        stackView.backgroundColor = .lightGray
    }
    
}

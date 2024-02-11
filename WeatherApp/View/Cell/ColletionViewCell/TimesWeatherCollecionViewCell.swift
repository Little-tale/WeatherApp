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
        // self.layoutIfNeeded()
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(tempLabel)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        // stackView.insetsLayoutMarginsFromSafeArea = true

        stackView.alignment = .center
        stackView.spacing = 8
    }
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        weatherImageView.snp.makeConstraints { make in
            // make.size.equalTo(CGSize(width: 30, height: 30))
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(weatherImageView.snp.width)
        }
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalToSuperview()
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

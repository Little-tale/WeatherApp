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
        stackView.distribution = .equalSpacing

        stackView.alignment = .center
        stackView.spacing = 8
    }
    override func configureLayout() {
        // self.layoutIfNeeded()
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        weatherImageView.snp.makeConstraints { make in
            
            make.width.equalTo(stackView.snp.width).multipliedBy(0.8).priority(700)
            make.height.equalTo(weatherImageView.snp.width).priority(700)
        }
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.height.equalTo(20) 
        }
    }
    override func designView() {
        timeLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        timeLabel.text = "더dsasdas"
        tempLabel.text = "미"
        
        timeLabel.backgroundColor = .red
        tempLabel.backgroundColor = .blue
        weatherImageView.backgroundColor = .green
        weatherImageView.image = UIImage(systemName: "star")
        stackView.backgroundColor = .lightGray
    }
    
}



//        self.layoutIfNeeded()
//        timeLabel.snp.makeConstraints { make in
//            make.height.equalTo(20)
//            //make.width.equalToSuperview()
//        }
//        weatherImageView.snp.makeConstraints { make in
//            // make.size.equalTo(CGSize(width: 30, height: 30))
//            make.horizontalEdges.equalToSuperview().inset(8)
//           make.height.equalTo(weatherImageView.snp.width)
//        }
//
//        tempLabel.snp.makeConstraints { make in
//            make.height.equalTo(20)
//            //make.width.equalToSuperview()
//        }

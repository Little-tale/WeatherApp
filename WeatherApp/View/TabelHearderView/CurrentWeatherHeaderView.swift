//
//  CurrentWeatherHeaderView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit

class CurrentWeatherHeaderView: BaseView {
    let cityNameLabel = UILabel()
    let tempLabel = UILabel()
    let weatherInfoLabel = UILabel()
    let maxTempLabel = UILabel()
    let minTempLabel = UILabel()
    lazy var allLabelArray: Array<UILabel> = [cityNameLabel, tempLabel, weatherInfoLabel, maxTempLabel, minTempLabel,middleLabel]
    
    private let middleLabel: UILabel = {
       let view = UILabel()
        view.backgroundColor = .clear
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 24)
        view.text = "|"
        return view
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(cityNameLabel)
        self.addSubview(tempLabel)
        self.addSubview(weatherInfoLabel)
        self.addSubview(maxTempLabel)
        self.addSubview(minTempLabel)
        self.addSubview(middleLabel)
        self.backgroundColor = .clear
    }
    override func configureLayout() {
        self.backgroundColor = .black
        tempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(tempLabel.snp.width).multipliedBy(0.5)
        }
        cityNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tempLabel.snp.top).inset(-8)
            make.top.greaterThanOrEqualToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        weatherInfoLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(cityNameLabel)
            make.height.equalTo(26)
            make.top.equalTo(tempLabel.snp.bottom)
        }
        middleLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherInfoLabel.snp.bottom)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(12)
            make.width.equalTo(8)
        }
        maxTempLabel.snp.makeConstraints { make in
            make.top.height.equalTo(middleLabel)
            make.leading.lessThanOrEqualTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(middleLabel.snp.leading).offset(-10)
        }
        minTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(middleLabel.snp.trailing).offset(10)
            make.top.height.equalTo(middleLabel)
            make.trailing.greaterThanOrEqualToSuperview()
        }
     
    }
    func settingView(city:String, temp:String, weatherInfo: String, maxTemp: String, minTemp: String){
        
        cityNameLabel.text = city
        tempLabel.text = temp
        weatherInfoLabel.text = weatherInfo
        maxTempLabel.text = maxTemp
        minTempLabel.text = minTemp
        
    }
    
    
    override func designLayoutSubView() {
        tempLabelSetting()
        cityNameSetting()
        weatherInfoSetting()
        maxAndMinLabelSetting()
        // tester()
    }
    
    private func configureLabelStyle(label: UILabel,textAligment: NSTextAlignment, textColor: UIColor){
        label.textAlignment = textAligment
        label.textColor = textColor
    }
    
    private func tempLabelSetting(){
        let fontSize = tempLabel.bounds.height
        tempLabel.font = .systemFont(ofSize: fontSize, weight: .thin )
    }
    
    private func cityNameSetting(){
        let i = cityNameLabel
        i.font = .systemFont(ofSize: 30, weight: .semibold)
    }
    
    private func weatherInfoSetting(){
        weatherInfoLabel.font = .systemFont(ofSize: 20)
    }
    
    private func maxAndMinLabelSetting(){
        maxTempLabel.font = .systemFont(ofSize: 20,weight: .light)
        minTempLabel.font = .systemFont(ofSize: 20, weight: .light)
        minTempLabel.textAlignment = .left
        maxTempLabel.textAlignment = .right
    }
    
    private func tester(){
        weatherInfoLabel.text = "Broken Clouds"
        cityNameLabel.text = "Jeju City"
        tempLabel.text = "5.9°"
        maxTempLabel.text = "최고:7.0°"
        minTempLabel.text = "최저:-4.2°"
    }
    override func designView() {
        for label in allLabelArray {
            configureLabelStyle(label: label, textAligment: .center, textColor: .white)
        }
    }
}

#Preview{
    WeatherMainViewController()
}

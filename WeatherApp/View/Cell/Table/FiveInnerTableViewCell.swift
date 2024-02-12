//
//  FiveInnerTableViewCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit
import Kingfisher
class FiveInnerTableViewCell: BaseTableCell {
    let dateWeekLabel = UILabel()
    let weatherImageView = UIImageView()
    let minTextlabel = UILabel()
    let maxTextLabel = UILabel()
    
    lazy var allLabelList = [dateWeekLabel, minTextlabel, maxTextLabel]
    
    
    override func configureHierarchy() {
        contentView.addSubview(dateWeekLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(minTextlabel)
        contentView.addSubview(maxTextLabel)
    }
    override func configureLayout() {
        super.configureLayout()

        dateWeekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualTo(weatherImageView.snp.leading).offset(-8)
        }

        weatherImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dateWeekLabel.snp.trailing).offset(8).priority(.high)
            make.trailing.lessThanOrEqualTo(minTextlabel.snp.leading).offset(-8)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }

        minTextlabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing).offset(8)
            make.bottom.equalTo(weatherImageView.snp.centerY).offset(-2)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }

        maxTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(minTextlabel.snp.leading)
            make.top.equalTo(weatherImageView.snp.centerY).offset(2)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    override func settingImage(imageName: String) {
        do {
            let url = try ImageAssistance().getImageUrl(imageName: imageName)
            weatherImageView.kf.setImage(with: url,placeholder: UIImage(systemName: "sun.max.trianglebadge.exclamationmark"))
        } catch(let error) {
            print(error)
        }
        
    }

}

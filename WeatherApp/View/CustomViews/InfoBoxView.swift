//
//  InfoBoxView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit
class InfoBoxView: BaseView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let detailLabel = UILabel()
    
    
    
    override func configureHierarchy() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
        self.addSubview(detailLabel)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaInsets).inset(8)
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset(8)
            make.top.equalTo(imageView.snp.top)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(24)
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.height.equalTo(40)
        }
        detailLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(infoLabel)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(24)
        }
    }
    
    override func designView() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .light)
        infoLabel.font = .systemFont(ofSize: 30, weight: .bold)
        detailLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        titleLabel.textColor = .white
        infoLabel.textColor = .white
        detailLabel.textColor = .white
        
        imageView.contentMode = .scaleAspectFill
    }
    
    
}

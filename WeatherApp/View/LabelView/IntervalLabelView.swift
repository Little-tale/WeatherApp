//
//  IntervalLabelView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit
class IntervalLabelView: BaseView {
    let imageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "calendar")
        return view
    }()
    let label = UILabel()
    
    override func configureHierarchy() {
        self.addSubview(self.imageView)
        self.addSubview(label)
    }
    override func designView() {
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset( -8 )
            make.verticalEdges.equalToSuperview()
            make.trailing.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(8)
        }
    }
    func settingLabel(time: Int) {
        let stringNum = String(time)
        
        label.text = stringNum+"시간 간격의 일기예보"
    }
}

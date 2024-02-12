//
//  CustomTabbarView.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import SnapKit

class CustomTabbarView: BaseView {
    
    let mapButton : UIButton = {
        var view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "map"), for: .normal)
        view.clipsToBounds = true
        view.tintColor = .white
        return view
    } ()
    let listButton : UIButton = {
        var view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "list.bullet"), for: .normal)
        view.clipsToBounds = true
        view.tintColor = .white
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(mapButton)
        self.addSubview(listButton)
    }
    override func configureLayout() {
        mapButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(12)
            make.size.equalTo(40)
        }
        listButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.verticalEdges.equalTo(mapButton)
            make.size.equalTo(mapButton)
        }
    }
    
    override func designView() {
        self.backgroundColor = UIColor(.black)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let line = CALayer()
            line.borderColor = UIColor.white.cgColor
        line.frame = CGRect(x: 0, y: 0.5, width: self.frame.width, height: 0.5)
        line.borderWidth = 0.5
        self.layer.addSublayer(line)
    }
    
}

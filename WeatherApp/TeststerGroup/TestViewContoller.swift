//
//  TestViewContoller.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit
class TestViewContoller: UIViewController {
    let test = CurrentWeatherHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(test)
            
        test.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
            
        }
        
    }
    
    
    
}

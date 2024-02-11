//
//  BaseCollecionViewCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        all()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        all()
    }
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func designView(){
        
    }
}

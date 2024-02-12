//
//  BaseCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit

class BaseTableCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        register()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func designView(){
        
    }
    func register(){
        
    }
    func settingImage(imageName: String){
        
    }
    
}

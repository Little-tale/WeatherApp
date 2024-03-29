//
//  MainHomeTableViewCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import SnapKit

class MainHomeTableViewCell:BaseTableCell {
    let topView = IntervalLabelView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCellLayout)
    
    override func configureHierarchy() {
        contentView.addSubview(topView)
        contentView.addSubview(collectionView)
    }
    override func configureLayout() {
        topView.snp.makeConstraints { make in
            // make.size.equalTo(20).priority(400)
            // make.width.equalTo(20)
            make.height.equalTo(60)
            make.horizontalEdges.top.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).inset(12)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(160).priority(800)
        }
    }
    
    override func register(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reusableIdentifier)
        collectionView.register(TimesWeatherCollecionViewCell.self, forCellWithReuseIdentifier: TimesWeatherCollecionViewCell.reusableIdentifier)
        // 알파값 터치 위함
        collectionView.backgroundColor = UIColor(white: 0, alpha: 1)
        self.backgroundColor = UIColor(white: 0, alpha: 1)
    }
    
    var configureCellLayout : UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing : CGFloat = 10
        
        let cellWidth = UIScreen.main.bounds.width - (spacing * 6)
        
        let cellDi = cellWidth / 5
        
        layout.itemSize = CGSize(width: cellDi , height: cellDi * 1.8) // 셀의 크기
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}

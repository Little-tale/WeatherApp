//
//  locationTableCell.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/12/24.
//

import UIKit
import MapKit
import SnapKit

class LocationTableViewCell: BaseTableCell {
    let header = IntervalLabelView()
    let WindBoxView = InfoBoxView()
    let cloudBoxView = InfoBoxView()
    let giappBoxView = InfoBoxView()
    let supdoBoxView = InfoBoxView()
    let mapView : MKMapView = {
       
        // satellite 는 Couldn't find satellite.styl in framework, file name satellite.styl 라는 에러를 발생
        // 애플 공식문서 에 따르면 더이상 사용되지 않음 이라고 명시되어있음
        // ios기준 3.0 ~ 13.0 지원중단
        // -> 대신 지도 표시 방식을 지정하려면 하위 클래스와 함께 지도 보기의 속성을 사용하라고 되어있음
        // view.mapType = .satelliteFlyover
//        let configuration = MKMapConfiguration()
//        configuration.elevationStyle = .flat
        let view = MKMapView(frame: .zero)
        view.selectableMapFeatures = [.pointsOfInterest,//박물관 카페, 공원 학교등 시설을 나타내주는 옵션
                                      .physicalFeatures,// 산맥 하천 해양 분지 등의 물리적 지도상의 특징을 나타내는 옵션
                                      .territories // 국경 주경 이웃등 영토의 경계를 나타내는 옵션
        ]

        if #available(iOS 16.0 , *) {
            // 16.0 이상에서만 가능한 방식
            let config = MKStandardMapConfiguration()
            config.showsTraffic = true
            view.preferredConfiguration = config
        }else {
            view.mapType = .standard
        }
        
        return view
    }()
    
    
    
    override func configureHierarchy() {
        contentView.addSubview(header)
        contentView.addSubview(mapView)
        contentView.addSubview(WindBoxView)
        contentView.addSubview(cloudBoxView)
        contentView.addSubview(giappBoxView)
        contentView.addSubview(supdoBoxView)
    }
    override func configureLayout() {
        header.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(header)
            make.top.equalTo(header.snp.bottom).offset(12)
            make.height.equalTo(header.snp.width).multipliedBy(0.5)
        }
        ///
        WindBoxView.snp.makeConstraints { make in
            make.leading.equalTo(header)
            make.top.equalTo(mapView.snp.bottom).offset(12)
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 24).priority(600)
            make.height.equalTo(WindBoxView.snp.width)
            //.priority(800)
            // .inset(12)
        }
        cloudBoxView.snp.makeConstraints { make in
            make.trailing.equalTo(header)
            make.size.top.equalTo(WindBoxView)
        }
        giappBoxView.snp.makeConstraints { make in
            make.size.leading.equalTo(WindBoxView)
            make.top.equalTo(WindBoxView.snp.bottom).offset(12)
        }
        supdoBoxView.snp.makeConstraints { make in
            make.size.trailing.equalTo(cloudBoxView)
            make.top.equalTo(giappBoxView)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
    }
    override func designView() {
        self.backgroundColor = UIColor(white: 0, alpha: 1)
        contentView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        // mapView.mapType = .satellite
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        settingLocattion(lat: nil, lon: nil)
    }
    
    func settingLocattion(lat: Double?, lon: Double?){
        annotationSetting(lat: lat, lon: lon)
    }
    
    private func annotationSetting(lat: Double?, lon: Double?){
        let annotation = MKPointAnnotation()
        guard let lat = lat,
              let lon = lon else {
            let ant = mapView.annotations
            mapView.removeAnnotations(ant)
            return
        }
        let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let region = MKCoordinateRegion(center: cordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = cordinate
        
        mapView.addAnnotation(annotation)
    }
    
  
    
    func updateInfoBoxView(_ boxView: InfoBoxView, title: String, info: String, detail: String?) {
        boxView.titleLabel.text = title
        boxView.infoLabel.text = info
        boxView.detailLabel.text = detail ?? ""
        boxView.backgroundColor = .gray
    }

    
//    func testMirrorView(view: AnyObject, title: String, info: String,detail :String?){
//        let mirror = Mirror(reflecting: view)
//        
//        for child in mirror.children {
//            switch child.label {
//                
//            case .none:
//                <#code#>
//            case .some(_):
//                <#code#>
//            }
//        }
//    }
    /*
     func WindBoxInfoBoxView(title: String, info: String,detail :String?){
         WindBoxView.titleLabel.text = title
         WindBoxView.infoLabel.text = info
         guard let detail = detail else {
             return
         }
         WindBoxView.detailLabel.text = detail
     }
     
     func cloudBoxInfoBoxView(title: String, info: String,detail :String?){
         cloudBoxView.titleLabel.text = title
         cloudBoxView.infoLabel.text = info
         guard let detail = detail else {
             return
         }
         cloudBoxView.detailLabel.text = detail
     }
     
     func giAppBoxInfoBoxView(title: String, info: String,detail :String?){
         giappBoxView.titleLabel.text = title
         giappBoxView.infoLabel.text = info
         guard let detail = detail else {
             return
         }
         giappBoxView.detailLabel.text = detail
     }
     func supdoBoxViewInfoBoxView(title: String, info: String,detail :String?){
         supdoBoxView.titleLabel.text = title
         supdoBoxView.infoLabel.text = info
         guard let detail = detail else {
             return
         }
         supdoBoxView.detailLabel.text = detail
     }
     */
}

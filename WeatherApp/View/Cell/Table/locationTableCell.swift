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
    let mapView = MKMapView()
    
    
    
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
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(header)
            make.top.equalTo(header.snp.bottom).offset(12)
            make.height.equalTo(header.snp.width).multipliedBy(0.5)
        }
        WindBoxView.snp.makeConstraints { make in
            make.leading.equalTo(header)
            make.top.equalTo(mapView.snp.bottom).offset(12)
            make.height.equalTo(200).priority(800)
            make.width.equalTo(UIScreen.main.bounds.width / 2).inset(12)
        }
        cloudBoxView.snp.makeConstraints { make in
        
            make.leading.equalTo(WindBoxView.snp.trailing).offset(24)
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
        
        let region = MKCoordinateRegion(center: cordinate, latitudinalMeters: 14000, longitudinalMeters: 14000)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = cordinate
        
        mapView.addAnnotation(annotation)
    }
    
  
    
    func updateInfoBoxView(_ boxView: InfoBoxView, title: String, info: String, detail: String?) {
        boxView.titleLabel.text = title
        boxView.infoLabel.text = info
        boxView.detailLabel.text = detail ?? ""
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

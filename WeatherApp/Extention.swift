//
//  Extention.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/11/24.
//

import UIKit
import CoreLocation

extension UIView {
    static var reusableIdentifier : String {
        return String(describing: self)
    }
}

extension WeatherMainViewController {
    func checkDeviceLocationAuthorization() {
        
        //디바이스 자체의 위치서비스 활성 여부
        DispatchQueue.global().async {
            print("😅😅😅😅😅😅😅😅😅😅")
            if CLLocationManager.locationServicesEnabled() {
                //활성화 중이면,
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkUserLocationAuthorization(authorizationStatus: authorization)
                }
                
            } else {
                DispatchQueue.main.async {
                    self.infoToSetting()
                }
            }
        }
        
    }
    
    //MARK: 유저가 앱 기준으로 위치 권한 확인합니다.
    func checkUserLocationAuthorization(authorizationStatus :  CLAuthorizationStatus) {
        switch authorizationStatus{
        case .notDetermined: // 한번도 경험없어
            // 정확도
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 허락 요청
            locationManager.requestWhenInUseAuthorization()
        case .denied: // 거부
            infoToSetting()
        case .authorizedAlways: // 항상허용
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            let alert = UIAlertController(title: "권한 요청 실패", message: "설정 > 개인정보 > 위치권한 설정", preferredStyle: .alert)
            let check = UIAlertAction(title: "확인", style: .default)
            alert.addAction(check)
            present(alert, animated: true)
        }
    }
    
    func infoToSetting(){
        if let settingUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingUrl)
        } else {
            let alert = UIAlertController(title: "설정이동실패", message: "설정으로 이동하지 못했습니다.\n설정 > 개인정보 > 위치권한 설정", preferredStyle: .alert)
            let check = UIAlertAction(title: "확인", style: .default)
            alert.addAction(check)
            present(alert, animated: true)
        }
    }
}

extension WeatherMainViewController: CLLocationManagerDelegate {
    
    // MARK: 위치시작시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {
            locationManager.startUpdatingLocation()
            return
        }
        // 사용자 위치 찍을거면 여기서
        
        locationManager.stopUpdatingLocation()
    }
    // MARK: 위치 불러오기 실패시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "위치 불러오기 실패", message: "설정 > 개인정보 > 위치권한 설정", preferredStyle: .alert)
        let check = UIAlertAction(title: "확인", style: .default)
        alert.addAction(check)
        present(alert, animated: true)
    }
    // MARK: 권한 바뀜 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 재검사
        checkDeviceLocationAuthorization()
    }
    
}

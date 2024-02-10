//
//  DateAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

// 날짜를 파싱하기 위에 필요한건
// DateFormmatter -> TimeZone(세계 각 지역별 시간대가 달라 그 시간대를 나타내기 위한 파데타입이다.)
// 2024-02-10 06:00:00 형식
import Foundation

struct DateAssistance {
    let date = Date()
    let formatter = DateFormatter()
    let dateFor = "yyyy-MM-dd HH:mm:ss"
    
    func getTime(date: String) -> String{
        // string -> Date -> Date -> String
        // 데이트 포메터 -> 데이트포멧터 생성
        // -> 데이터 포멧 형식을 정함
        // -> 데이터 포멧에 해당 양식에 맞는 문자열 전달후 받음
        // -> 받고나서 형식을 변경함
        // -> 형식을 변경하였지만 타입을 String으로 변경
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = dateFor
        
        guard let dateDate = dateFormetter.date(from: date) else {return ""}
        
        // a 오전 오후 나옴
        dateFormetter.dateFormat = "dd:"
        
        dateFormetter.locale = Locale(identifier: "ko_KR")
        
        let dateString = dateFormetter.string(from: dateDate)
        
        return dateString
    }
}
    
}

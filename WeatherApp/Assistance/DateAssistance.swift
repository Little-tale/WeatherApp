//
//  DateAssistance.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

// 날짜를 파싱하기 위에 필요한건
// DateFormmatter -> TimeZone(세계 각 지역별 시간대가 달라 그 시간대를 나타내기 위한 파데타입이다.)
// 2024-02-10 06:00:00 형식
// API는 Timezone: 32400 이라는데
import Foundation

// https://velog.io/@loganberry/Swift-%EB%82%A0%EC%A7%9C%EC%99%80-%EC%8B%9C%EA%B0%84-%EB%8B%A4%EB%A3%A8%EA%B8%B0-2-feat.-DateFormatter-DateComponents

struct DateAssistance {
    static let shared = DateAssistance()
    private let dateFormatter = DateFormatter()
    
    private init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
    }
    // MARK: API 에서 받은 문자열을 날짜로 변환
    private func dateFromAPI(dtTxt: String) -> Date? {
        return dateFormatter.date(from: dtTxt)
    }
    // MARK: 시간 제거해서 날짜만 나오게 함
    private func getOnlyDate(date: Date) -> Date? {
        let calendar = Calendar.current
        let afterCalendar = calendar.date(from: calendar.dateComponents([.year,.month,.day], from: date))
        return afterCalendar
    }
    func devideCalendar() {
        
    }
    
    
    
}

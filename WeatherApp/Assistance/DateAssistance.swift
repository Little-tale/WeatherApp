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
typealias dataDictionry = [Date: [List]]
typealias resultDic = Result<dataDictionry, dateError>
typealias resultDic2 = Result<String,dateError>

enum dateError: Error {
    case cantChangeDate
    case cantOnlyDate
}

struct DateAssistance {
    // static let shared = DateAssistance()
    private let dateFormatter = DateFormatter()
    private var timeZone = 32400
    // 2024-02-15 12:00:00
    init(timeZone: Int) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // TimeZone을 안하고 하니 날짜가 나뉘어 지지 않는 현상 발생
        // dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        // print(TimeZone.current )
        // dateFormatter.timeZone.secondsFromGMT(for: timeZone)
        // TimeZone.current
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        self.timeZone = timeZone
        dateFormatter.locale = .autoupdatingCurrent
        print("🙀🙀🙀🙀🙀🙀🙀",timeZone)
        // dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    
    // MARK: API 에서 받은 문자열을 날짜로 변환
    private func dateFromAPI(dtTxt: String) -> Date? {
        // print(dtTxt)
        return dateFormatter.date(from: dtTxt)
    }
    
    
    // MARK: 시간 제거해서 날짜만 나오게 함
    // -> 캘린더로 하니 연도 넣어주어야 해서 생각해보니 넣어야 겠네
    private func getOnlyDate(date: Date) -> Date? {
        var calendar = Calendar.current
        if let timeZOne = TimeZone(secondsFromGMT: self.timeZone) {
            calendar.timeZone = timeZOne
            // calendar.locale = .init(identifier: "ko_KR")
        }
        print("🐣🐣🐣🐣🐣🐣",calendar)
        // print("🙌🙌🙌🙌🙌",calendar)
        let afterCalendar = calendar.date(from: calendar.dateComponents([.year,.month,.day], from: date))
        // print("🥸🥸🥸🥸🥸🥸",afterCalendar)
        print("🥸🥸🥸🥸🥸🥸",dateFormatter.string(from: date))
        return afterCalendar
    }
    
    
    // MARK: 날짜별 분리
    func devideCalendar(dateList: [List]) -> resultDic{
        // 날짜를 Key 로 value는 List 배열로
        
        var dateDic = [Date: [List]]()
        
        for myDate in dateList {
            guard let dateFormat = dateFromAPI(dtTxt: myDate.dtTxt) else {
                print("날짜 변환 실패")
                return .failure(.cantChangeDate)
            }
            print(dateFormat)
            guard let onlyDate = getOnlyDate(date: dateFormat) else {
                print("시간만 제거 실패")
                return .failure(.cantOnlyDate)
            }
            print(onlyDate)

            dateDic[onlyDate, default: []].append(myDate)
            
        }
        
//        for mydate in dateList {
//            if let date = dateFormatter.date(from: mydate.dtTxt),
//               let dateOnly = getOnlyDate(date: date){
//                dateDic[dateOnly, default: []].append(mydate)
//            }
//        }
        
        // print(dateDic)
        // 각 키에 8개 혹은 3개 등 으로 값을 가지고 있음
        return .success(dateDic)
    }
    func devideTime(DateDic: [Date: [List]]) {
        for (date, lists) in DateDic {
            print("🥰🥰🥰🥰🥰",date)
        }
    }
    
    var getTime: String {

        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let dateDate = dateFormetter.date(from: "yyyy-MM-dd HH:mm") else {return ""}
        
        // a 오전 오후 나옴
        dateFormetter.dateFormat = "HH:mm a"
        
        dateFormetter.locale = Locale(identifier: "ko_KR")
        
        let dateString = dateFormetter.string(from: dateDate)
        
        return dateString
    }
    
}
 



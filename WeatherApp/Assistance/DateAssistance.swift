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
typealias dateDictionryForString = [String:[List]]
typealias resultDic = Result<dataDictionry, dateError>
typealias resultDic2 = Result<dateDictionryForString,dateError>

enum dateError: Error {
    case cantChangeDate
    case cantOnlyDate
}

struct DateAssistance {
    // static let shared = DateAssistance()
    private let dateFormatter = DateFormatter()
    private var timeZone = 32400
    private var weatherApiDateFormat = "yyyy-MM-dd HH:mm:ss"
    var time:[Int] = []
    // 2024-02-15 12:00:00
    init(timeZone: Int) {
        dateFormatter.dateFormat = weatherApiDateFormat
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        self.timeZone = timeZone
        print("🙀🙀🙀🙀🙀🙀🙀",timeZone)
        
    }
    
    
    // MARK: API 에서 받은 문자열을 날짜로 변환
    func dateFromAPI(dtTxt: String) -> Date? {
        // print(dtTxt)
        return dateFormatter.date(from: dtTxt)
    }
    // MARK: dtTxt를 시간만 돌려드립니다
    func getOnlyTime(dtText:String) -> String{
        let date = dateFormatter.date(from: dtText)
        
        guard let date = date else {
            print("날짜 변환에 실패: getOnlyTime")
            return ""
        }
        
        var calendar = Calendar.current
        if let timeZOne = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timeZOne
             calendar.locale = .init(identifier: "ko_KR")
        }
        
        let timeCalendar = calendar.date(from: calendar.dateComponents([.hour], from: date))
        
        guard let timeString = timeCalendar?.description else {
            print("변환실패 getOnlyTime")
            return ""
        }
        
        let timeArray = timeString.components(separatedBy: " ")
        
        
        
        return timeArray[1]
    }
    
    // MARK: 시간 제거해서 날짜만 나오게 함
    // -> 캘린더로 하니 연도 넣어주어야 해서 생각해보니 넣어야 겠네
    private func getOnlyDate(date: Date) -> String? {
        var calendar = Calendar.current
        // 이유는 모르겠으나 0으로 주니 00:00:00 으로 잘 변환된다
        if let timeZOne = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timeZOne
             calendar.locale = .init(identifier: "ko_KR")
        }
        // 2024-02-14 18:00:00
        // 켈린더Date를 생성하는데 DateComponents 객체를 받아 Date를 추출합니다.
        // DateComponents는 각 년,월,일 만 추출합니다. -> 00:00:00 이 기댓값
        
        let afterCalendar = calendar.date(from: calendar.dateComponents([.year,.month,.day], from: date))
        
        // 이전스트링에 위 과정이 처리된 Date를 문자열로 변환시킵니다. 2024-01-01 ~~~
        var beforeString = afterCalendar?.description
        // 문자열에 -가 있다면 ""으로 변환시킵니다. 20240101 00:00:00: +0000 기댓값
        beforeString = beforeString?.replacingOccurrences(of: "-", with: "")
        // 공백을 기준으로 배열로 변환 시킵니다. -> ["20240215", "00:00:00", "+0000"]
        let beforeStringArray = beforeString?.components(separatedBy: " ")
        // 이중 첫번째만 밖으로 전달해 줍니다.
        // print(beforeStringArray)
        return beforeStringArray?.first
    }
    
    
    // MARK: 날짜별 분리
    func devideCalendar(dateList: [List]) -> resultDic2{
        // 날짜를 Key 로 value는 List 배열로
        
        var dateDic = [String: [List]]()
        var testDic = [Int: [List]]()
        var IndexPathRow = 0
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
            
            dateDic[onlyDate, default: []].append(myDate)
            
            testDic[IndexPathRow, default: []].append(myDate)
        }
        print(testDic.keys)
        return .success(dateDic)
    }
    
    
    //MARK: Dictionary Key를 순서대로 정렬 해드립니다.
    // -> 키값을 Int로 변환하는 기능을 추가하겠습니다.
    func getSortedIndexList(DateDic: [String: [List]]) -> [Int:[List]] {
        let sortedKeys = DateDic.keys.sorted()
        print(sortedKeys)
        
        var indexDictionary = [Int: [List]]()
        
        // sortedKeys.enumerated()
        // 배열을 각 0,1,2,3 같은 키순으로 튜플형 리스트
        for (indexKey, lists) in sortedKeys.enumerated() {
            if let list = DateDic[lists] {
                indexDictionary[indexKey] = list
            }
        }
        
        return indexDictionary
    }
    
    
    //MARK: 날짜를 요일로 변환해 드립니다.
    func getDayOfWeek(dtText: String) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = weatherApiDateFormat
        dateformatter.locale = Locale(identifier: "ko")
        let date = dateformatter.date(from: dtText)
        
        dateformatter.dateFormat = "E요일"
        guard let date = date else {
            print("날짜 변환 실패입니다.")
            return
        }
        let string = dateformatter.string(from: date)
        print(string)
    }
    
//    var getTime: String {
//        let dateFormetter = DateFormatter()
//        dateFormetter.dateFormat = "yyyy-MM-dd HH:mm"
//        guard let dateDate = dateFormetter.date(from: "yyyy-MM-dd HH:mm") else {return ""}
//        
//        // a 오전 오후 나옴
//        dateFormetter.dateFormat = "HH:mm a"
//        
//        dateFormetter.locale = Locale(identifier: "ko_KR")
//        
//        let dateString = dateFormetter.string(from: dateDate)
//        
//        return dateString
//    }
    
}
 



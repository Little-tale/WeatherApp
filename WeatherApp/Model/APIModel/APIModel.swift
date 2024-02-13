//
//  APIModel.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

protocol WeatherInfomation: Decodable{
    var weather: [Weather] {get}
    var main: Main {get}
    var wind: Wind {get}
}
//
// MARK: 통합 모델 구현준비중... WeatherApiCurrneMode + List
struct AllInOneModel: Decodable, WeatherInfomation {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let visibility: Int
    let dt: Int // 예측시간 데이터 계산 시간이라는데 이것도 해봐야 알것같음
    ///
    let coord: Coord?
    let clouds: Clouds?
    let pop: Double? // 강수확률
    let sys: Sys? // 일출 일몰 등
    let cod: String // Int로 올때 init에서 \() 문자열보간법 기릿
    let timezone, id: Int? // 초단위로 이동 이라는데 그게 참 뭘까
    let name: String?
    ///
    let dt_txt: String?
    
    enum CodingKeys: CodingKey {
        case weather
        case main
        case wind
        case visibility
        case dt
        case coord
        case clouds
        case pop
        case sys
        case cod
        case timezone
        case id
        case name
        case dt_txt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.main = try container.decode(Main.self, forKey: .main)
        self.wind = try container.decode(Wind.self, forKey: .wind)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.coord = try container.decodeIfPresent(Coord.self, forKey: .coord)
        self.clouds = try container.decodeIfPresent(Clouds.self, forKey: .clouds)
        self.pop = try container.decodeIfPresent(Double.self, forKey: .pop)
        self.sys = try container.decodeIfPresent(Sys.self, forKey: .sys)
        
        if let codString = try? container.decodeIfPresent(String.self, forKey: .cod) {
               self.cod = codString
           } else if let codInt = try? container.decodeIfPresent(Int.self, forKey: .cod) {
               self.cod = String(codInt)
           } else {
               self.cod = ""
           }
        
        self.timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.dt_txt = try container.decodeIfPresent(String.self, forKey: .dt_txt)
    }
}


// MARK: - 3시간씩 5일간 데이터 나옴
// 결론은 날짜를 여기에서 계산을 해야 한다는 것인데 각 하루마다 데이터를 뽑아서
// 거기서 평균을 내서 대표온도
// 심지어 3일간의 데이터만 필요함
// 무려 5일간 각 하루의 대표가 필요함
struct List: Decodable, WeatherInfomation {
    let dt: Int // 예측된 시간
    let main: Main // V
    let weather: [Weather] // V
    let wind: Wind // V
    let clouds : Clouds// V // 흐림정도
    let visibility: Int // V
    let pop: Double // 강수 확률
    // let sys: Sys // ? 하루중 일부?
    let dtTxt: String //MARK: -이부분이 날짜가 나옴 -> 2024-02-10 06:00:00 형식
    // let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop//, sys
        case dtTxt = "dt_txt"
       //  case rain
    }
}

// MARK: - WeatherAPIModel -> currentAPI,CurrentCity
struct WeatherAPIcurrentModel: Decodable, WeatherInfomation{
    let coord: Coord // V
    let weather: [Weather] // V
    //let base: String -> 계속 station만 나오는데 설명에도 매게변수라고 되있고 이게 뭘까
    let main: Main // 기압이 여깅 있구요. 습도도 여기
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int // 데이터 계산 시간이라는데 이것도 해보
    let sys: Sys
    let timezone, id: Int // 초단위로 이동한다는데 써봐야 뭔질 알것같음
    // let timezone_offset: Int
    let cityName: String // 도시이름
    let cod: Int // Int로 올때 init에서 \() 문자열보간법 기릿
    
    enum CodingKeys:String, CodingKey {
        case coord
        case weather
        case main
        case visibility
        case wind
        case dt
        case sys
        case timezone
        case id
        case cityName = "name"
        case cod
        case clouds
        // case timezone_offset
    }
    
}


// MARK: - ForeCastAPI, ForeCastCity
struct WeatherAPIForecastModel: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}





////////////////////////////////////
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord -> 위경도
struct Coord: Decodable { //
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    let humidity, pressure : Int
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity, pressure
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather -> 날씨 핵심
struct Weather: Decodable {
    /// main = 날씨 descroption = 더 자세한 날씨
    let main, description, icon: String
}

// MARK: - Wind -> 바람 세기, 나머지는 뭘까용?
struct Wind: Decodable {
    let speed: Double // 바람세기
    let deg: Int // ???
    let gust: Double? // 돌풍
}

////
///

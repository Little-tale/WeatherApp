//
//  WeaherAPIManager.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

typealias apiModel<T:Decodable> = Result<T,APIComponentsError>
typealias apiTester<T:Decodable> = Result<T,URLError>
typealias apiComponents = Result<URLRequest, Error>
typealias apiError = APIComponentsError
typealias urlError = URLError
// 통신을 할 유일무이 한 친구니 싱글톤
class URLSessionManager {
    private init() {}
    static let shared = URLSessionManager()
    
    func fetch<T:Decodable>(type: T.Type, api: UrlSession, completionHandler: @escaping (apiModel<T>) -> Void ){
        let urlRequestCase = makeURLComponents(api: api)
        // print(urlRequestCase)
        switch urlRequestCase{
        case .success(let urlRequest):
            URLSession.shared.dataTask(with:urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    
                    let result = self.DecodingTester(type: T.self, data: data, response: response, error: error)
                    //print("🤪🤪🤪🤪🤪🤪",result)
                    switch result {
                    case .success(let success):
                        completionHandler(.success(success))
                        print("성공~~~~~~~~~~~~~~~~")
                    case .failure(let error):
                        dump(error)
                        completionHandler(.failure(.componentsToUrlFail))
                    }
                }
            }.resume()
        //MARK: 주의
        case .failure(let error):
            dump(error)
            DispatchQueue.main.async {
                completionHandler(.failure(.noQuery))
            }
        }
    }
    
    
    //MARK: urlComponents 를 만들어 주거나 에러를 던져줍니다.
    private func makeURLComponents(api: UrlSession) -> apiComponents{
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        
        guard let urlQueryItems = api.query else {
            print("쿼리 아이템 변환실패 혹은 없음")
            return .failure(APIComponentsError.noQuery)
        }
        components.queryItems = urlQueryItems
        
        guard let componentsUrl = components.url else {
            print("컴포넌츠 url 변경 에러")
            return .failure(APIComponentsError.componentsToUrlFail)
        }
        // print(componentsUrl)
        let urlRequest = URLRequest(url: componentsUrl)
        print(urlRequest)
        return .success(urlRequest)
        
    }
    
    //MARK: URL 각종에러를 테스트하고 성공시 디코딩된 모델 실패시 Error를 줍니다.
    private func DecodingTester<T: Decodable>(type: T.Type,data: Data?, response: URLResponse?, error: Error?) -> apiTester<T> {
        
        guard error == nil else {
            print("Url Request 시 에러가 존재")
            return .failure(urlError.failRequest)
        }
        guard let data = data else {
            print("Data가 존재하지 않음")
            return .failure(urlError.noData)
        }
        // dump(String(data: data, encoding: .utf8))
        guard let response = response else{
            print("응답이 존재 하지 않음")
            return .failure(urlError.noResponse)
        }
        guard let response = response as? HTTPURLResponse else {
            print("응답 코드로 변경이 어려움")
            return .failure(urlError.errorResponse)
        }
        // print(response)
        do {
            try errorCodeCase(caseNum: response.statusCode)
            do{
                let decodingData = try JSONDecoder().decode(T.self, from: data)
                // print(decodingData)
                return .success(decodingData)
            } catch(let error) {
              
                print("🥸🥸🥸🥸🥸🥸",error)
                return .failure(.errorDecoding)
            }
            
        } catch(let error) {
            print("🥸🥸🥸🥸🥸🥸",error)
            return .failure(.errorDecoding)
        }
        
    }
    
    // MARK: 200번 성공시 아무런 동작을 수행하지 않습니다. 실패시에러를 던집니다.
    private func errorCodeCase(caseNum: Int) throws {
        switch caseNum {
        case 200: return // 200번 성공
        case 400: throw errorCode._400
        case 401: throw errorCode._401
        case 404: throw errorCode._404
        case 429: throw errorCode._429
        case 500...599: throw errorCode._5xx
        default:
            throw errorCode.not200
        }
    }
    
}


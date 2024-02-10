//
//  WeaherAPIManager.swift
//  WeatherApp
//
//  Created by Jae hyung Kim on 2/10/24.
//

import Foundation

typealias apiModel<T:Decodable> = Result<T,Error>
typealias apiComponents = Result<URLRequest, Error>
typealias apiError = APIComponentsError
typealias urlError = URLError
// 통신을 할 유일무이 한 친구니 싱글톤
class URLSessionManager {
    private init() {}
    static let shared = URLSessionManager()
    
    @discardableResult
    func fetch<T:Decodable>(type: T.Type, api: UrlSession, compltionHandler: @escaping (T) -> Void ) throws -> Error  {
        let urlRequestCase = makeURLComponents(api: api)
        switch urlRequestCase{
        case .success(let urlRequest):
            URLSession.shared.dataTask(with:urlRequest) { data, response, error in
                <#code#>
            }
        case .failure(let error):
            throw error
        }
    }
    
    
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
        
        let urlRequest = URLRequest(url: componentsUrl)
        return .success(urlRequest)
        
    }
    
    private func UrlTester<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> apiModel<T> {
        
        guard error == nil else {
            print("Url Request 시 에러가 존재")
            return .failure(urlError.failRequest)
        }
        guard let data = data else {
            print("Data가 존재하지 않음")
            return .failure(urlError.noData)
        }
        guard let response = response else{
            print("응답이 존재 하지 않음")
            return .failure(urlError.noResponse)
        }
        guard let response = response as? HTTPURLResponse else {
            print("응답 코드로 변경이 어려움")
            return .failure(urlError.errorResponse)
        }
        
        
    }
    
    private func errorCodeCase(caseNum: Int) throws-> Error{
        if caseNum == 400  {
            throw errorCode._400
        }
        if caseNum == 401 {
            throw errorCode._401
        }
        if caseNum == 404 {
            throw errorCode._404
        }
        if caseNum == 429 {
            throw errorCode._429
        }
        if caseNum > 500 {
            throw errorCode._5xx
        }
        
        
    }
    
}

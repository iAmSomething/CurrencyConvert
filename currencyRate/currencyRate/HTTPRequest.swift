//
//  HTTPRequest.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
//MARK: - 프로토콜 작성 예시
enum HTTPRequest {
    case getLatestCurrency
}
final class HTTPManager<T>: APIRequestProtocol where T: Decodable{
    typealias Response = T
    var path: String
    var method: HTTPMethod
    var parameters: [String : Any]?
    var apiType: HTTPRequest
    init(apiType: HTTPRequest) {
        self.apiType = apiType
        switch apiType {
        case .getLatestCurrency:
            var APIKey: String {
                Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String ?? ""
            }
            path = "latest?access_key=\(APIKey)"

            method = .get
        
        }
    }
}

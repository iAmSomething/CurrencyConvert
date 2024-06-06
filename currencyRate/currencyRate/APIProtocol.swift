//
//  APIProtocol.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
protocol APIProtocol {
    var baseURL: String { get }
    var APIKey: String { get }
}
extension APIProtocol {
    var APIKey: String {
        Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String ?? ""
    }
    var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
}

protocol APIRequestProtocol: APIProtocol {
    associatedtype Response: Decodable
    var path: String { get set }
    var method: HTTPMethod { get set }
    var parameters: [String: Any]? { get set }
}
extension APIRequestProtocol {
    var url: String {
       return baseURL + path
    }
    var parameters: [String: Any]? {
        ["access_key" : APIKey]
    }
    func fetchData() async -> Result<Response, APIError> {
        var failedData: Data? = nil
        do {
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = method.rawValue
            // 필요한 경우 파라미터 추가
//            if let parameters = parameters {
//                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
//                urlRequest.httpBody = jsonData
//            }

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            // 에러 처리 - 상태 코드 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.otherError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                failedData = data

                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Response.self, from: data)
                failedData = nil

                return .success(decodedResponse)
            case 400:
                print(httpResponse.description)
                return .failure(.httpError(.badRequestError))
            case 401, 403:
                return .failure(.httpError(.authError))
                
                // token refresh 하는 로직
            case 404:
                return .failure(.httpError(.notFoundError))
            case 500...505 :
                print(url)
                return .failure(.httpError(.serverError))
            default:
                return .failure(.httpError(.serverError))
            }
        } catch let urlError as URLError {
            return .failure(.urlError(urlError))
        } catch let decodingError as DecodingError {
            if let failed = failedData {
                do {
                    let json = try JSONSerialization.jsonObject(with: failed, options: []) as? [String: Any]
                    print("JSON Response: \(json ?? [:])")
                    failedData = nil
                    // Try decoding your model here
                } catch let error {
                    failedData = nil
                    print("Error decoding JSON: \(error)")
                }
            }
            print(decodingError.localizedDescription)
            print(decodingError.failureReason)
            print(decodingError.errorDescription)

            return .failure(.decodingError(decodingError))
        } catch {
            return .failure(.otherError)
        }
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
enum APIError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case otherError
    case httpError(HTTPError)
    var errorDescription: String {
        switch self{
        case .urlError(let urlError):
            urlError.localizedDescription
        case .decodingError(let decodingError):
            decodingError.failureReason ?? "디코딩 오류"
        case .otherError:
           "알 수 없는 오류입니다."
        case .httpError(let httpError):
            switch httpError {
            case .serverError:
                "서버 내부의 오류입니다."
            case .badRequestError:
                "리퀘스트 오류입니다."
            case .authError:
                "권한이 없습니다"
            case .notFoundError:
                "정보가 없습니다"
            }
        }
    }
}
enum HTTPError: Error{
    case serverError
    case badRequestError
    case authError
    case notFoundError
}

//
//  ITunesService.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

final class ITunesService {
    static let shared = ITunesService()
    
    private init() {}
    
    func fetchData<T: Decodable>(target: ITunesRequest) -> Single<T> {
        return Single.create { single in
            guard let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
                  let baseURL = URL(string: "https://\(baseUrlString)"),
                  var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
                single(.failure(NSError(domain: "Invalid URL", code: -1)))
                return Disposables.create()
            }
            
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "term", value: target.term),
//                URLQueryItem(name: "term", value: target.term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)),
                URLQueryItem(name: "country", value: target.country),
                URLQueryItem(name: "media", value: target.media),
                URLQueryItem(name: "limit", value: String(target.limit))
            ]
            components.queryItems = queryItems
            
            guard let url = components.url else {
                single(.failure(NSError(domain: "URL 구성 실패", code: -1)))
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.setValue("iTunesSearchApp/1.0", forHTTPHeaderField: "User-Agent")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    single(.failure(error))
                    return
                }
                
                guard let data else {
                    single(.failure(NSError(domain: "데이터 없음", code: -1)))
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    single(.success(decoded))
                } catch {
                    single(.failure(error))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

//
//  iTunesAPI.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import Foundation

struct iTuensRequest: Encodable {
    let term: String
    let country: String
    let media: String
    let limit: Int
}

//enum iTunesAPI {
//    case music(model: iTuensRequest)
//}
//
//extension iTunesAPI {
//    var baseURL: URL {
//        switch self {
//        case .music:
//            return URL(string: (Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String)!)!
//        }
//    }
//}

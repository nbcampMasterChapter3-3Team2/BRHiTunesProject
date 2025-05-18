//
//  ITunesRequest.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import Foundation

struct ITunesRequest: Encodable {
    let term: String
    let country: String
    let media: String
    let entity: String? = nil
    let limit: Int
}

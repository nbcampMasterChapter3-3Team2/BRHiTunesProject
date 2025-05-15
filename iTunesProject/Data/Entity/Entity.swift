//
//  Entity.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

struct MusicEntity {
    let trackName: String
    let collectionName: String?
    let artistName: String
    let albumUrl: String
    let thumbnailURL: String
}

struct PodcastEntity {
    let trackName: String
    let collectionName: String
    let artistName: String
    let albumUrl: String
    let recommedComment: String?
}

struct MovieEntity {
    let trackName: String
    let collectionName: String
    let primaryGenreName: String
    let artistName: String
    let albumUrl: String
}

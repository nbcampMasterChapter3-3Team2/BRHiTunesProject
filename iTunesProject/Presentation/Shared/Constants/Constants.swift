//
//  Constants.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import Foundation

enum Season: String {
    case spring
    case summer
    case fall
    case winter
    
    var sectionTitle: String {
        switch self {
        case .spring: "봄 Best"
        case .summer: "여름"
        case .fall: "가을"
        case .winter: "겨울"
        }
    }
}

enum iTuensMediaType: String {
    case music = "music"
    case movie = "movie"
    case podcast = "podcast"
}

enum Description: String {
    case spring = "봄에 어울리는 음악 Best 5"
}

enum PlaceholderText: String {
    case homeSearchBar = "영화, 팟캐스트"
}

enum Search: String {
    case podcast = "PodCast"
    case movie = "Movie"
}

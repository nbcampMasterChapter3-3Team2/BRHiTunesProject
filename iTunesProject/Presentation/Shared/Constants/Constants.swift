//
//  Constants.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import Foundation

enum Season: String {
    case spring = "봄"
    case summer = "여름"
    case fall = "가을"
    case winter = "겨울"
    
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

enum Search {
    case search(String)
    case podcast(String)
    case movie(String)
}

enum RecommendEmoji {
    static let podcastRecommendations = [
        "🔥 TRENDING NOW",
        "🎧 EDITOR’S PICK",
        "🗓 WEEKLY HIGHLIGHT",
        "⭐️ FEATURED SHOW",
        "🎙 JUST DROPPED",
        "📡 TOP PODCAST",
        "🎤 IN THE SPOTLIGHT",
        "🎯 DON’T MISS THIS",
        "📌 FOCUS ON"
    ]
}

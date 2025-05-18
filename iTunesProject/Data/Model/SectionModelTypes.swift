//
//  SectionModelTypes.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import RxDataSources

struct HomeHeader {
    let title: Season
    let subTitle: String
}

struct MusicSectionModel {
    let header: HomeHeader
    var items: [MusicEntity]
}

extension MusicSectionModel: SectionModelType {
    typealias Item = MusicEntity
    
    init(original: MusicSectionModel, items: [MusicEntity]) {
        self = original
        self.items = items
    }
}

enum Search {
    case search(String)
    case podcast(String)
    case movie(String)
}

struct SearchHeader {
    let title: Search
}

enum SearchItem {
    case podcast(PodcastEntity)
    case movie(MovieEntity)
    case empty(query: String)
}

struct SearchSectionModel {
    let header: SearchHeader
    var items: [SearchItem]
}

extension SearchSectionModel: SectionModelType {
    typealias Item = SearchItem
    
    init(original: SearchSectionModel, items: [SearchItem]) {
        self = original
        self.items = items
    }
}

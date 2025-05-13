//
//  Model.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import RxDataSources

struct MusicModel {
    let albumImage: UIImage
    let titleOfSong: String
    let singer: String
    let titleOfAlbum: String
}

struct Header {
    let title: Season
    let subTitle: String
}
struct MusicSectionModel {
    let header: Header
    var items: [MusicEntity]
}

extension MusicSectionModel: SectionModelType {
    typealias Item = MusicEntity
    
    init(original: MusicSectionModel, items: [MusicEntity]) {
        self = original
        self.items = items
    }
}

enum MusicSection {
    case spring(Header, [MusicModel])
    case summer(Header, [MusicModel])
    case fall(Header, [MusicModel])
    case winter(Header, [MusicModel])
}

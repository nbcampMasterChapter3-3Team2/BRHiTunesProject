//
//  RepositoryInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

protocol MusicRepositoryInterface {
    func seasonTheme(season: Season, limit: Int) -> Single<MusicResponse>
}

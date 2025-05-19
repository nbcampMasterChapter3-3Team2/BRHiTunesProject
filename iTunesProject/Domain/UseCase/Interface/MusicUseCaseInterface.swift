//
//  MusicUseCaseInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

protocol MusicUseCaseInterface {
    func fetchSeasonTheme(season: Season, limit: Int) -> Single<[MusicEntity]>
}

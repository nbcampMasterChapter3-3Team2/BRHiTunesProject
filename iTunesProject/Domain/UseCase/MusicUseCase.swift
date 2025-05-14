//
//  MusicUseCase.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

final class MusicUseCase: MusicUseCaseInterface {
    
    private let repository: MusicRepositoryInterface
    
    init(repository: MusicRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchSeasonTheme(season: Season, limit: Int) -> Single<[MusicEntity]> {
        return repository.seasonTheme(season: season, limit: limit).map { $0.results.map { $0.toEntity() }}
    }
}

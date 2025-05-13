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
    
    func fetchSpringTheme() -> Single<[MusicEntity]> {
        return repository.springTheme().map { $0.results.map { $0.toEntity() }}
    }
    
    func fetchSummerTheme() -> Single<[MusicEntity]> {
        return repository.summerTheme().map { $0.results.map { $0.toEntity() }}
    }
    
    func fetchFallTheme() -> Single<[MusicEntity]> {
        return repository.fallTheme().map { $0.results.map { $0.toEntity() }}
    }
    
    func fetchWinterTheme() -> Single<[MusicEntity]> {
        return repository.winterTheme().map { $0.results.map { $0.toEntity() }}
    }
}

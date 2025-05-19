//
//  SearchUseCase.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/14/25.
//

import Foundation

import RxSwift

final class SearchUseCase: SearchUseCaseInterface {
    
    private let repository: SearchRepositoryInterface
    
    init(repository: SearchRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchPodcasts(search: String) -> Single<[PodcastEntity]> {
        return repository.podcasts(search: search).map { $0.results.map { $0.toEntity()} }
    }
    
    func fetchMovies(search: String) -> Single<[MovieEntity]> {
        return repository.movies(search: search).map { $0.results.map { $0.toEntity()} }
    }
    
}

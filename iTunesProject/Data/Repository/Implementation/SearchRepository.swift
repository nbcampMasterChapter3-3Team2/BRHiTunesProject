//
//  SearchRepository.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/14/25.
//

import Foundation

import RxSwift

final class SearchRepository: SearchRepositoryInterface {
    
    private let repository = ITunesService.shared
    
    func podcasts(search: String) -> Single<PodcastResponse> {
        let request = ITunesRequest(term: search, country: "us", media: iTuensMediaType.podcast.rawValue, limit: 4)
        return repository.fetchData(target: request)
    }
    
    func movies(search: String) -> Single<MovieResponse> {
        let request = ITunesRequest(term: search, country: "us", media: iTuensMediaType.movie.rawValue, limit: 4)
        return repository.fetchData(target: request)
    }
    
}

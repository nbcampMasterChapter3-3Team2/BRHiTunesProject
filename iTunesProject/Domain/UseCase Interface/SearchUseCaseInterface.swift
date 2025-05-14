//
//  SearchUseCaseInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/14/25.
//

import Foundation

import RxSwift

protocol SearchUseCaseInterface {
    func fetchPodcasts(search: String) -> Single<[PodcastEntity]>
    func fetchMovies(search: String) -> Single<[MovieEntity]>
}

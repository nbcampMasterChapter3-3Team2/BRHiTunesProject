//
//  SearchRepositoryInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/14/25.
//

import Foundation

import RxSwift

protocol SearchRepositoryInterface {
    func podcasts(search: String) -> Single<PodcastResponse>
    func movies(search: String) -> Single<MovieResponse>
}

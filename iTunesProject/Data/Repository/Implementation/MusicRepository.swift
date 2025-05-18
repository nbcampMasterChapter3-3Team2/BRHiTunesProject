//
//  MusicRepository.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

final class MusicRepository: MusicRepositoryInterface {
    
    private let repository = ITunesService.shared
    
    func seasonTheme(season: Season, limit: Int) -> Single<MusicResponse> {
        let request = ITunesRequest(term: season.rawValue, country: "kr", media: iTuensMediaType.music.rawValue, limit: limit)
        return repository.fetchData(target: request)
    }
    
}

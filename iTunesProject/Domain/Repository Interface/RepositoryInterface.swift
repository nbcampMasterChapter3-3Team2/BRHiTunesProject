//
//  RepositoryInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

final class MusicRepositoryInterface: MusicRepository {
    private let repository = iTunesManager.shared
    
    func springTheme() -> Single<MusicResponse> {
        let request = iTuensRequest(term: Season.spring.rawValue, country: "kr", media: iTuensMediaType.music.rawValue, limit: 5)
        return repository.fetchData(target: request)
    }
    
    func summerTheme() -> Single<MusicResponse> {
        let request = iTuensRequest(term: Season.summer.rawValue, country: "kr", media: iTuensMediaType.music.rawValue, limit: 15)
        return repository.fetchData(target: request)
    }
    
    func fallTheme() -> Single<MusicResponse> {
        let request = iTuensRequest(term: Season.fall.rawValue, country: "kr", media: iTuensMediaType.music.rawValue, limit: 15)
        return repository.fetchData(target: request)
    }
    
    func winterTheme() -> Single<MusicResponse> {
        let request = iTuensRequest(term: Season.winter.rawValue, country: "kr", media: iTuensMediaType.music.rawValue, limit: 15)
        return repository.fetchData(target: request)
    }
    
}

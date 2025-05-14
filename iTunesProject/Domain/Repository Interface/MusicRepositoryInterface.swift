//
//  RepositoryInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

protocol MusicRepositoryInterface {
    func springTheme() -> Single<MusicResponse>
    func summerTheme() -> Single<MusicResponse>
    func fallTheme() -> Single<MusicResponse>
    func winterTheme() -> Single<MusicResponse>
}

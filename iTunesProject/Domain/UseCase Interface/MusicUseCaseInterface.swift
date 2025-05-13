//
//  MusicUseCaseInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

protocol MusicUseCaseInterface {
    func fetchSpringTheme() -> Single<[MusicEntity]>
    func fetchSummerTheme() -> Single<[MusicEntity]>
    func fetchFallTheme() -> Single<[MusicEntity]>
    func fetchWinterTheme() -> Single<[MusicEntity]>
}

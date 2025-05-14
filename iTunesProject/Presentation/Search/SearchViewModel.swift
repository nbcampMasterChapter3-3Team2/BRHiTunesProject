//
//  SearchViewModel.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

final class SearchViewModel: ViewModelProtocol {
    enum Action {
        case viewDidLoad
        case didBeginEditing
    }
    
    struct State {
        let home = BehaviorRelay<[SearchSectionModel]>(value: [])
    }
    
    var action: AnyObserver<Action> { actionSubject.asObserver() }
    
    private let actionSubject = PublishSubject<Action>()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let useCase = MusicUseCase(repository: MusicRepositoryInterface())
    
    init() {
        bind()
    }
    
    private func bind() {
        actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                case .viewDidLoad:
                    owner.fetchData()
                case .didBeginEditing:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchData() {
        let mockData: [SearchSectionModel] = [
            SearchSectionModel(
                header: SearchHeader(title: .search),
                items: []),
            SearchSectionModel(
                header: SearchHeader(title: .podcast),
                items: [
                SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test"),
                SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test"),
                SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test")
                ]),
            SearchSectionModel(
                header: SearchHeader(title: .movie),
                items: [
                    SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test"),
                    SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test"),
                    SearchEntity(trackName: "Test", artistName: "Test", artworkURL: "Test", collectionName: "test")
                ])
        ]
        
        self.state.home.accept(mockData)
        
//        Single.zip(
//            useCase.fetchSpringTheme(),
//            useCase.fetchSummerTheme(),
//            useCase.fetchFallTheme(),
//            useCase.fetchWinterTheme())
//        .map { springs, summers, falls, winters -> [MusicSectionModel] in
//            return [
//                MusicSectionModel(header: HomeHeader(title: Season.spring, subTitle: "봄에 어울리는 음악 Best 5"), items: springs),
//                MusicSectionModel(header: HomeHeader(title: Season.summer, subTitle: "여름에 어울리는 음악"), items: summers),
//                MusicSectionModel(header: HomeHeader(title: Season.fall, subTitle: "가을에 어울리는 음악"), items: falls),
//                MusicSectionModel(header: HomeHeader(title: Season.winter, subTitle: "겨울에 어울리는 음악"), items: winters)
//            ]
//        }
//        .subscribe(with: self) { owner, sectionModels in
//            
//        } onFailure: { owner, error in
//            print("Single Zip Error: \(error)")
//        }
//        .disposed(by: disposeBag)
    }
}

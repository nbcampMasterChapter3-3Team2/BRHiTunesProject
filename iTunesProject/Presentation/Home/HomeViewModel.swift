//
//  HomeViewModel.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

final class HomeViewModel: ViewModelProtocol {
    enum Action {
        case viewDidLoad
        case didBeginEditing
    }
    
    struct State {
        let home = BehaviorRelay<[MusicSectionModel]>(value: [])
    }
    
    var action: AnyObserver<Action> { actionSubject.asObserver() }
    
    private let actionSubject = PublishSubject<Action>()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let useCase: MusicUseCase
    
    init(useCase: MusicUseCase) {
        self.useCase = useCase
        
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
        Single.zip(
            useCase.fetchSeasonTheme(season: .spring, limit: 5),
            useCase.fetchSeasonTheme(season: .summer, limit: 15),
            useCase.fetchSeasonTheme(season: .fall, limit: 15),
            useCase.fetchSeasonTheme(season: .winter, limit: 15))
        .map { springs, summers, falls, winters -> [MusicSectionModel] in
            return [
                MusicSectionModel(header: HomeHeader(title: Season.spring, subTitle: "봄에 어울리는 음악 Best 5"), items: springs),
                MusicSectionModel(header: HomeHeader(title: Season.summer, subTitle: "여름에 어울리는 음악"), items: summers),
                MusicSectionModel(header: HomeHeader(title: Season.fall, subTitle: "가을에 어울리는 음악"), items: falls),
                MusicSectionModel(header: HomeHeader(title: Season.winter, subTitle: "겨울에 어울리는 음악"), items: winters)
            ]
        }
        .subscribe(with: self) { owner, sectionModels in
            owner.state.home.accept(sectionModels)
        } onFailure: { owner, error in
            print("Single Zip Error: \(error)")
        }
        .disposed(by: disposeBag)
    }
}

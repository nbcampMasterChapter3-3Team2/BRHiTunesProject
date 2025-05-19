//
//  HomeViewModel.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift
import RxRelay

final class HomeViewModel: ViewModelProtocol {
    //MARK: Action
    enum Action {
        case viewDidLoad
    }
    
    //MARK: State
    struct State {
        let home = BehaviorRelay<[MusicSectionModel]>(value: [])
    }
    
    //MARK: Instances
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
                MusicSectionModel(header: HomeHeader(title: Season.spring, subTitle: Description.spring.rawValue), items: springs),
                MusicSectionModel(header: HomeHeader(title: Season.summer, subTitle: Description.summer.rawValue), items: summers),
                MusicSectionModel(header: HomeHeader(title: Season.fall, subTitle: Description.fall.rawValue), items: falls),
                MusicSectionModel(header: HomeHeader(title: Season.winter, subTitle: Description.winter.rawValue), items: winters)
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

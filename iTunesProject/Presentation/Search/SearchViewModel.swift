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
        let search = BehaviorRelay<[SearchSectionModel]>(value: [])
    }
    
    var action: AnyObserver<Action> { actionSubject.asObserver() }
    
    private let actionSubject = PublishSubject<Action>()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let useCase = SearchUseCase(repository: SearchRepository())
    
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
        Single.zip(
            useCase.fetchPodcasts(search: "marvel"),
            useCase.fetchMovies(search: "marvel"))
        .map { podcasts, movies -> [SearchSectionModel] in
            let podcastItems = podcasts.map { SearchItem.podcast($0) }
            let movieItems = movies.map { SearchItem.movie($0) }
            return [
                SearchSectionModel(
                    header: SearchHeader(title: .search),
                    items: []
                ),
                SearchSectionModel(
                    header: SearchHeader(title: .podcast),
                    items: podcastItems
                ),
                SearchSectionModel(
                    header: SearchHeader(title: .movie),
                    items: movieItems
                )
            ]
        }
        .subscribe(with: self) { owner, sectionModels in
            owner.state.search.accept(sectionModels)
        } onFailure: { owner, error in
            print("Single Zip Error: \(error)")
        }
        .disposed(by: disposeBag)
    }
}

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
    //MARK: Action
    enum Action {
        case searchQuery(String)
    }
    
    //MARK: State
    struct State {
        let searchResults = BehaviorRelay<[SearchSectionModel]>(value: [])
    }
    
    //MARK: Instances
    var action: AnyObserver<Action> { actionSubject.asObserver() }
    
    private let actionSubject = PublishSubject<Action>()
    private let queryRelay = PublishRelay<String>()
    
    let state = State()
    let disposeBag = DisposeBag()
    
    private let useCase: SearchUseCase
    
    init(useCase: SearchUseCase) {
        self.useCase = useCase
        
        fetchSearchQuery()
        bind()
    }
    
    private func bind() {
        actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                case .searchQuery(let query):
                    owner.queryRelay.accept(query)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchSearchQuery() {
        queryRelay
            .debounce(.milliseconds(1000), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .flatMapLatest { [useCase] query in
                Single.zip(
                    useCase.fetchPodcasts(search: query),
                    useCase.fetchMovies(search: query)
                )
                .map { (query, $0, $1)}
                .catch { _ in
                    Single.just((query, [], []))
                }
                .asObservable()
            }
            .map { query, podcasts, movies -> [SearchSectionModel] in
                let podcastItems = podcasts.isEmpty ? [SearchItem.empty(query: "'\(query)'에 대한 검색 결과 없음")] : podcasts.map { SearchItem.podcast($0) }
                let movieItems = movies.isEmpty ? [SearchItem.empty(query: "'\(query)'에 대한 검색 결과 없음")] : movies.map { SearchItem.movie($0) }
                return [
                    SearchSectionModel(
                        header: SearchHeader(title: .search(query)),
                        items: []
                    ),
                    SearchSectionModel(
                        header: SearchHeader(title: .podcast("PodCast")),
                        items: podcastItems
                    ),
                    SearchSectionModel(
                        header: SearchHeader(title: .movie("Movie")),
                        items: movieItems
                    )
                ]
            }
            .subscribe(with: self) { owner, sectionModels in
                owner.state.searchResults.accept(sectionModels)
            } onError: { owner, error in
                print("FetchSearchQuery Error: \(error)")
            }
            .disposed(by: disposeBag)
        
    }
}

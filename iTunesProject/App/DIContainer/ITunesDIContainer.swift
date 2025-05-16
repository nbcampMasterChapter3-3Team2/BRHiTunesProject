//
//  ITunesDIContainer.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/16/25.
//

import Foundation

final class ITunesDIContainer: ITunesDIContainerInterface {    
    func makeHomeViewModel() -> HomeViewModel {
        let repository = MusicRepository()
        let useCase = MusicUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        
        return viewModel
    }
    
    func makeSearchViewModel() -> SearchViewModel {
        let repository = SearchRepository()
        let useCase = SearchUseCase(repository: repository)
        let viewModel = SearchViewModel(useCase: useCase)
        
        return viewModel
    }
    
    func makeSearchViewController() -> SearchViewController {
        let viewModel = makeSearchViewModel()
        let viewController = SearchViewController(searchViewModel: viewModel)
        
        return viewController
    }
}

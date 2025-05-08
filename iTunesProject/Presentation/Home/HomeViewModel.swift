//
//  HomeViewModel.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import Foundation

import RxSwift

final class HomeViewModel: ViewModelProtocol {
    enum Action {
        case viewDidLoad
    }
    
    struct State {
        let home = PublishSubject<Void>()
    }
    
    var action: AnyObserver<Action> { actionSubject.asObserver() }
    
    private let actionSubject = PublishSubject<Action>()
    let state = State()
    let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                case .viewDidLoad:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
}

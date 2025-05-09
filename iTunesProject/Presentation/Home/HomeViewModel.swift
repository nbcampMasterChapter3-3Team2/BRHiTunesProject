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
    }
    
    struct State {
        let home = PublishRelay<[MusicSection]>()
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
                    owner.fetchMockData()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchMockData() {
        let sectionData = [
            MusicSection.spring(
                Header(title: "봄 Best", subTitle: "봄에 어울리는 음악 Best 5"),
                [
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Spring", singer: "Spring", titleOfAlbum: "Spring")
                ]
            ),
            MusicSection.summer(
                Header(title: "여름", subTitle: "여름에 어울리는 음악"),
                [
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Summer", singer: "Summer", titleOfAlbum: "Summer")
                ]
            ),
            MusicSection.fall(
                Header(title: "가을", subTitle: "가을에 어울리는 음악"),
                [
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Fall", singer: "Fall", titleOfAlbum: "Fall")
                ]
            ),
            MusicSection.winter(
                Header(title: "겨울", subTitle: "겨울에 어울리는 음악"),
                [
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter"),
                MusicModel(albumImage: UIImage(), titleOfSong: "Winter", singer: "Winter", titleOfAlbum: "Winter")
                ]
            )
        ]
        state.home.accept(sectionData)
    }
}

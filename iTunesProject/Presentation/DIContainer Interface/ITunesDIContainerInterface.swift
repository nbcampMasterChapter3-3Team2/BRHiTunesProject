//
//  ITunesDIContainerInterface.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/16/25.
//

import Foundation

protocol ITunesDIContainerInterface {
    func makeHomeViewModel() -> HomeViewModel
    func makeSearchViewModel() -> SearchViewModel
    func makeSearchViewController() -> SearchViewController
}

//
//  HomeView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import Then

enum PlaceholderText: String {
    case homeSearchBar = "영화, 팟캐스트"
}

final class HomeView: BaseView {
    //MARK: - UI Components
    private let searchBar = UISearchBar().then {
        $0.placeholder = PlaceholderText.homeSearchBar.rawValue
    }
    
    
    
    override func setStyles() {
        super.setStyles()
        
    }
    
    override func setLayouts() {
        super.setLayouts()
        
    }
    
}

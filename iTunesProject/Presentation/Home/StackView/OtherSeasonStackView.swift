//
//  OtherSeasonStackView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import Then

final class OtherSeasonStackView: UIStackView {
    private lazy var seasonLabel = UILabel().then {
        $0.text = seasonTitle.sectionTitle
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.text = seasonDescription.rawValue
        $0.textColor = .systemGray
    }
    
    private let collectionView = UICollectionView().then {
        $0.backgroundColor = .systemBackground
    }
    
    let seasonTitle: Season
    let seasonDescription: Description
    
    init(season: Season, description: Description) {
        self.seasonTitle = season
        self.seasonDescription = description
        super.init()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

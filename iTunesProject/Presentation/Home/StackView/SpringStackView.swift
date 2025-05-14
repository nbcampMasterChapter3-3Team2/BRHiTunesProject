//
//  SpringStackView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import Then

final class SpringStackView: UIStackView {
    private let seasonLabel = UILabel().then {
        $0.text = Season.spring.rawValue
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = Description.spring.rawValue
        $0.textColor = .systemGray
    }
    
    private let springCollectionView = UICollectionView().then {
        $0.backgroundColor = .systemBackground
    }
}

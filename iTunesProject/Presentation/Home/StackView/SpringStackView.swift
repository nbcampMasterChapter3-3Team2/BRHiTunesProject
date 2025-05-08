//
//  SpringStackView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import Then

enum Season: String {
    case spring = "봄 Best"
    case summer = "여름"
    case fall = "가을"
    case winter = "겨울"
}

enum Description: String {
    case spring = "봄에 어울리는 음악 Best 5"
}

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

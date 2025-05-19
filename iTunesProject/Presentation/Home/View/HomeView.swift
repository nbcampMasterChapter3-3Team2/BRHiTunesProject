//
//  HomeView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import SnapKit
import Then

final class HomeView: BaseView {
    //MARK: UI Components
    private lazy var otherSeasonCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.register(HomeTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeTitleHeaderView.className)
        $0.register(SpringCollectionViewCell.self, forCellWithReuseIdentifier: SpringCollectionViewCell.className)
        $0.register(OtherSeasonCollectionViewCell.self, forCellWithReuseIdentifier: OtherSeasonCollectionViewCell.className)
        
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = true
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.addSubview(otherSeasonCollectionView)
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        otherSeasonCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: Methods
    func getOtherSeasonCollectionView() -> UICollectionView {
        return otherSeasonCollectionView
    }
}

//
//  Search.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import SnapKit
import Then

final class SearchView: BaseView {
    //MARK: UI Components
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.register(SearchTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchTitleHeaderView.className)
        $0.register(CategoryTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryTitleHeaderView.className)
        $0.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.className)
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.clipsToBounds = false
    }
    
    override func setStyles() {
        super.setStyles()
        
        self.addSubview(searchCollectionView)
    }
    
    override func setLayouts() {
        super.setLayouts()
        
        searchCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func getSearchCollectionView() -> UICollectionView {
        return searchCollectionView
    }
}

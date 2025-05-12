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
    private let searchBar = UISearchBar().then {
        $0.placeholder = PlaceholderText.homeSearchBar.rawValue
        $0.backgroundImage = UIImage()
        $0.showsCancelButton = false
    }
    
    //MARK: Instances
    lazy var otherSeasonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.className)
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
        self.addSubviews(searchBar, otherSeasonCollectionView)
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        otherSeasonCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

//MARK: - Extension
extension HomeView {
    //MARK: Methods
    static func springSeasonSectionLayout() -> NSCollectionLayoutSection {
        // 1) 아이템 하나(앱 카드)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),   // 그룹 폭의 100 %
            heightDimension: .fractionalHeight(1.0)  // 배너 이미지 크기에 따라 조정 가능
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        // 2) 그룹 – 아이템 3개를 세로로 쌓음
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),   // 화면 폭의 90 %
            heightDimension: .estimated(200)         // 3 × 90 + inset
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        section.contentInsets.bottom = 16
        
        return section
    }
    
    static func otherSeasonSectionLayout() -> NSCollectionLayoutSection {
        // 1) 아이템 하나(앱 카드)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),   // 그룹 폭의 100 %
            heightDimension: .estimated(76)          // 내부 오토레이아웃으로 계산
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        // 2) 그룹 – 아이템 3개를 세로로 쌓음
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),   // 화면 폭의 90 %
            heightDimension: .estimated(228)         // 3 × 90 + inset
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,                  // ⬅️ 새 API
            count: 3
        )
        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        section.contentInsets.bottom = 16
        section.interGroupSpacing = 8
        
        return section
    }
    
    func getOtherSeasonCollectionView() -> UICollectionView {
        return otherSeasonCollectionView
    }
    
    func getSearchBar() -> UISearchBar {
        return searchBar
    }
}

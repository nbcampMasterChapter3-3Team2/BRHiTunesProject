//
//  NoSearchCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/15/25.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class NoSearchCollectionViewCell: BaseCollectionViewCell {
    //MARK: UI Components
    let searchIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .systemGray
    }
    
    let searchTitle = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "맞춤법을 확인하거나 새로운 검색을 시도하십시오."
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    //MARK: PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        prepare()
    }
    
    //MARK: Prepare
    override func prepare() {
        super.prepare()
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        self.contentView.addSubviews(searchIcon, searchTitle, descriptionLabel)
        
        searchIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        searchTitle.snp.makeConstraints {
            $0.top.equalTo(searchIcon.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(searchTitle.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configureCell(_ item: SearchItem) {
        switch item {
        case .empty(let message):
            self.searchTitle.text = message
        default:
            return
        }
    }
    
}

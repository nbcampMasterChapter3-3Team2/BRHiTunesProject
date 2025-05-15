//
//  CategoryTitleHeaderView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/14/25.
//

import UIKit

import SnapKit
import Then

final class CategoryTitleHeaderView: BaseHeaderView {
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    override func prepare() {
        self.titleLabel.text = nil
    }
    
    //MARK: - SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.addSubview(titleLabel)
    }
    
    //MARK: - SetLayouts
    override func setLayouts() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Methods
    func configureView(_ item: SearchHeader) {
        switch item.title {
        case .podcast(let podcast):
            self.titleLabel.text = podcast
        case .movie(let movie):
            self.titleLabel.text = movie
        default:
            return
        }
    }
}

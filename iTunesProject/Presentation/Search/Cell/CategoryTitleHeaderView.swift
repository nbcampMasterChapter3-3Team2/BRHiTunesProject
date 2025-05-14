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
    
    //MARK: - SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.addSubview(titleLabel)
    }
    
    //MARK: - SetLayouts
    override func setLayouts() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Methods
    func configureView(_ item: SearchHeader) {
        self.titleLabel.text = item.title.rawValue
    }
    
    func prepare() {
        self.titleLabel.text = nil
    }
}

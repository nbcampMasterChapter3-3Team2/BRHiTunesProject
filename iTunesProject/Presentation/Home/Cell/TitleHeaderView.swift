//
//  TitleHeaderView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import UIKit

import SnapKit
import Then

final class TitleHeaderView: BaseHeaderView {
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .black)
        $0.textColor = .label
    }
    
    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .secondaryLabel
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    //MARK: - SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.addSubviews(stackView)
        self.stackView.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    //MARK: - SetLayouts
    override func setLayouts() {
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Methods
    func configureView(_ item: Header) {
        self.titleLabel.text = item.title
        self.subtitleLabel.text = item.subTitle
    }
    
    func prepare() {
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
    }
}

//
//  OtherSeasonCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import UIKit

import SnapKit
import Then

final class OtherSeasonCollectionViewCell: BaseCollectionViewCell {
    //MARK: - UI Components
    private let albumImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let titleOfSongLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .label
    }
    
    private let singerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .label
    }
    
    private let titleOfAlbumLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .systemGray
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        $0.spacing = 4
    }
    
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    private let separator = UIView().then {
        $0.backgroundColor = .separator
        $0.isHidden = true
    }
    
    //MARK: - SetStyles
    override func setStyles() {
        super.setStyles()
    }
    
    //MARK: - SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        self.contentView.addSubviews(horizontalStackView, separator)
        self.horizontalStackView.addArrangedSubviews(albumImageView, verticalStackView)
        self.verticalStackView.addArrangedSubviews(titleOfSongLabel, singerLabel, titleOfAlbumLabel)
        
        albumImageView.snp.makeConstraints {
            $0.size.equalTo(60)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        separator.snp.makeConstraints {
            $0.leading.equalTo(horizontalStackView.snp.leading)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    //MARK: - Methods
    func configureCell(_ item: MusicModel, isLast: Bool) {
        self.albumImageView.image = item.albumImage
        self.titleOfSongLabel.text = item.titleOfSong
        self.singerLabel.text = item.singer
        self.titleOfAlbumLabel.text = item.titleOfAlbum
        self.separator.isHidden = isLast
    }
    
    func prepare() {
        self.albumImageView.image = nil
        self.titleOfSongLabel.text = nil
        self.singerLabel.text = nil
        self.titleOfAlbumLabel.text = nil
        self.separator.isHidden = true
    }
}

//
//  SpringCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class SpringCollectionViewCell: BaseCollectionViewCell {
    //MARK: - UI Components
    private let albumImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)).then {
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.clipsToBounds = true
        $0.alpha = 0.5
    }
    
    private let titleOfSongLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
    }
    
    private let singerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .systemGray4
    }
    
    private let subAlbumImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    //MARK: - Instances
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare()
        disposeBag = DisposeBag()
    }
    
    override func prepare() {
        self.albumImageView.image = nil
        self.titleOfSongLabel.text = nil
        self.singerLabel.text = nil
        self.subAlbumImageView.image = nil
    }
    
    //MARK: - SetStyles
    override func setStyles() {
        super.setStyles()
    }
    
    //MARK: - SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        self.contentView.addSubviews(albumImageView, blurBackgroundView, horizontalStackView)
        self.horizontalStackView.addArrangedSubviews(subAlbumImageView, verticalStackView)
        self.verticalStackView.addArrangedSubviews(titleOfSongLabel, singerLabel)
        
        albumImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(albumImageView.snp.bottom).offset(-16)
        }
        
        subAlbumImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        blurBackgroundView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(horizontalStackView.snp.top).offset(-16)
        }
    }
    
    //MARK: - Methods
    func configureCell(_ item: MusicEntity) {
        ImageLoader.shared.loadImage(from: item.artworkURL)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, image in
                owner.albumImageView.image = image
                owner.subAlbumImageView.image = image
            }
            .disposed(by: disposeBag)
        
        self.titleOfSongLabel.text = item.trackName
        self.singerLabel.text = item.artistName
    }
}

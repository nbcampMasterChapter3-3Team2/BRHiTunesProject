//
//  SearchCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let bgColorView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 15
        $0.layer.cornerCurve = .continuous
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = .init(width: 0, height: 6)
        $0.layer.shadowRadius = 10
    }
    
    let coverImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGreen
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .systemGray
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .label
    }
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        prepare()
        disposeBag = DisposeBag()
    }
    
    override func setStyles() {
        super.setStyles()
        
    }
    
    override func setLayouts() {
        super.setLayouts()
        
        self.contentView.addSubviews(bgColorView, coverImage, descriptionLabel, titleLabel)
        
        bgColorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        coverImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(coverImage.snp.width)
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    func configureCell(_ item: SearchEntity) {
        ImageLoader.shared.loadImage(from: item.artworkURL)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, image in
                owner.coverImage.image = image
                if let avgColor = image?.averageColor() {
                    owner.bgColorView.backgroundColor = avgColor.withAlphaComponent(0.2)
                }
            }
            .disposed(by: disposeBag)
        
        self.titleLabel.text = item.trackName
        self.descriptionLabel.text = item.artistName
    }
    
    func prepare() {
        self.coverImage.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
//        self.bgColorView.backgroundColor = nil
    }
}

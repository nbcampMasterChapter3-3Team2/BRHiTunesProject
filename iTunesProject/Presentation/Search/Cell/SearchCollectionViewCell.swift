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
    //MARK: UI Components
    let bgColorView = UIView().then {
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
    }
    
    let recommendedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .secondaryLabel
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .label
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .systemGray
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 6
    }
    
    //MARK: Instances
    var disposeBag = DisposeBag()
    
    //MARK: PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        prepare()
        disposeBag = DisposeBag()
    }
    
    override func prepare() {
        super.prepare()
        
        self.coverImage.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.bgColorView.backgroundColor = nil
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.contentView.clipsToBounds = false
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        self.contentView.addSubviews(bgColorView, coverImage, verticalStackView)
        self.verticalStackView.addArrangedSubviews(recommendedLabel, titleLabel, descriptionLabel)
        
        bgColorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        coverImage.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(coverImage.snp.width)
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    func configureCell(_ item: SearchItem) {
        switch item {
        case .podcast(let podcast):
            self.recommendedLabel.text = RecommendEmoji.podcastRecommendations.randomElement()
            self.titleLabel.text = podcast.trackName
            self.descriptionLabel.text = podcast.artistName
            self.loadImageAndSetBackground(url: podcast.albumUrl)
            
        case .movie(let movie):
            self.recommendedLabel.text = "\(String.genreEmoji(for: movie.primaryGenreName)) \(movie.primaryGenreName)"
            self.titleLabel.text = movie.trackName
            self.descriptionLabel.text = movie.artistName
            self.loadImageAndSetBackground(url: movie.albumUrl)
        }
    }
    
    private func loadImageAndSetBackground(url: String) {
        ImageLoader.shared.loadImage(from: url)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, image in
                owner.coverImage.image = image
                if let avgColor = image?.averageColor() {
                    owner.bgColorView.backgroundColor = avgColor.withAlphaComponent(0.2)
                }
            }
            .disposed(by: disposeBag)
    }
}

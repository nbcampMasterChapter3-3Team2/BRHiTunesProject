//
//  SearchTitleHeaderView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class SearchTitleHeaderView: BaseHeaderView {
    //MARK: - UI Components
    let titleButton = UIButton().then {
        $0.contentHorizontalAlignment = .leading
    }
    
    //MARK: - Instance
    private var titleAttributes: [NSAttributedString.Key: Any] {
        return [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold),
            .foregroundColor: UIColor.label
        ]
    }
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare()
        
        disposeBag = DisposeBag()
    }
    
    //MARK: Override
    override func prepare() {
        super.prepare()
        
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.addSubview(titleButton)
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        titleButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    //MARK: Methods
    func configureView(_ item: SearchHeader) {
        switch item.title {
        case .search(let query):
            var config = UIButton.Configuration.plain()
            let attributed = NSAttributedString(string: query, attributes: titleAttributes)
            config.attributedTitle = AttributedString(attributed)
            config.contentInsets = .zero
            
            self.titleButton.configuration = config
        default:
            return
        }
    }
}

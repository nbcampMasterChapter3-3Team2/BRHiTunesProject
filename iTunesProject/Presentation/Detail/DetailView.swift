//
//  DetailView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class DetailView: BaseView {
    //MARK: UI Components
    let dismissButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
    }
    
    let coverImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let thumbnailImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    override func setStyles() {
        super.setStyles()
        
    }
    
    override func setLayouts() {
        super.setLayouts()
        
        self.addSubviews(dismissButton)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    
}

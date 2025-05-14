//
//  BaseCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    private lazy var viewName = self.className
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setStyles() {
        
    }
    
    func setLayouts() {}
}

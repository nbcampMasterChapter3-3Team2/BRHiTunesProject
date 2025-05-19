//
//  BaseCollectionViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/9/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    //MARK: Instances
    private lazy var viewName = self.className
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: SetStyles
    func setStyles() {}
    
    //MARK: SetLayouts
    func setLayouts() {}
    
    //MARK: Prepare
    func prepare() {}
}

//
//  BaseTableViewCell.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    //MARK: Instances
    private lazy var viewName = self.className
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

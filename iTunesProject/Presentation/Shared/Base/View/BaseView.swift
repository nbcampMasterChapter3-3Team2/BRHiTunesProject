//
//  BaseView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

class BaseView: UIView {
    
    //MARK: Instances
    private lazy var viewName = self.className
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayouts()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("🧵 \(viewName) has been successfully Removed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetStyles
    func setStyles() {
        self.backgroundColor = .systemBackground
    }
    
    //MARK: SetLayouts
    func setLayouts() {}
    
}

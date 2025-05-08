//
//  BaseView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

class BaseView: UIView {
    
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
    
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayouts() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

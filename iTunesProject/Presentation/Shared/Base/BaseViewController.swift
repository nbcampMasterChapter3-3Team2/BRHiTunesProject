//
//  BaseViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var viewControllerName = self.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayouts()
        setDelegates()
        setRegisters()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Data 와 UI 를 bind 합니다.
    func bindViewModel() {}
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayouts() {}
    /// View 의 Delegate 을 set 합니다.
    func setDelegates() {}
    /// View 의 Register 를 set 합니다.
    func setRegisters() {}
    
    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}


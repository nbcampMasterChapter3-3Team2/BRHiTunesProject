//
//  BaseViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: Instances
    private lazy var viewControllerName = self.className
    
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setStyles()
        setLayouts()
        setDelegates()
        setRegisters()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: BindViewModel
    func bindViewModel() {}
    
    //MARK: SetStyles
    func setStyles() {}
    
    //MARK: SetLayouts
    func setLayouts() {}
    
    //MARK: SetDelegates
    func setDelegates() {}
    
    //MARK: SetRegisters
    func setRegisters() {}
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}


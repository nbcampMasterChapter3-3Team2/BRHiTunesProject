//
//  DetailViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import SnapKit
import Then

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    
    override func loadView() {
        super.loadView()
        
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setStyles() {
        super.setStyles()
        
        detailView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    override func setLayouts() {
        super.setLayouts()
        
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    
}

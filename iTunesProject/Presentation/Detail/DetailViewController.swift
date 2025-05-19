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
    var urlString: String?
    
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
        
        if let urlString, let url = URL(string: urlString) {
            detailView.webView.load(URLRequest(url: url))
        }
    }
    
    override func setLayouts() {
        super.setLayouts()
        
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    
}

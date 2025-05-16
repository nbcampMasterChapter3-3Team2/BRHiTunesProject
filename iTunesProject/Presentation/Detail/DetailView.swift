//
//  DetailView.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/15/25.
//

import UIKit
import WebKit

import SnapKit
import Then

final class DetailView: BaseView {
    //MARK: UI Components
    let dismissButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.tintColor = .black
    }
    
    let webView = WKWebView()
    
    override func setStyles() {
        super.setStyles()
        
    }
    
    override func setLayouts() {
        super.setLayouts()
        
        self.addSubviews(dismissButton, webView)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
}

//
//  ImageLoader.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import UIKit

import RxSwift

final class ImageLoader {
    static let shared = ImageLoader()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(from urlString: String) -> Single<UIImage?> {
        return Single.create { [weak self] single in
            guard let self else {
                single(.success(nil))
                return Disposables.create()
            }
            
            // 1. 캐시 확인
            if let cached = self.imageCache.object(forKey: urlString as NSString) {
                single(.success(cached))
                return Disposables.create()
            }
            
            // 2. URL 생성
            guard let url = URL(string: urlString) else {
                single(.success(nil))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data), error == nil {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        single(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        single(.success(nil))
                    }
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

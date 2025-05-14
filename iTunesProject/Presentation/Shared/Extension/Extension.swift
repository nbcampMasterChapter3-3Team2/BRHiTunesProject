//
//  Extension.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

//MARK: - Extension NSObject
extension NSObject {
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}

//MARK: - Extension String
extension String {
    static func genreEmoji(for genre: String) -> String {
        let lowercased = genre.lowercased()
        
        switch lowercased {
        case _ where lowercased.contains("action"):
            return "💥"
        case _ where lowercased.contains("comedy"):
            return "😂"
        case _ where lowercased.contains("drama"):
            return "🎬"
        case _ where lowercased.contains("horror"), _ where genre.contains("thriller"):
            return "👻"
        case _ where lowercased.contains("romance"):
            return "💘"
        case _ where lowercased.contains("sci-fi"):
            return "🚀"
        case _ where lowercased.contains("fantasy"):
            return "🐉"
        case _ where lowercased.contains("musical"):
            return "🎶"
        case _ where lowercased.contains("mystery"):
            return "🕵️"
        case _ where lowercased.contains("documentary"):
            return "🎥"
        case _ where lowercased.contains("superhero"):
            return "🦸"
        default:
            return "🎞️"
        }
    }
}

//MARK: - Extension UIView
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

//MARK: - Extension UIStackView
extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

//MARK: - Extension NSCollectionLayoutSection
extension NSCollectionLayoutSection {
    static func springSeasonSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [header]
        section.contentInsets.bottom = 16
        
        return section
    }
    
    static func otherSeasonSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(76)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(228)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 3
        )
//        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [header]
        section.contentInsets.bottom = 16
//        section.interGroupSpacing = 0
        
        return section
    }
    
    static func searchSectionLayout(sectionIndex: Int? = nil) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(
            top: sectionIndex == 0 ? 0 : 8,
            leading: 0,
            bottom: sectionIndex == 0 ? 0 : 20,
            trailing: 0
        )
        section.interGroupSpacing = 20
        
        return section
    }
}

//MARK: - Extension UIImage
extension UIImage {
    func averageColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extent = inputImage.extent
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputExtentKey: CIVector(cgRect: extent)
        ])
        guard let outputImage = filter?.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: CGColorSpaceCreateDeviceRGB())
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255.0,
            green: CGFloat(bitmap[1]) / 255.0,
            blue: CGFloat(bitmap[2]) / 255.0,
            alpha: 1.0
        )
    }
}

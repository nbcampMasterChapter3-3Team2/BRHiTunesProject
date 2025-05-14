//
//  SearchViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import UIKit

import RxDataSources
import RxSwift
import SnapKit

final class SearchViewController: BaseViewController {
    
    //MARK: - Instances
    let searchView = SearchView()
    let searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCollectionView()
        bindAction()
    }
    
    override func setStyles() {
        super.setStyles()
        
        self.view.backgroundColor = .systemBackground
        
        searchView.searchCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            
            guard let self else { return nil }
            let sections = self.searchViewModel.state.home.value
            guard sectionIndex < sections.count else { return nil }
            
            let section = sections[sectionIndex]
            switch section.header.title {
            case .search:
                return NSCollectionLayoutSection.searchSectionLayout(sectionIndex: 0)
            case .podcast, .movie:
                return NSCollectionLayoutSection.searchSectionLayout()
            }
        }
    }
    
    override func setLayouts() {
        super.setLayouts()
        
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: Methods
    private func bindCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SearchSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let header = dataSource.sectionModels[indexPath.section].header
                let items = dataSource.sectionModels[indexPath.section].items
                
                switch header.title {
                case .search, .podcast, .movie:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SearchCollectionViewCell.className,
                        for: indexPath) as? SearchCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureCell(items[indexPath.row])
                    return cell
                }
            }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let section = dataSource.sectionModels[indexPath.section]
                    
                    switch section.header.title {
                    case .search:
                        guard let header = collectionView.dequeueReusableSupplementaryView(
                            ofKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SearchTitleHeaderVIew.className,
                            for: indexPath) as? SearchTitleHeaderVIew else {
                            return UICollectionReusableView()
                        }
                        header.configureView(section.header)
                        return header
                    case .movie, .podcast:
                        guard let header = collectionView.dequeueReusableSupplementaryView(
                            ofKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: CategoryTitleHeaderView.className,
                            for: indexPath) as? CategoryTitleHeaderView else {
                            return UICollectionReusableView()
                        }
                        header.configureView(section.header)
                        return header
                    }
                default:
                    return UICollectionReusableView()
                }
            })

        searchViewModel.state.home
            .bind(to: searchView.searchCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    // MARK: bindAction
    private func bindAction() {
        searchViewModel.action.onNext(.viewDidLoad)
    }
    
}

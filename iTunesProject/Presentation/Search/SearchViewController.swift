//
//  SearchViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import UIKit
import SafariServices

import RxDataSources
import RxSwift
import SnapKit

final class SearchViewController: BaseViewController {
    
    //MARK: - Instances
    let searchView = SearchView()
    let searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    var dismissSearchController: (() -> Void)?
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindState()
    }
    
    override func setStyles() {
        super.setStyles()
        
        self.view.backgroundColor = .systemBackground
        
        searchView.searchCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            
            guard let self else { return nil }
            let sections = self.searchViewModel.state.searchResults.value
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
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: bindState
    private func bindState() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SearchSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .podcast(let podcast):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SearchCollectionViewCell.className,
                        for: indexPath) as? SearchCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureCell(SearchItem.podcast(podcast))
                    return cell
                    
                case .movie(let movie):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SearchCollectionViewCell.className,
                        for: indexPath) as? SearchCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureCell(SearchItem.movie(movie))
                    return cell
                    
                case .empty(let query):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NoSearchCollectionViewCell.className,
                        for: indexPath) as? NoSearchCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureCell(SearchItem.empty(query: query))
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
                            withReuseIdentifier: SearchTitleHeaderView.className,
                            for: indexPath) as? SearchTitleHeaderView else {
                            return UICollectionReusableView()
                        }
                        header.configureView(section.header)
                        header.titleButton.rx.tap
                            .bind(with: self) { owner, _ in
                                owner.dismissSearchController?()
                            }
                            .disposed(by: header.disposeBag)
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

        searchViewModel.state.searchResults
            .bind(to: searchView.searchCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        searchView.searchCollectionView.rx.modelSelected(SearchItem.self)
            .subscribe(with: self) { owner, item in
                switch item {
                case .podcast(let podcast):
                    owner.presentSafariVC(podcast.collectionViewUrl)
                case .movie(let movie):
                    owner.presentSafariVC(movie.collectionViewUrl)
                case .empty:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func presentSafariVC(_ url: String) {
        if let url = URL(string: url) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            
            self.present(safariVC, animated: true)
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        searchViewModel.action.onNext(.searchQuery(query))
    }
}

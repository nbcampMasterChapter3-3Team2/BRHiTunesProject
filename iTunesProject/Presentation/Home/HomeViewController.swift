//
//  HomeViewController.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/8/25.
//

import UIKit

import RxSwift
import RxDataSources
import SnapKit
import Then

final class HomeViewController: BaseViewController {
    //MARK: - UI Components
    let searchController = UISearchController().then {
        $0.searchBar.placeholder = "영화, 팟캐스트"
    }
    
    let homeView = HomeView()
    
    //MARK: - Instances
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: - View Life Cycles
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Layout을 먼저 잡아준 후
        setNavigationBar()
        bindCollectionView()
        // action bind
        bindAction()
        bindEvents()
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        self.view.backgroundColor = .systemBackground
        
        homeView.otherSeasonCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            
            guard let self else { return nil }
            let sections = self.homeViewModel.state.home.value
            guard sectionIndex < sections.count else { return nil }
            
            let section = sections[sectionIndex]
            switch section.header.title {
            case .spring:
                return HomeView.springSeasonSectionLayout()
            case .summer, .fall,.winter:
                return HomeView.otherSeasonSectionLayout()
            }
        }
    }
    
    //MARK: SetLayouts
    override func setLayouts() {
        super.setLayouts()
        self.view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: SetDelegates
    override func setDelegates() {
        super.setDelegates()
        
    }
    
    //MARK: SetRegisters
    override func setRegisters() {
        super.setRegisters()
        
    }
    
    private func setNavigationBar() {
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "Music"
    }
    
    //MARK: Methods
    private func bindCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<MusicSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let header = dataSource.sectionModels[indexPath.section].header
                let items = dataSource.sectionModels[indexPath.section].items
                
                switch header.title {
                case .spring:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SpringCollectionViewCell.className,
                        for: indexPath) as? SpringCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureCell(items[indexPath.row])
                    return cell
                    
                case .summer, .fall, .winter:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: OtherSeasonCollectionViewCell.className,
                        for: indexPath) as? OtherSeasonCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    let isLast = (indexPath.item % 3 == 2) || (indexPath.item == items.count - 1)
                    cell.configureCell(items[indexPath.row], isLast: isLast)
                    return cell
                }
            }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    guard let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: TitleHeaderView.className,
                        for: indexPath) as? TitleHeaderView else {
                        return UICollectionReusableView()
                    }
                    let section = dataSource.sectionModels[indexPath.section]
                    header.configureView(section.header)
                    return header
                    
                default:
                    return UICollectionReusableView()
                }
            })

        homeViewModel.state.home
            .bind(to: homeView.otherSeasonCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    // MARK: bindAction
    private func bindAction() {
        homeViewModel.action.onNext(.viewDidLoad)
    }
    
    // MARK: bindEvents
    private func bindEvents() {
        searchController.searchBar.rx.textDidBeginEditing
            .bind(with: self) { owner, _ in
                owner.searchController.searchBar.showsCancelButton = true
                if let cancelButton = owner.searchController.searchBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.setTitle("취소", for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked
            .bind(with: self) { owner, _ in
                owner.searchController.searchBar.text = ""
                owner.searchController.searchBar.showsCancelButton = false
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestrue.cancelsTouchesInView = false
        homeView.getOtherSeasonCollectionView().addGestureRecognizer(tapGestrue)
    }
}

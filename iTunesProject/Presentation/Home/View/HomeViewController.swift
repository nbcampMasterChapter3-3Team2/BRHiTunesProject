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
    //MARK: UI Components
    private lazy var searchController = UISearchController(searchResultsController: searchViewController).then {
        $0.searchBar.placeholder = PlaceholderText.homeSearchBar.rawValue
        $0.obscuresBackgroundDuringPresentation = true
        $0.searchResultsUpdater = searchViewController
    }
    
    //MARK: Instances
    private let diContainer: ITunesDIContainerInterface
    
    private let homeView = HomeView()
    private let homeViewModel: HomeViewModel
    
    private lazy var searchViewController = diContainer.makeSearchViewController()
    
    private let disposeBag = DisposeBag()
    
    init(diContainer: ITunesDIContainerInterface) {
        self.diContainer = diContainer
        self.homeViewModel = diContainer.makeHomeViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycles
    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        bindViewModel()
        bindAction()
        bindEvents()
    }
    
    //MARK: SetStyles
    override func setStyles() {
        super.setStyles()
        
        self.view.backgroundColor = .systemBackground
        
        homeView.getOtherSeasonCollectionView().collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            
            guard let self else { return nil }
            let sections = self.homeViewModel.state.home.value
            guard sectionIndex < sections.count else { return nil }
            
            let section = sections[sectionIndex]
            switch section.header.title {
            case .spring:
                return NSCollectionLayoutSection.springSeasonSectionLayout()
            case .summer, .fall,.winter:
                return NSCollectionLayoutSection.otherSeasonSectionLayout()
            }
        }
        
        searchViewController.dismissSearchController = { [weak self] in
            guard let self else { return }
            self.searchController.isActive = false
            self.searchController.searchBar.text = ""
            self.searchController.searchBar.showsCancelButton = false
            self.searchController.searchBar.resignFirstResponder()
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
    
    //MARK: SetNavigationBar
    private func setNavigationBar() {
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "Music"
    }
    
    //MARK: - Methods
    //MARK: BindCollectionView
    override func bindViewModel() {
        super.bindViewModel()
        
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
                        withReuseIdentifier: HomeTitleHeaderView.className,
                        for: indexPath) as? HomeTitleHeaderView else {
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
            .bind(to: homeView.getOtherSeasonCollectionView().rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    // MARK: bindAction
    private func bindAction() {
        homeViewModel.action.onNext(.viewDidLoad)
    }
    
    // MARK: bindEvents
    private func bindEvents() {
        getSearchController().searchBar.rx.textDidBeginEditing
            .bind(with: self) { owner, _ in
                owner.searchController.searchBar.showsCancelButton = true
                if let cancelButton = owner.searchController.searchBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.setTitle("취소", for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        getSearchController().searchBar.rx.cancelButtonClicked
            .bind(with: self) { owner, _ in
                owner.searchController.searchBar.text = ""
                owner.searchController.searchBar.showsCancelButton = false
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    private func getSearchController() -> UISearchController {
        return searchController
    }
}

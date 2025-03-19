//
//  ViewController.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var RepositoriesTableView: UITableView!
    
    
    private let viewModel = GitHubRepositoryViewModel(
        searchUseCase: SearchRepositoriesUseCase(
            repository: GitHubRepositoryImp())
    )
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        handleEmptyView()
        handleNetworkErrors()
    }
    
    private func bindViewModel() {
        // Bind search bar text to ViewModel
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        // Bind ViewModel repositories to table view
        viewModel.repositories
            .bind(to: RepositoriesTableView.rx.items(cellIdentifier: "RepoCell", cellType: RepoCellTableViewCell.self)) { _, repository, cell in
                cell.setupCell(with: repository)
            }
            .disposed(by: disposeBag)
    }
    
    private func handleEmptyView() {
        viewModel.repositories
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] repos in
                guard let self = self else { return }
                self.removeErrorView()
                if repos.isEmpty {
                    self.addErrorView(message: "No Repositories Found")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func handleNetworkErrors() {
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.removeErrorView()
                if !error.isEmpty {
                    self.addErrorView(message: error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func addErrorView(message: String) {
        let errorImage = UIImageView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        errorImage.image = UIImage(systemName: "icloud.slash")
        self.view.addSubview(errorImage)
        
        let errorLabel = UILabel(frame: CGRect(x: Int(errorImage.frame.minX),
                                               y: Int(errorImage.frame.maxY + 15),
                                               width: Int(errorImage.frame.width + 50),
                                               height: 50))
        errorLabel.numberOfLines = 3
        errorLabel.text = message
        self.view.addSubview(errorLabel)
    }
    
    private func removeErrorView() {
        self.view.subviews.forEach { subview in
            if subview is UILabel || subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
        
    }
}


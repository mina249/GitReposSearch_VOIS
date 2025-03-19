//
//  GitHubRepositoryViewModel.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

final class GitHubRepositoryViewModel {
    private let searchUseCase: SearchRepositoriesUseCase
    private let disposeBag = DisposeBag()
    
    let searchText = BehaviorRelay<String>(value: "")
    let repositories = PublishRelay<[Repository]>()
    let errorMessage = PublishRelay<String>()
    
    init(searchUseCase: SearchRepositoriesUseCase) {
        self.searchUseCase = searchUseCase
        
        searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter {
                !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            .flatMapLatest { query -> Observable<Result<RepositoryModel, NetworkError>> in
                return searchUseCase.execute(query: query)
            }
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.repositories.accept(response.items)
                case .failure(let error):
                    self?.errorMessage.accept(error.errorMessage)
                }
            })
            .disposed(by: disposeBag)
    }
}

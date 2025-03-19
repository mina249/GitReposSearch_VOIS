//
//  SerchRepositoryUseCase.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import RxSwift

class SearchRepositoriesUseCase {
    private let repository: GitHubRepository

    init(repository: GitHubRepository) {
        self.repository = repository
    }

    func execute(query: String) -> Observable<Result<RepositoryModel, NetworkError>> {
        return repository.searchRepositories(query: query)
    }
}

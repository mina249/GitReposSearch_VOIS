//
//  GitHubRepository.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import RxSwift

class GitHubRepositoryImp: GitHubRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManagerImp.shared) {
        self.networkManager = networkManager
    }
    func searchRepositories(query: String) -> Observable<Result<RepositoryModel, NetworkError>> {
        let url = UrlBuilder().build(with: query)
        return networkManager.request(url: url, responseType: RepositoryModel.self)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}

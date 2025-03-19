//
//  GitHubRepository.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import RxSwift

protocol GitHubRepository {
    
    func searchRepositories(query: String) -> Observable<Result<RepositoryModel, NetworkError>>
}

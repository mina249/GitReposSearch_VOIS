//
//  RepositoryModel.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

struct RepositoryModel: Decodable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct Repository: Decodable {
    let name: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}

//
//  NetworkError.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(String) 
    case decodingFailed
    case noInternetConnection
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let message):
            return "Request failed: \(message)"
        case .decodingFailed:
            return "Failed to decode response."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        }
    }
}

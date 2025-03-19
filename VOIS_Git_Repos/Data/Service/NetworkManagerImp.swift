//
//  NetworkManagerImp.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

final class NetworkManagerImp: NetworkManager {
    private init() {}
    
    static let shared = NetworkManagerImp()
    
    func request<Response>(url: String, responseType: Response.Type)
    -> RxSwift.Observable<Result<Response, NetworkError>> where Response : Decodable {
        guard let url = URL(string: url) else {
            return Observable.just(.failure(.invalidURL))
        }
        if !isConnectedToInternet() {
            return Observable.just(.failure(.noInternetConnection))
        }
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.response(request: request)
            .map { response, data in
                guard (200...299).contains(response.statusCode) else {
                    return .failure(.requestFailed("Server Error Loading Repositories"))
                }
                return self.decodeResponse(data, type: responseType)
            }
            .catch { error in
                return Observable.just(.failure(.requestFailed("Server Error Loading Repositories")))
            }
    }
    
    private func decodeResponse<Response: Decodable>(_ data: Data, type: Response.Type) -> Result<Response, NetworkError> {
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            return .success(decodedResponse)
        } catch {
            return .failure(.decodingFailed)
        }
    }
    
    private func isConnectedToInternet() -> Bool {
        return Reachability.shared.isConnectedToInternet()
    }
}

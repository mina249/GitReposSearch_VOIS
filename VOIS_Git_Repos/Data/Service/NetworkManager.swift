//
//  NetworkManager.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import RxSwift

protocol NetworkManager {
    
    func request<Response: Decodable>(url: String, responseType: Response.Type) -> Observable<Result<Response, NetworkError>>
}

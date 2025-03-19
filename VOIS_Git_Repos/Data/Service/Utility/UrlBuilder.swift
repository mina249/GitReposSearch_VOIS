//
//  UrlBuilder.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import Foundation

struct UrlBuilder {
    
    private var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    
    private  func configuration(_ key: PlistKey) -> NSString {
        guard let keyValue = infoDict[key.rawValue] as? NSString else {
            fatalError("Key \(key.rawValue) Not founded")
        }
        return keyValue
    }
    
     func build(with query: String)-> String {
         let baseUrl = configuration(.baseUrl)
         return baseUrl.appending(query)
    }
}

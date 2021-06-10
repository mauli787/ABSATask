//
//  APIManager.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class APIManager {
    
    func loadWebAPI<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
        
            if let data = data {
                DispatchQueue.main.async {
                     completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    
}

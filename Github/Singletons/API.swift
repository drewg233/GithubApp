//
//  API.swift
//  Github
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import Foundation

let APIShared = API.shared

class API {
    static let shared = API()
    
    var searchResults = [GitRepo]()
    
    func search(by searchType: SearchType, for searchText: String, completion: @escaping (_ error: String?) -> ()) {
        let urlString = Constant.URL.search(by: searchType, for: searchText)
        if urlString.count == 0 {
            return
        }
        
        makeCall(urlString: urlString) { (json, error) in
            if let errorMessage = error {
                completion(errorMessage)
            }
            
            if let jsonData = json {
                var repos = [GitRepo]()
                for repoJson in jsonData {
                    if let gitRepo = GitRepo(json: repoJson) {
                        repos.append(gitRepo)
                    }
                }
                APIShared.searchResults = repos
            }
            completion(nil)
        }
    }
    
    func makeCall(urlString: String, completion: @escaping (_ data: [[String: Any]]?, _ error: String?) -> ()) {
        if let url = URL(string: urlString) {
            _ = URLSession.shared.dataTask(with: url) { data, response, error in
                if let errorMessage = error {
                    completion(nil, "Error on call: \(errorMessage)")
                    return
                }
                guard let data = data else {
                    completion(nil, "Data was empty.")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                    completion(json, nil)
                } catch let error as NSError {
                    completion(nil, "Failed to load: \(error.localizedDescription)")
                }
                }.resume()
        }
    }
}

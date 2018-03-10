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
    
    var searchResults = [GitSection]()
    
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
                APIShared.groupSearchResults(searchResults: repos)
            }
            completion(nil)
        }
    }
    
    func groupSearchResults(searchResults: [GitRepo]) {
        var sections = [GitSection]()
        
        // Group the repos by language
        for searchResult in searchResults {
            if let foundSectionWithLanguage: GitSection = sections.filter({ $0.language == searchResult.language }).first {
                foundSectionWithLanguage.repos.append(searchResult)
            } else {
                let gitSection = GitSection(language: searchResult.language)
                gitSection.repos.append(searchResult)
                sections.append(gitSection)
            }
        }
        
        // In each group, sort by stars
        for group in sections {
            group.repos.sort(by: { $0.stars > $1.stars })
        }
        
        APIShared.searchResults = sections
    }
    
    func makeCall(urlString: String, completion: @escaping (_ data: [[String: Any]]?, _ error: String?) -> ()) {
        if let url = URL(string: urlString) {
            _ = URLSession.shared.dataTask(with: url) { data, response, error in
                if let errorMessage = error {
                    completion(nil, "Error on call: \(errorMessage)")
                    return
                }
                guard let data = data else {
                    completion(nil, Constant.ErrorMessage.noData)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        completion(json, nil)
                    } else {
                        completion(nil, Constant.ErrorMessage.couldNotSerializeJson)
                    }
                } catch let error as NSError {
                    completion(nil, "Failed to load: \(error.localizedDescription)")
                }
                }.resume()
        }
    }
}

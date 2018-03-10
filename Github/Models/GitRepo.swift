//
//  GitRepo.swift
//  Github
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import Foundation

class GitRepo {
    var name: String
    var description: String?
    var language: String?
    var forks: Int
    var stars: Int
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let forks = json["forks_count"] as? Int,
            let stars = json["stargazers_count"] as? Int else {
                return nil
        }
        
        self.name = name
        self.forks = forks
        self.stars = stars
        
        // Optionals
        if let description = json["description"] as? String {
            self.description = description
        }
        if let language = json["language"] as? String {
            self.language = language
        }
    }
}

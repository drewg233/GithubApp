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
    var language: String
    var forks: Int
    var stars: Int
    var updatedAt: Date?
    var avatarImageURL: String?
    var repoURL: String?
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let forks = json["forks_count"] as? Int,
            let language = json["language"] as? String,
            let stars = json["stargazers_count"] as? Int else {
                return nil
        }
        
        self.name = name
        self.forks = forks
        self.stars = stars
        self.language = language
        
        // Optionals
        if let description = json["description"] as? String {
            self.description = description
        }
        if let updatedAt = json["updated_at"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
            let date = dateFormatter.date(from: updatedAt)
            self.updatedAt = date
        }
        if let ownerData = json["owner"] as? [String: Any] {
            if let avatarImageURL = ownerData["avatar_url"] as? String {
                self.avatarImageURL = avatarImageURL
            }
        }
        if let repoURL = json["html_url"] as? String {
            self.repoURL = repoURL
        }
    }
}

//
//  GitRepoTableViewCell.swift
//  GithubTest
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import UIKit

class GitRepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var updatedTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var gitRepo: GitRepo? {
        didSet {
            guard let repo = gitRepo else {
                return
            }
            
            nameLabel.text = repo.name
            starsLabel.text = "Stars: \(repo.stars)"
            forkLabel.text = "Fork: \(repo.forks)"
            languageLabel.text = repo.language
            
            // Optionals
            if let description = repo.description {
                descriptionLabel.text = description
            }
            if let lastUpdatedDate = repo.updatedAt {
                let timeinterval = Date().timeIntervalSince(lastUpdatedDate)
                
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .abbreviated
                if let time = formatter.string(from: timeinterval) {
                    updatedTimeLabel.text = "Updated: \(time)"
                }
            }
        }
    }
    
    override func awakeFromNib() {
        descriptionLabel.text = ""
        updatedTimeLabel.text = ""
    }
}

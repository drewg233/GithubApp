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
    
    var gitRepo: GitRepo? {
        didSet {
            if let name = gitRepo?.name {
                nameLabel.text = name
            }
        }
    }
}

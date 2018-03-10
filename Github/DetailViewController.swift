//
//  DetailViewController.swift
//  Github
//
//  Created by Andrew Garcia on 3/10/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var gitRepo: GitRepo?
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        // Title
        titleLabel.text = gitRepo?.name
        
        // Description
        descriptionLabel.text = gitRepo?.description
        
        // Image
        if let avatarURLString = gitRepo?.avatarImageURL {
            if let url = URL(string: avatarURLString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.avatarImageView.layer.cornerRadius = 5
                            self.avatarImageView.layer.masksToBounds = true
                            self.avatarImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        
        // Language
        if let language = gitRepo?.language {
           languageLabel.text = "Language: \(language)"
        }
        
        // Stars
        if let stars = gitRepo?.stars {
            starsLabel.text = "Stars: \(stars)"
        }
    }
    
    @IBAction func goToRepoButtonPressed(_ sender: Any) {
        if let repoURLString = gitRepo?.repoURL {
            if let url = URL(string: repoURLString) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}

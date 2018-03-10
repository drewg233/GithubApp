//
//  GitSection.swift
//  Github
//
//  Created by Andrew Garcia on 3/10/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import Foundation

class GitSection {
    var language: String
    var repos: [GitRepo] = []
    
    init(language: String) {
        self.language = language
    }
}

//
//  Constants.swift
//  Github
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import Foundation
import UIKit

enum SearchType {
    case organization
    case username
}

struct Constant {
    struct URL {
        static let base = "https://api.github.com"
        
        static func search(by searchType: SearchType, for searchText: String) -> String {
            guard let urlEncodedSearch = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return ""
            }
            
            switch searchType {
            case .organization:
                return "\(base)/orgs/\(urlEncodedSearch)/repos"
            case .username:
                return "\(base)/users/\(urlEncodedSearch)/repos"
            }
        }
    }
    
    struct ReuseId {
        static let gitRepoTableViewCell = "GitRepoTableViewCellReuseId"
    }
    
    struct Nib {
        static let gitRepoTableViewCell = "GitRepoTableViewCell"
    }
    
    struct ErrorMessage {
        static let couldNotSerializeJson = "Oops couldn't serialize the response."
        static let noData = "Data was empty."
    }
    
    struct Color {
        static let blue = UIColor(red: 0.09, green: 0.09, blue: 0.26, alpha: 1.0)
    }
    
    struct Segue {
        static let goToDetails = "showGitRepoDetails"
    }
}

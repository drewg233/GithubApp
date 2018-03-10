//
//  Constants.swift
//  Github
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import Foundation

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
}

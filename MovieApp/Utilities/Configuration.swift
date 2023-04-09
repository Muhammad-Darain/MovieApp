//
//  Configuration.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
enum Configuration {
    static let baseURL : URL = {
        return URL(string: "https://api.themoviedb.org/3/discover")!
        
    }()
    
    static let baseURLForDetail : URL = {
        return URL(string: "https://api.themoviedb.org/3/movie/")!
        
    }()
    
    static let apiKey : String = {
        return String( "c9856d0cb57c3f14bf75bdc6c063b8f3")
        
    }()
}

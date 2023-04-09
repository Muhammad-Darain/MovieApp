//
//  MovieListResponse.swift
//  MovieApp
//
//  Created by Muhammad on 07/04/2023.
//

import Foundation
struct MovieListResponse : Decodable {
    
    let id: Int
    let result : [Result]
    
    
    struct Result : Decodable {
        let id: Int?
        let title : String?
        let backdrop_path : String?
        let release_date : String?
    }
}

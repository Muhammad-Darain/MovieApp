//
//  MovieModule.swift
//  MovieApp
//
//  Created by Muhammad Darain on 07/04/2023.
//

import Foundation
import SwiftConnect

enum MovieModule: Module {
    case getMovies(apiKey: String,page:Int)
    case getMovieDetail(apiKey: String,id:Int)
    
    var request: Requestable {
        switch self {
        case .getMovies(let apiKey,let page):
            return MovieListRequest(request: MovieListParams.init(api_key: apiKey, page: page))
        case .getMovieDetail(let apiKey,let id):
            return MovieDetailRequest(movieID: id, apiKey: apiKey)
        }
    }
}

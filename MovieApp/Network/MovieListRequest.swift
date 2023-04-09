//
//  MovieListRequest.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
import SwiftConnect
import Alamofire

struct MovieListRequest: SwiftConnect.Request {
    let baseURL = Configuration.baseURL
    let endpoint = Endpoints.getMovies
    let method: HTTPMethod = .get
    
    @Object(encoding: URLEncoding.queryString) private(set) var request: MovieListParams
    
    init(request: MovieListParams) {
        self.request = request
    }
}

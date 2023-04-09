//
//  MovieDetailRequest.swift
//  MovieApp
//
//  Created by mac on 09/04/2023.
//

import Foundation
import SwiftConnect
import Alamofire

struct MovieDetailRequest: SwiftConnect.Request {
    var baseURL: URL
//    var baseURL = Configuration.baseURLForDetail
    let endpoint = ""
    let method: HTTPMethod = .get
    
    @Query("api_key", encoding: URLEncoding.queryString) private(set) var apikey: String
    
    init(movieID: Int,apiKey: String) {
        baseURL = URL(string: Configuration.baseURLForDetail.absoluteString + String(movieID))!
        self.apikey = apiKey
 }
}

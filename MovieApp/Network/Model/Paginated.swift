//
//  Paginated.swift
//  MovieApp
//
//  Created by Muhammad on 07/04/2023.
//

import Foundation

struct Paginated<T>: Decodable where T: Decodable {
    let page: Int
    var results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results
    }

    func copy(results: [T]) -> Paginated<T> {
        Paginated(page: page, results: results ?? self.results)
    }
}

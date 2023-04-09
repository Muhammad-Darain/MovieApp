//
//  MovieDetailResponse.swift
//  MovieApp
//
//  Created by Muhammad Darain on 09/04/2023.
//

import Foundation

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    var id: Int?
    var releaseDate, posterPath, backdropPath, originalTitle, overview: String?

    init(){}
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

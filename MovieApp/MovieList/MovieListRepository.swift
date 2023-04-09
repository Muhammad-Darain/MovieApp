//
//  MovieListRepository.swift
//  MovieApp
//
//  Created by Muhammad Darain on 07/04/2023.
//

import Foundation
import ReactiveKit
import SwiftConnect
import Bond
protocol MovieListRepositoryProtocol{
    func getMovieList(page:Int)-> Signal<Paginated<MovieListResponse.Result>,Error>
}

final class MovieListRepository:MovieListRepositoryProtocol {
    func getMovieList(page:Int) -> ReactiveKit.Signal<Paginated<MovieListResponse.Result>, Error> {
        let request = MovieModule.getMovies(apiKey: Configuration.apiKey, page: page).request
        
        return SharedConnect
            .connect
            .request(request: request)
            .decoded(toType: Paginated<MovieListResponse.Result>.self)
            .asSignal()
    }
}

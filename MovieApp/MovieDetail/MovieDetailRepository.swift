//
//  MovieDetailRepository.swift
//  MovieApp
//
//  Created by mac on 09/04/2023.
//

import Foundation
import ReactiveKit
import SwiftConnect
import Bond
protocol MovieDetailRepositoryProtocol{
    func getMovieDetail(id:Int)-> Signal<MovieDetailResponse,Error>
}

final class MovieDetailRepository:MovieDetailRepositoryProtocol {
    func getMovieDetail(id:Int) -> ReactiveKit.Signal<MovieDetailResponse, Error> {
        let request = MovieModule.getMovieDetail(apiKey: Configuration.apiKey, id: id).request
        
        return SharedConnect
            .connect
            .request(request: request)
            .decoded(toType: MovieDetailResponse.self)
            .asSignal()
    }
}

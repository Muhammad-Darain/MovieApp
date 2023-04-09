//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Muhammad Darain on 09/04/2023.
//

import Foundation
import ReactiveKit
import Bond

protocol MovieDetailViewModelProtocol {
    var input: MovieDetailViewModel.Input! { get }
    var output: MovieDetailViewModel.Output! { get }
    
}

class MovieDetailViewModel:ViewModel, MovieDetailViewModelProtocol, ViewModelType {

    struct Input {
        let viewDidLoad: AnyUIEvent<Void>
    }
    
    struct Output {
        let loadingState: SafeSignal<LoadingState>
        let error: SafeSignal<String>
        let moviesDetail : SafeSignal<MovieDetailResponse>

    }
    
    //Input
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    
    //Output
    private let movieDetailRepository : MovieDetailRepositoryProtocol!
    
    private(set) var input: Input!
    private(set) var output: Output!
    private var movieID : Int!
    private let moviesDetail = Property<MovieDetailResponse?>(nil)
    
    init(movieID:Int){
        movieDetailRepository = MovieDetailRepository()
        self.movieID = movieID
        super.init()
        observeViewDidLoad()

        
        input = .init(viewDidLoad: viewDidLoad.eraseToAnySubject())
        output = .init(
            loadingState: loadingTracker.toUISignal(),
            error: errorTracker.map { $0.localizedDescription }.toUISignal(), moviesDetail: moviesDetail.map({ detail in
                detail ?? MovieDetailResponse()
            })
        )
    }
    
    // MARK: - Observers
    
    private func observeViewDidLoad() {
        viewDidLoad
            .observeNext { [weak self] in
                guard let self = self else { return }
                self.loadData(id: self.movieID)
            }
            .dispose(in: disposeBag)
        
    }
    
    func loadData(id: Int){
        let movie = self.movieDetailRepository
            .getMovieDetail(id: id)
            .trackError(on: errorTracker)
            .mapSuccess()
            .share(limit: 1)
            .bind(to: moviesDetail)
            }
}

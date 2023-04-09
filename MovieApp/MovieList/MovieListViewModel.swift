//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
import ReactiveKit
import Bond
protocol MovieListViewModelProtocol {
    var input: MovieListViewModel.Input! { get }
    var output: MovieListViewModel.Output! { get }
    
}

class MovieListViewModel:ViewModel, MovieListViewModelProtocol, ViewModelType {
    enum Route {
        case movieDetail(id:Int, image:String)
    }
    
    struct Input {
        let viewDidLoad: AnyUIEvent<Void>
        let paginationTrigger: AnyUIEvent<Void>
        let selectItemTrigger: AnyUIEvent<Int>
    }
    
    struct Output {
        let loadingState: SafeSignal<LoadingState>
        let error: SafeSignal<String>
        let dataSource: MutableObservableArray<MovieListResponse.Result>
        let route: SafeSignal<Route>
    }
    
    //Input
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    private let paginationTrigger = PassthroughSubject<Void, Never>()
    private let selectItemTrigger = PassthroughSubject<Int, Never>()
    
    //Output
    private let route = PassthroughSubject<Route, Never>()
    private let movieListRepository : MovieListRepositoryProtocol!
    private let dataSource = MutableObservableArray<MovieListResponse.Result>(.init())
    
    private(set) var input: Input!
    private(set) var output: Output!
    
    private let totalMovies = Property<Int>(0)
    private let movies = Property<[MovieListResponse.Result]>([])
    var initialPageIndex = 1
    
    override init(){
        movieListRepository = MovieListRepository()
        super.init()
        observeViewDidLoad()
        observePaginationTrigger()
        observeSelectItemTrigger()
        
        input = .init(viewDidLoad: viewDidLoad.eraseToAnySubject(),
                      paginationTrigger: paginationTrigger.eraseToAnySubject(),
                      selectItemTrigger: selectItemTrigger.eraseToAnySubject())
        output = .init(
            loadingState: loadingTracker.toUISignal(),
            error: errorTracker.map { $0.localizedDescription }.toUISignal(),
            dataSource: dataSource,
            route: route.toUISignal()
        )
    }
    
    
    // MARK: - Observers
    
    private func observeViewDidLoad() {
        viewDidLoad
            .observeNext { [weak self] in
                guard let self = self else { return }
                self.getData()
            }
            .dispose(in: disposeBag)
        
    }
    
    private func observePaginationTrigger() {
        paginationTrigger.observeNext { trigger in
            self.initialPageIndex = self.initialPageIndex + 1
            self.loadData(isPaginating: true, page: self.initialPageIndex)
        }.dispose(in: disposeBag)
    }
    
    private func observeSelectItemTrigger() {
        selectItemTrigger
            .map({ index in
                
                return .movieDetail(id: self.movies.value[index].id ?? 0, image: self.movies.value[index].backdrop_path ?? "")
            })
            .bind(to: route)
            .dispose(in: disposeBag)
    }
    
    private func getData(){
        self.movies.value = []
        self.loadData()
    }
    
    func loadData(isRefreshing: Bool = false, isPaginating: Bool = false, page: Int = 1){
        let movies = self.movieListRepository
            .getMovieList(page: page)
            .trackError(on: errorTracker)
            .mapSuccess()
            .share(limit: 1)
        
        movies
            .map { $0.page + self.totalMovies.value  }
            .bind(to: totalMovies)
        
        movies
            .map { $0.results }
            .with(latestFrom: self.movies) { newMovies, oldMovies in
                if isRefreshing {
                    return []
                }
                
                var oldMovies = oldMovies
                oldMovies.append(contentsOf: newMovies)
                return oldMovies
            }
            .handleEvents(receiveOutput: { [weak self] movies in
                guard let self = self else { return }
                self.prepareDataSource(for: movies, isPaginating: isPaginating)
            })
            .bind(to: self.movies)
    }
    
    private func prepareDataSource(for movies: [MovieListResponse.Result], isPaginating: Bool) {
        dataSource.value = .init(collection: movies, diff: .init())
    }
}

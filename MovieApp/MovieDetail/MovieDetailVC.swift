//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by mac on 08/04/2023.
//

import UIKit
import Kingfisher

class MovieDetailVC: BaseViewController {
    
    @IBOutlet weak var movieThumbNail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!

    private let viewModel : MovieDetailViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewDidLoad(to: viewModel.input.viewDidLoad)
        self.navigationItem.title = "Movie Detail"
        self.navigationController?.navigationBar.isHidden = true
        viewModel
            .output
            .moviesDetail
            .bind(to: self){vc,detail in
                let posterURL = "https://image.tmdb.org/t/p/w500" + String(detail.posterPath ?? "")
                print(posterURL)
                vc.movieThumbNail.kf.setImage(with: URL(string: posterURL))
                vc.movieTitle.text = detail.originalTitle
                vc.movieDescription.text = detail.overview

        }
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    fileprivate init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    static func create(movieID:Int)-> MovieDetailVC{
        let viewModel = MovieDetailViewModel(movieID: movieID)
        return .init(viewModel: viewModel)
    }

}

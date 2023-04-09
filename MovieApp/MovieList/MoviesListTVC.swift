//
//  MoviesListTVC.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import UIKit
import Kingfisher

class MoviesListTVC: UITableViewCell  {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data: MovieListResponse.Result){
        self.titleLabel.text = data.title
        self.titleImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.backdrop_path ?? "")"))
        self.dateLabel.text = data.release_date
    }

}


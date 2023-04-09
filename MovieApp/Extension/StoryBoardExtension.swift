//
//  StoryBoardExtension.swift
//  MovieApp
//
//  Created by Muhammad Darain on 08/04/2023.
//

import UIKit

extension UIStoryboard {
    static func MainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
enum AppControllers : String{
    case MD = "MovieDetailVC"
}

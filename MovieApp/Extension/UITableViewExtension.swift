//
//  UITableViewExtension.swift
//  MovieApp
//
//  Created by Muhammad Darain on 08/04/2023.
//

import UIKit
extension UITableView {
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(
            withIdentifier: T.className,
            for: indexPath
        ) as! T
    }
    
   
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
extension UITableView {
    func registerNib<T: UITableViewCell>(cell: T.Type) {
            register(cell.nib, forCellReuseIdentifier: cell.className)
        }
}

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}

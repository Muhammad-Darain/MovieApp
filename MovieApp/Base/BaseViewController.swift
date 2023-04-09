//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Muhammad Darain on 07/04/2023.
//

import UIKit
import Bond
import ReactiveKit
class BaseViewController : UIViewController{
    let disposeBag = DisposeBag()
    
    func bindViewDidLoad(to signal: AnyUIEvent<Void>) {
        
        reactive
            .lifecycleEvent(.viewDidLoad)
            .bind(to:signal)
            .dispose(in: disposeBag)
    }
    
    func addObservables() {
//        NotificationCenter
//            .default
//            .reactive
//            .notification(name: .setupSubviews)
//            .observeNext { [weak self] _ in
//                guard let self = self else { return }
//                self.setupSubviews()
//            }
//            .dispose(in: disposeBag)
    }
}

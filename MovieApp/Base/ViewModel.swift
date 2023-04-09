//
//  ViewModel.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
import ReactiveKit
import Bond

typealias LoadingState = (isLoading: Bool, isUserInteractionEnabled: Bool)

class ViewModel {
    let disposeBag = DisposeBag()
    let loadingTracker = Property<LoadingState>((false, false))
    let errorTracker = PassthroughSubject<Error, Never>()
}

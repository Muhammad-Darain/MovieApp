//
//  ViewModelType.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation

typealias AnyUIEvent<T> = AnySubject<T, Never>

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
}

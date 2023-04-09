//
//  FutureExtension.swift
//  MovieApp
//
//  Created by Muhammad Darain on 07/04/2023.
//

import Foundation
import SwiftConnect
import Bond
import ReactiveKit

extension Future {
    func asSignal() -> Signal<Value, Error> {
        return Signal { observer in
            self.observe { result in
                switch result {
                case .success(let value):
                    observer.on(.next(value))
                    observer.on(.completed)
                    
                case .failure(let error):
                    observer.on(.failed(error))
                }
            }
            return SimpleDisposable(isDisposed: false)
        }
    }
}

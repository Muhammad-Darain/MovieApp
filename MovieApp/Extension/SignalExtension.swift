//
//  SignalExtension.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
import ReactiveKit

extension Signal {
    
    func trackLoading(on subject: Property<LoadingState>, isUserInteractionEnabled: Bool) -> Self {
        return handleEvents(receiveSubscription: {
            subject.on(.next((true, isUserInteractionEnabled)))
        }, receiveCompletion: { _ in
            subject.on(.next((false, isUserInteractionEnabled)))
        })
    }
    
    func trackProgress(on subject: Property<Bool>) -> Self {
        return handleEvents(receiveSubscription: {
            subject.on(.next(true))
        }, receiveCompletion: { _ in
            subject.on(.next(false))
        })
    }
    
    func trackError(on subject: PassthroughSubject<Error, Never>) -> Self {
        return handleEvents(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                debugPrint(error)
                subject.on(.next(error))
                
            default:
                break
            }
        })
    }
    
    func mapSuccess() -> Signal<Element, Never> {
        return mapToResult()
            .compactMap { try? $0.get() }
    }
    
}

extension Signal where Error == Never {
    
    func toUISignal() -> SafeSignal<Element> {
        return receive(on: DispatchQueue.main)
    }
    
}

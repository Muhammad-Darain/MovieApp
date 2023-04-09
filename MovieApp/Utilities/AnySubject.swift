//
//  AnySubject.swift
//  MovieApp
//
//  Created by mac on 07/04/2023.
//

import Foundation
import Bond
import ReactiveKit

class AnySubject<Element, Error>: SubjectProtocol, BindableProtocol where Error: Swift.Error {

    private let _observe: (@escaping Observer<Element, Error>) -> (Disposable)
    private let _on: (Signal<Element, Error>.Event) -> Void // swiftlint:disable:this identifier_name
    private let _bind: (Signal<Element, Never>) -> (Disposable)
    
    init<S>(_ subject: S) where S: SubjectProtocol, S: BindableProtocol, S.Element == Element, S.Error == Error {
        _observe = subject.observe
        _on = subject.on
        _bind = subject.bind
    }
    
    func observe(with observer: @escaping Observer<Element, Error>) -> Disposable {
        return _observe(observer)
    }
    
    func on(_ event: Signal<Element, Error>.Event) {
        _on(event)
    }
    
    func bind(signal: Signal<Element, Never>) -> Disposable {
        return _bind(signal)
    }
    
}

extension Subject {
    func eraseToAnySubject() -> AnySubject<Element, Error> {
        return AnySubject(self)
    }
}

extension Property {
    func eraseToAnySubject() -> AnySubject<Element, Error> {
        return AnySubject(self)
    }
}

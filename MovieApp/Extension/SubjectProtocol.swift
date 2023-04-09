//
//  SubjectProtocol.swift
//  MovieApp
//
//  Created by mac on 08/04/2023.
//

import Foundation
import ReactiveKit

extension SubjectProtocol where Error == Never {
    
    func toUISignal() -> SafeSignal<Element> {
        return toSignal().toUISignal()
    }
    
}

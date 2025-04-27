//
//  Binder.swift
//  Roulette
//
//  Created by Frankly on 26/04/25.
//

import Foundation
import SwiftUI

struct Binder {
    static func bind<Object: AnyObject, Value>(
        _ object: Object,
        _ keyPath: ReferenceWritableKeyPath<Object, Value>
    ) -> Binding<Value> {
        Binding(
            get: { object[keyPath: keyPath] },
            set: { object[keyPath: keyPath] = $0 }
        )
    }
}

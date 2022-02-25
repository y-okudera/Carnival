//
//  Bundle+.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import Foundation

extension Bundle {
    static var current: Bundle {
        class DummyClass {}
        return Bundle(for: type(of: DummyClass()))
    }
}

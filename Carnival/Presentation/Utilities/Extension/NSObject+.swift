//
//  NSObject+.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        String(describing: type(of: self))
    }
}

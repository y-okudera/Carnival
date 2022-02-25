//
//  NibLoadable.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import UIKit

protocol NibLoadable {
    func loadNib()
}

extension NibLoadable where Self: UIView {
    func loadNib() {
        let nibName = self.className
        if let view = Bundle.current.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}

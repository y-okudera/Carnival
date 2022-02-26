//
//  UIView+.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import UIKit

// MARK: - NibLoadable
extension UIView: NibLoadable {}

// MARK: - @IBInspectable
extension UIView {

    /// 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    /// 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// 角丸の大きさ
    @IBInspectable var cornerRound: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

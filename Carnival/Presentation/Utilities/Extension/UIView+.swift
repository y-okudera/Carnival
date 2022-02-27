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

extension UIView {

    /// retrieves all constraints that mention the view
    func getAllConstraints() -> [NSLayoutConstraint] {

        // array will contain self and all superviews
        var views = [self]

        // get all superviews
        var view = self
        while let superview = view.superview {
            views.append(superview)
            view = superview
        }

        // transform views to constraints and filter only those
        // constraints that include the view itself
        return views
            .flatMap { $0.constraints }
            .filter { [weak self] in
                guard let self = self else { return false }
                return $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
            }
    }

    func getConstraints(attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        return getAllConstraints()
            .filter { [weak self] in
                guard let self = self else { return false }
                return ($0.firstAttribute == attribute && $0.firstItem as? UIView == self)
                || ($0.secondAttribute == attribute && $0.secondItem as? UIView == self)
            }
    }
}

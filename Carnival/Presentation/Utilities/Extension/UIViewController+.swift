//
//  UIViewController+.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit

extension UIViewController {
    
    /// Hide the navigation bar on the this view controller
    func hideNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Show the navigation bar on other view controllers
    func showNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//
//  HomeBuilder.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import UIKit

enum HomeBuilder {
    static func build() -> UIViewController {
        let presenter = HomePresenterImpl()

        let vcName = HomeViewController.className
        let vc = UIStoryboard(name: vcName, bundle: .main)
            .instantiateViewController(withIdentifier: vcName) as! HomeViewController

        presenter.view = vc
        vc.presenter = presenter

        return vc
    }
}

//
//  HomeViewController.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var headerView: HomeHeaderView!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self

            let cellNames = [ThumbnailTableViewCell.className, TopThumbnailTableViewCell.className]
            cellNames.forEach {
                newValue.register(
                    .init(nibName: $0, bundle: .current),
                    forCellReuseIdentifier: $0
                )
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(animated: animated)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 20
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellIdentifier = TopThumbnailTableViewCell.className
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopThumbnailTableViewCell
            cell.configure()
            return cell
        case 1:
            let cellIdentifier = ThumbnailTableViewCell.className
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ThumbnailTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = DetailViewController.className
        let vc = UIStoryboard(name: vcName, bundle: .main)
            .instantiateViewController(withIdentifier: vcName)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let swipingDown = y <= 0
        let shouldSnap = y > 40

        print("contentOffset.y", y)

        guard let firstCell = tableView.cellForRow(at: [0, 0]) as? FadeInTabSourceView else {
            return
        }

        let fadeInTabBaseViewHeight = firstCell.fadeInTabBaseView.frame.height
        let cellFadeInTabBaseViewAlpha: CGFloat = (y / fadeInTabBaseViewHeight) > 1 ? 1 : y / fadeInTabBaseViewHeight
        firstCell.fadeInTabAlpha = cellFadeInTabBaseViewAlpha

        UIView.animate(withDuration: 0.3) {
            self.headerView.updateTitleLabelAlpha(swipingDown ? 1.0 : 0.0)
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
            // titleLabelを画面外に
            self.headerViewTopConstraint?.constant = shouldSnap ? -self.headerView.titleLabelHeight : 0

            shouldSnap ? self.headerView.showFadeInTabView() : self.headerView.hideFadeInTabView()

            self.view.layoutIfNeeded()
        }
    }
}

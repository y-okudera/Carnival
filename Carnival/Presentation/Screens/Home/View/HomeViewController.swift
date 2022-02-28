//
//  HomeViewController.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit
import SkeletonView

protocol HomeView: AnyObject {
    func reloadTabs()
    func reloadView()
}

final class HomeViewController: UIViewController {

    @IBOutlet private weak var headerView: HomeHeaderView! {
        willSet {
            newValue.delegate = self
        }
    }
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

    var presenter: HomePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkeletonView()
        showSkeleton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
        presenter.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(animated: animated)
    }

    private func setupSkeletonView() {
        self.view.isSkeletonable = true
        tableView.isSkeletonable = true
        tableView.isUserInteractionDisabledWhenSkeletonIsActive = false
    }

    private func showSkeleton() {
        self.view.showAnimatedSkeleton()
    }

    private func hideSkeleton() {
        self.view.hideSkeleton()
    }
}

// MARK: - HomeView
extension HomeViewController: HomeView {

    func reloadTabs() {
        headerView.setTabData(presenter.tabDataArray)

        guard let firstTabData = presenter.tabDataArray.first else {
            return
        }

        showSkeleton()
        presenter.requestHomeViewData(tabId: firstTabData.id)
    }

    func reloadView() {
        tableView.reloadData()
        hideSkeleton()
    }
}

// MARK: - HomeHeaderViewDelegate
extension HomeViewController: HomeHeaderViewDelegate {

    func homeHeaderView(_ homeHeaderView: HomeHeaderView, didTapTabId tabId: Int) {
        showSkeleton()
        presenter.requestHomeViewData(tabId: tabId)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: SkeletonTableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return presenter.viewData.dataArray.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellIdentifier = TopThumbnailTableViewCell.className
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopThumbnailTableViewCell
            cell.configure(data: presenter.viewData.topData, tabDataArray: presenter.tabDataArray)
            return cell
        case 1:
            let cellIdentifier = ThumbnailTableViewCell.className
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ThumbnailTableViewCell
            cell.configure(data: presenter.viewData.dataArray[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

    // MARK: - SkeletonTableViewDataSource

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return self.numberOfSections(in: collectionSkeletonView)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableView(skeletonView, numberOfRowsInSection: section)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.section {
        case 0:
            return TopThumbnailTableViewCell.className
        case 1:
            return ThumbnailTableViewCell.className
        default:
            return ""
        }
    }

    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return self.tableView(skeletonView, cellForRowAt: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // スケルトン表示中は選択不可にする
        guard !tableView.sk.isSkeletonActive else {
            return nil
        }
        return indexPath
    }

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
        guard let firstCell = tableView.cellForRow(at: [0, 0]) as? FadeInTabSourceView else {
            return
        }

        let fadeInTabBaseViewHeight = firstCell.fadeInTabBaseView.frame.height

        let y = scrollView.contentOffset.y
        let swipingDown = y <= 0
        let shouldSnap = y > fadeInTabBaseViewHeight

        let cellFadeInTabBaseViewAlpha: CGFloat = (y / fadeInTabBaseViewHeight) > 1 ? 1 : y / fadeInTabBaseViewHeight
        firstCell.fadeInTabAlpha = cellFadeInTabBaseViewAlpha

        UIView.animate(withDuration: 0.3) {
            self.headerView.updateHeaderImageViewAlpha(swipingDown ? 1.0 : 0.0)
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
            // headerImageViewを画面外に移動させる
            self.headerViewTopConstraint?.constant = shouldSnap ? -self.headerView.headerImageViewHeight : 0

            shouldSnap ? self.headerView.showFadeInTabView() : self.headerView.hideFadeInTabView()

            self.view.layoutIfNeeded()
        }
    }
}

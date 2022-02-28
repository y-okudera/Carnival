//
//  HomeHeaderView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit

protocol HomeHeaderViewDelegate: AnyObject {
    func homeHeaderView(_ homeHeaderView: HomeHeaderView, didTapTabId tabId: Int)
}

final class HomeHeaderView: UIView, FadeInTabDestinationView {
    
    @IBOutlet private weak var headerImageView: UIImageView!

    @IBOutlet private(set) weak var fadeInTabView: UIView!

    @IBOutlet private weak var tabView: TabView! {
        willSet {
            newValue.delegate = self
        }
    }

    /// requestsButtonとfadeInTabViewの間のレイアウト制約
    ///
    /// fadeInTabViewの表示の際は0に、非表示の際はfadeInTabViewのheight * 2に切り替える
    @IBOutlet private weak var fadeInTabViewTopConstraint: NSLayoutConstraint!

    /// fadeInTabViewとHomeHeaderView自体のBottomのレイアウト制約
    ///
    /// fadeInTabViewの表示の際はpriorityをHighに、非表示の際はLowに切り替える
    @IBOutlet private weak var fadeInTabViewBottomConstraint: NSLayoutConstraint! // 0

    /// requestsButton.bottomとHomeHeaderView.bottomの間のレイアウト制約
    ///
    /// fadeInTabViewの表示の際はfadeInTabViewのheightに、非表示の際は8に切り替える
    @IBOutlet private weak var requestsButtonBottomConstraint: NSLayoutConstraint!

    weak var delegate: HomeHeaderViewDelegate?

    /// headerImageView height + top and bottom spacer
    var headerImageViewHeight: CGFloat {
        let height = headerImageView.frame.height
        + (headerImageView.getConstraints(attribute: .top).first?.constant ?? 0)
        + (headerImageView.getConstraints(attribute: .bottom).first?.constant ?? 0)
        return height
    }

    var fadeInTabAlpha: CGFloat = 0 {
        didSet {
            // 子Viewもセットでalphaを更新する
            fadeInTabView.alpha = fadeInTabAlpha
            fadeInTabView.subviews.forEach {
                $0.alpha = fadeInTabAlpha
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        loadNib()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        setup()
    }

    @IBAction private func tappedRequestsButton(_ sender: UIButton) {
        print(#function)
    }
}

extension HomeHeaderView {

    private func setup() {
        hideFadeInTabView()
    }

    func updateHeaderImageViewAlpha(_ alpha: CGFloat) {
        headerImageView.alpha = alpha
    }

    func hideFadeInTabView() {
        fadeInTabAlpha = 0

        // requestsボタンのbottomとHomeHeaderView自体のbottomとの間の制約
        requestsButtonBottomConstraint.constant = 8

        // requestsボタンのbottomとfadeInTabViewのTopとの間の制約
        // 隠すためにheightの2倍空ける
        fadeInTabViewTopConstraint.constant = fadeInTabView.frame.height * 2

        fadeInTabViewBottomConstraint.priority = .defaultLow
    }

    func showFadeInTabView() {
        fadeInTabAlpha = 1

        // requestsボタンのbottomとHomeHeaderView自体のbottomとの間の制約
        requestsButtonBottomConstraint.constant = fadeInTabView.frame.height

        // requestsボタンのbottomとfadeInTabViewのTopとの間の制約
        fadeInTabViewTopConstraint.constant = 0

        fadeInTabViewBottomConstraint.priority = .defaultHigh
    }

    func update(_ offsetY: CGFloat) {
        // TODO: - hideFadeInTabView() と showFadeInTabView() の0/1のアニメーションではなく、スクロールのoffsetに応じてインタラクティブにアニメーションさせる
    }
}

extension HomeHeaderView {
    func setTabData(_ tabDataArray: [TabData]?) {
        guard let tabDataArray = tabDataArray else {
            return
        }
        tabView.tabDataArray = tabDataArray
    }
}

// MARK: - TabViewDelegate
extension HomeHeaderView: TabViewDelegate {
    func tabView(_ tabView: TabView, didTapTabId tabId: Int) {
        delegate?.homeHeaderView(self, didTapTabId: tabId)
    }
}

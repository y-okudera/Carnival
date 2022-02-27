//
//  HomeHeaderView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit

final class HomeHeaderView: UIView, FadeInTabDestinationView {
    
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private(set) weak var fadeInTabView: UIView!

    @IBOutlet private weak var tabView: TabView! {
        willSet {
            newValue.delegate = self
        }
    }

    /// inboxButtonとfadeInTabViewの間のレイアウト制約
    ///
    /// fadeInTabViewの表示の際は0に、非表示の際はfadeInTabViewのheight * 2に切り替える
    @IBOutlet private weak var fadeInTabViewTopConstraint: NSLayoutConstraint!

    /// fadeInTabViewとHomeHeaderView自体のBottomのレイアウト制約
    ///
    /// fadeInTabViewの表示の際はpriorityをHighに、非表示の際はLowに切り替える
    @IBOutlet private weak var fadeInTabViewBottomConstraint: NSLayoutConstraint! // 0

    /// inboxButton.bottomとHomeHeaderView.bottomの間のレイアウト制約
    ///
    /// fadeInTabViewの表示の際はfadeInTabViewのheightに、非表示の際は0に切り替える
    @IBOutlet private weak var inboxButtonBottomConstraint: NSLayoutConstraint!

    /// titleLabel height + top and bottom spacer
    var titleLabelHeight: CGFloat {
        let height = titleLabel.frame.height
        + (titleLabel.getConstraints(attribute: .top).first?.constant ?? 0)
        + (titleLabel.getConstraints(attribute: .bottom).first?.constant ?? 0)
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

    @IBAction private func tappedInboxButton(_ sender: UIButton) {
        print("Tapped Inbox Button!")
    }
}

extension HomeHeaderView {

    private func setup() {
        hideFadeInTabView()
    }

    func updateTitleLabelAlpha(_ alpha: CGFloat) {
        titleLabel.alpha = alpha
    }

    func hideFadeInTabView() {
        fadeInTabAlpha = 0

        // inboxボタンのbottomとHomeHeaderView自体のbottomとの間の制約
        inboxButtonBottomConstraint.constant = 0

        // inboxボタンのbottomとfadeInTabViewのTopとの間の制約
        // 隠すためにheightの2倍空ける
        fadeInTabViewTopConstraint.constant = fadeInTabView.frame.height * 2

        fadeInTabViewBottomConstraint.priority = .defaultLow
    }

    func showFadeInTabView() {
        fadeInTabAlpha = 1

        // inboxボタンのbottomとHomeHeaderView自体のbottomとの間の制約
        inboxButtonBottomConstraint.constant = fadeInTabView.frame.height

        // inboxボタンのbottomとfadeInTabViewのTopとの間の制約
        fadeInTabViewTopConstraint.constant = 0

        fadeInTabViewBottomConstraint.priority = .defaultHigh
    }

    func update(_ offsetY: CGFloat) {
        // TODO: - hideFadeInTabView() と showFadeInTabView() の0/1のアニメーションではなく、スクロールのoffsetに応じてインタラクティブにアニメーションさせる
    }
}

// MARK: - TabViewDelegate
extension HomeHeaderView: TabViewDelegate {
    func tabView(_ tabView: TabView, didTapWithTabId id: String) {
        print(#function, "id=\(id)")
    }
}

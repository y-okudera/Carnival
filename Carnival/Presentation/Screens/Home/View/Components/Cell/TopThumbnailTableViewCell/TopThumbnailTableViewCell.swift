//
//  TopThumbnailTableViewCell.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import Kingfisher
import SkeletonView
import UIKit

final class TopThumbnailTableViewCell: UITableViewCell, FadeInTabSourceView {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var fadeInTabBaseView: UIView!
    @IBOutlet private weak var fadeInTabView: TabView!

    var fadeInTabBaseViewHeight: CGFloat {
        fadeInTabBaseView.frame.height
    }

    private var fadeInTabAlpha: CGFloat = 0 {
        didSet {
            fadeInTabBaseView.alpha = fadeInTabAlpha
            fadeInTabBaseView.subviews.forEach {
                $0.alpha = fadeInTabAlpha
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupSkeletonView()
    }

    private func setupSkeletonView() {
        self.isSkeletonable = true
        thumbnailImageView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        nameLabel.skeletonTextNumberOfLines = 2
    }

    func configure(data: HomeContentData?, tabDataArray: [TabData]?) {
        self.selectionStyle = .none
        fadeInTabView.tabDataArray = tabDataArray ?? []
        fadeInTabAlpha = 0

        guard let data = data else {
            return
        }
        nameLabel.text = data.title
        thumbnailImageView.kf.setImage(
            with: URL(string: data.thumbnailUrl),
            placeholder: UIImage(named: "placeholder"),
            options: [
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ]
        )
    }

    func fadeInTabAlpha(contentOffsetY: CGFloat) {
        let alpha: CGFloat = max(min(contentOffsetY / fadeInTabBaseViewHeight, 1.0), 0.0)
        fadeInTabAlpha = alpha
    }
}

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

    var fadeInTabAlpha: CGFloat = 0 {
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

    func configure(data: HomeContentData) {
        self.selectionStyle = .none
        fadeInTabAlpha = 0
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
}

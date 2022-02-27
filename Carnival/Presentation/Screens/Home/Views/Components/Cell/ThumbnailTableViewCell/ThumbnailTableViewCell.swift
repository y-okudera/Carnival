//
//  ThumbnailTableViewCell.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import SkeletonView
import UIKit

final class ThumbnailTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
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

    func configure() {
        self.selectionStyle = .none
    }
}

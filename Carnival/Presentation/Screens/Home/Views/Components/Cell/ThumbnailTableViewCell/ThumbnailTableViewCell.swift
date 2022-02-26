//
//  ThumbnailTableViewCell.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import UIKit

final class ThumbnailTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

//
//  TabCollectionViewCell.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import UIKit

protocol TabCollectionViewCellDelegate: AnyObject {
    func tabCollectionViewCell(_ tabCollectionViewCell: TabCollectionViewCell, didTapTabId tabId: Int)
}

final class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var button: UIButton!

    weak var delegate: TabCollectionViewCellDelegate?
    private var data: TabData?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction private func tappedButton(_ sender: UIButton) {
        print("Tapped tag: '\(button.title(for: .normal) ?? "")'")
        guard let tabId = data?.id else {
            return
        }
        delegate?.tabCollectionViewCell(self, didTapTabId: tabId)
    }

    func configure(data: TabData) {
        self.data = data
        button.setTitle(data.title, for: .normal)
    }
}

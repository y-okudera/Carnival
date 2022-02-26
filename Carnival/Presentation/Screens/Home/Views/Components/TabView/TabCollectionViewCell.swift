//
//  TabCollectionViewCell.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import UIKit

protocol TabCollectionViewCellDelegate: AnyObject {
    func tabCollectionViewCell(_ tabCollectionViewCell: TabCollectionViewCell, didTapWithTabId id: String)
}

final class TabCollectionViewCell: UICollectionViewCell {

    weak var delegate: TabCollectionViewCellDelegate?
    private var data: (id: String, title: String)?

    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction private func tappedButton(_ sender: UIButton) {
        print("Tapped \(button.title(for: .normal) ?? "")")
        guard let id = data?.id else {
            return
        }
        delegate?.tabCollectionViewCell(self, didTapWithTabId: id)
    }

    func configure(id: String, title: String) {
        data = (id, title)
        button.setTitle(title, for: .normal)
    }
}

//
//  HomeHeaderView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/25.
//

import UIKit

final class HomeHeaderView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelBottomConstraint: NSLayoutConstraint!

    /// label height + spacer
    var labelHeight: CGFloat {
        titleLabel.frame.height + titleLabelTopConstraint.constant + titleLabelBottomConstraint.constant
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    @IBAction private func tappedInboxButton(_ sender: UIButton) {
        print("Tapped Inbox Button!")
    }

    func updateLabelAlpha(_ alpha: CGFloat) {
        titleLabel.alpha = alpha
    }
}

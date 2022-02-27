//
//  TabView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import UIKit

protocol TabViewDelegate: AnyObject {
    func tabView(_ tabView: TabView, didTapTabId tabId: Int)
}

final class TabView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self

            let cellNames = [TabCollectionViewCell.className]
            cellNames.forEach {
                newValue.register(
                    .init(nibName: $0, bundle: .current),
                    forCellWithReuseIdentifier: $0
                )
            }
        }
    }

    weak var delegate: TabViewDelegate?

    var tabDataArray: [TabData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
}

// MARK: - UICollectionViewDataSource
extension TabView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabDataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.className, for: indexPath) as! TabCollectionViewCell
        cell.configure(data: tabDataArray[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TabView: UICollectionViewDelegate {

}

// MARK: - TabCollectionViewCellDelegate
extension TabView: TabCollectionViewCellDelegate {
    func tabCollectionViewCell(_ tabCollectionViewCell: TabCollectionViewCell, didTapTabId tabId: Int) {
        print(#function, "tabId=\(tabId)")
        delegate?.tabView(self, didTapTabId: tabId)
    }
}

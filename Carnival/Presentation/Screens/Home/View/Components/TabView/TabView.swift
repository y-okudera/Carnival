//
//  TabView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import UIKit

protocol TabViewDelegate: AnyObject {
    func tabView(_ tabView: TabView, didTapWithTabId id: String)
}

final class TabView: UIView {

    /// サンプルデータ
    ///
    /// 実際は、タップ時にタブIDに基づいてデータを読み直すとかします
    private let tabTitles = [
        (id: "0", title: "すべて"),
        (id: "1", title: "関連動画"),
        (id: "2", title: "提供: yuoku"),
        (id: "3", title: "最近アップロードされた動画"),
        (id: "4", title: "視聴済み"),
    ]

    weak var delegate: TabViewDelegate?

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
        return tabTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.className, for: indexPath) as! TabCollectionViewCell
        cell.configure(id: tabTitles[indexPath.row].id, title: tabTitles[indexPath.row].title)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TabView: UICollectionViewDelegate {

}

// MARK: - TabCollectionViewCellDelegate
extension TabView: TabCollectionViewCellDelegate {
    func tabCollectionViewCell(_ tabCollectionViewCell: TabCollectionViewCell, didTapWithTabId id: String) {
        print(#function, "id=\(id)")
        delegate?.tabView(self, didTapWithTabId: id)
    }
}

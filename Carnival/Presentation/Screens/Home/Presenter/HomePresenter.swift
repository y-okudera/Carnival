//
//  HomePresenter.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/27.
//

import Foundation

protocol HomePresenter: AnyObject {
    var tabDataArray: [TabData]? { get }
    var viewData: HomeViewData? { get }
    func viewWillAppear()
    func requestHomeViewData(tabId: Int)
}

final class HomePresenterImpl: HomePresenter {
    
    weak var view: HomeView?
    private(set) var tabDataArray: [TabData]?
    private(set) var viewData: HomeViewData?
    
    func viewWillAppear() {
        tabDataArray = [
            .init(id: 0, title: "すべて"),
            .init(id: 1, title: "関連動画"),
            .init(id: 2, title: "提供: yuoku"),
            .init(id: 3, title: "最近アップロードされた動画"),
            .init(id: 4, title: "視聴済み"),
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.view?.reloadTabs()
        }
    }

    func requestHomeViewData(tabId: Int) {
        let colorCode: String = {
            switch tabId {
            case 0:
                return "3d4070"
            case 1:
                return "ce71f9"
            case 2:
                return "2dfb90"
            case 3:
                return "fb2da5"
            case 4:
                return "fb8a2d"
            default:
                return "3d4070"
            }
        }()
        let viewData = HomeViewData(
            topData: .init(id: 0, title: "HomeContentData-000", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=0"),
            dataArray: [
            .init(id: 1, title: "HomeContentData-001", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=1"),
            .init(id: 2, title: "HomeContentData-002", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=2"),
            .init(id: 3, title: "HomeContentData-003", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=3"),
            .init(id: 4, title: "HomeContentData-004", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=4"),
            .init(id: 5, title: "HomeContentData-005", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=5"),
            .init(id: 6, title: "HomeContentData-006", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=6"),
            .init(id: 7, title: "HomeContentData-007", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=7"),
            .init(id: 8, title: "HomeContentData-008", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=8"),
            .init(id: 9, title: "HomeContentData-009", thumbnailUrl: "https://placehold.jp/\(colorCode)/ffffff/428x313.png?text=9"),
        ])
        self.viewData = viewData

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.view?.reloadView()
        }
    }
}

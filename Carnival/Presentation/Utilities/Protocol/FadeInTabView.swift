//
//  FadeInTabView.swift
//  Carnival
//
//  Created by Yuki Okudera on 2022/02/26.
//

import UIKit

/**
 * スクロールに応じて、フェードインで表示されるタブビュー
 *
 * fadeInTabBaseViewとfadeInTabViewには同じサイズ、同じ見た目のViewを使用する必要があります。
 *
 * アルファ値をあわせて、スクロール位置に応じて、fadeInTabViewを上にずらしていくことで、フェードインしていくように見せます。
 */

/// フェードイン元のView
protocol FadeInTabSourceView: AnyObject {
    var fadeInTabBaseView: UIView! { get }
    var fadeInTabAlpha: CGFloat { get set }
}

/// フェードイン先のView
protocol FadeInTabDestinationView: AnyObject {
    var fadeInTabView: UIView! { get }
    var fadeInTabAlpha: CGFloat { get set }
    // TODO: インタラクティブにアニメーションさせるときに追加
//    var fadeInTabOffsetY: CGFloat { get set }
}

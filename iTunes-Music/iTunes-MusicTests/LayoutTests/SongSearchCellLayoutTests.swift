//
//  SongSearchCellLayoutTests.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/5/23.
//

import LayoutTest
@testable import iTunes_Music

class SongSearchCellLayoutTests: LayoutTestCase {
    func testLayout() {
        runLayoutTests(withViewProvider: SongSearchCell.self) { view, _, _ in
            accessibilityTestsEnabled = false
            guard let view = view as? SongSearchCell else {
                XCTAssert(false)
                return
            }
            view.imageView.lyt_before(view.trackNameLabel)
            view.imageView.lyt_before(view.collectionNameLabel)
            view.imageView.lyt_before(view.artistNameLabel)
            view.trackNameLabel.lyt_above(view.artistNameLabel)
            view.trackNameLabel.lyt_above(view.collectionNameLabel)
            view.artistNameLabel.lyt_before(view.collectionNameLabel)
        }
    }
}

extension SongSearchCell: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        return [:]
    }
    public static func view(forData data: [AnyHashable: Any], reuse reuseView: UIView?, size: ViewSize?, context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let cell = SongSearchCell()
        return cell
    }
}

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
            guard let view = view as? SongSearchCell else {
                XCTAssert(false)
                return
            }
            XCTAssertTrue(view.imageView.lyt_before(view.trackNameLabel))
            XCTAssertTrue(view.imageView.lyt_before(view.collectionNameLabel))
            XCTAssertTrue(view.imageView.lyt_before(view.artistNameLabel))
            XCTAssertTrue(view.trackNameLabel.lyt_above(view.artistNameLabel))
            XCTAssertTrue(view.trackNameLabel.lyt_above(view.collectionNameLabel))
            XCTAssertTrue(view.artistNameLabel.lyt_before(view.collectionNameLabel))
        }
    }
}

extension SongSearchCell: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        return [:]
    }
    public static func view(forData data: [AnyHashable: Any],
                            reuse reuseView: UIView?,
                            size: ViewSize?,
                            context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let cell = SongSearchCell()
        return cell
    }
}

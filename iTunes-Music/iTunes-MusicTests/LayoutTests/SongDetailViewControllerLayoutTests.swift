//
//  SongDetailViewControllerLayoutTests.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/5/23.
//

import LayoutTest
@testable import iTunes_Music

class SongDetailViewControllerLayoutTests: LayoutTestCase {
    func testLayout() {
        runLayoutTests(withViewProvider: SongDetailViewController.self) { _, _, context in
            accessibilityTestsEnabled = false
            guard let detailVC = context as? SongDetailViewController else {
                XCTAssert(false)
                return
            }
            XCTAssertTrue(detailVC.imageView.lyt_above(detailVC.trackNameLabel))
            XCTAssertTrue(detailVC.trackNameLabel.lyt_above(detailVC.collectionNameLabel))
            XCTAssertTrue(detailVC.collectionNameLabel.lyt_above(detailVC.artistNameLabel))
            XCTAssertTrue(detailVC.artistNameLabel.lyt_above(detailVC.releaseDateNameLabel))
            XCTAssertTrue(detailVC.releaseDateNameLabel.lyt_above(detailVC.playButton))
            XCTAssertTrue(detailVC.artistPreviewButton.lyt_before(detailVC.playButton))
            XCTAssertTrue(detailVC.collectionPreviewButton.lyt_after(detailVC.playButton))
        }
    }
}

extension SongDetailViewController: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        return [:]
    }
    public static func view(forData data: [AnyHashable: Any],
                            reuse reuseView: UIView?,
                            size: ViewSize?,
                            context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let detailVC = SongDetailViewController(cellModel: Mocker.songSearchCellViewModel)
        context?.pointee = detailVC
        return detailVC.view
    }
}

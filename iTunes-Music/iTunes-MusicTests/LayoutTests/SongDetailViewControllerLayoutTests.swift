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
            guard let vc = context as? SongDetailViewController else {
                XCTAssert(false)
                return
            }
            vc.imageView.lyt_above(vc.trackNameLabel)
            vc.trackNameLabel.lyt_above(vc.collectionNameLabel)
            vc.collectionNameLabel.lyt_above(vc.artistNameLabel)
            vc.artistNameLabel.lyt_above(vc.releaseDateNameLabel)
            vc.releaseDateNameLabel.lyt_above(vc.playButton)
            vc.artistPreviewButton.lyt_before(vc.playButton)
            vc.collectionPreviewButton.lyt_after(vc.playButton)
        }
    }
}

extension SongDetailViewController: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        return [:]
    }
    public static func view(forData data: [AnyHashable: Any], reuse reuseView: UIView?, size: ViewSize?, context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let vc = SongDetailViewController(cellModel: Mocker.songSearchCellViewModel)
        context?.pointee = vc
        return vc.view
    }
}

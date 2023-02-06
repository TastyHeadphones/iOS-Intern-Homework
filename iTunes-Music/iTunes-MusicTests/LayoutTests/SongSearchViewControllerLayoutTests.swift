//
//  SongSearchViewControllerLayoutTests.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/5/23.
//

import LayoutTest
@testable import iTunes_Music

class SongSearchViewControllerLayoutTests: LayoutTestCase {
    func testLayout() {
        runLayoutTests(withViewProvider: SongSearchViewController.self) { _, _, context in
            accessibilityTestsEnabled = false
            viewOverlapTestsEnabled = false
            guard let searchVC = context as? SongSearchViewController else {
                XCTAssert(false)
                return
            }
            searchVC.searchBar.lyt_above(vc.searchSongsListView)
        }
    }
}

extension SongSearchViewController: ViewProvider {
    public static func dataSpecForTest() -> [AnyHashable: Any] {
        return [:]
    }
    public static func view(forData data: [AnyHashable: Any],
                            reuse reuseView: UIView?, size: ViewSize?,
                            context: AutoreleasingUnsafeMutablePointer<AnyObject?>?) -> UIView {
        let searchVC = SongSearchViewController()
        context?.pointee = searchVC
        return searchVC.view
    }
}

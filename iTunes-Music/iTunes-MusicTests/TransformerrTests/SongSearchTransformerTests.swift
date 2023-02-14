//
//  SongSearchTransformerTests.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/14/23.
//

import XCTest
@testable import iTunes_Music

class SongSearchTransformerTests: XCTestCase {

    func testTransform() {
        let rawData = Mocker.itunesSearchResult
        let data = SongSearchCellViewModel(searchResult: rawData)
        XCTAssertEqual(rawData.collectionName, data.collectionName)
        XCTAssertEqual(rawData.artistName, data.artistName)
        XCTAssertEqual(rawData.trackName, data.trackName)
        XCTAssertEqual(rawData.trackId, data.trackId)
    }
}

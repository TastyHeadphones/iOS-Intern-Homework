//
//  SongDetailTransformerTests.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/14/23.
//

import XCTest
@testable import iTunes_Music

class SongDetailTransformerTests: XCTestCase {

    func testTransform() {
        let rawData = Mocker.itunesLookupResult
        let cellData = Mocker.songSearchCellViewModel
        let data = SongDetailViewModel(lookupResult: rawData, cellModel: cellData)
        XCTAssertEqual(rawData.artistName, data.artistName)
        XCTAssertEqual(cellData.collectionName, data.collectionName)
        XCTAssertEqual(cellData.trackName, data.trackName)
    }
}

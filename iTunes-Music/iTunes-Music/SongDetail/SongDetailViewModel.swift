//
//  SongDetailViewModel.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/3/23.
//

import Foundation

class SongDetailViewModel {
    let artworkImageUrl: URL?
    let collectionName: String?
    let releaseDate: String?
    let trackName: String?
    let artistViewUrl: URL?
    let collectionViewUrl: URL?
    let previewUrl: URL?

    // Lookup API doesn't hava collectionName and trackName which need to pass from cell
    init(lookupResult: ItunesLookupResult, cellModel: SongSearchCellViewModel) {
        self.artworkImageUrl = URL(string: lookupResult.artistLinkUrl ?? "")
        self.collectionName = cellModel.collectionName
        self.releaseDate = cellModel.releaseDate
        self.trackName = cellModel.trackName
        self.artistViewUrl = URL(string: lookupResult.artistLinkUrl ?? "")
        self.collectionViewUrl = cellModel.collectionViewUrl
        self.previewUrl = cellModel.previewUrl
    }
}

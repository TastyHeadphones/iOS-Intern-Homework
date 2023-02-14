//
//  SongSearchCellViewModel.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import IGListKit

class SongSearchCellViewModel: ListDiffable {

    let imageURL: URL?
    let collectionName: String?
    let artistName: String?
    let trackName: String?

    // Pass these property to SongDetailViewModel which lookup API doesn't have these schema
    let trackId: Int?
    let artistViewUrl: URL?
    let previewUrl: URL?
    let collectionViewUrl: URL?
    let releaseDate: String?

    init(searchResult: ItunesSearchResult) {
        self.imageURL = URL(string: searchResult.artworkUrl100 ?? "")
        self.collectionName = searchResult.collectionName
        self.artistName = searchResult.artistName
        self.trackName = searchResult.trackName

        self.trackId = searchResult.trackId
        self.previewUrl = URL(string: searchResult.previewUrl ?? "")
        self.artistViewUrl = URL(string: searchResult.artistViewUrl ?? "")
        self.collectionViewUrl = URL(string: searchResult.collectionViewUrl ?? "")
        self.releaseDate = searchResult.releaseDate
    }

    func diffIdentifier() -> NSObjectProtocol {
        return "\(trackId ?? 0)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        true
    }
}

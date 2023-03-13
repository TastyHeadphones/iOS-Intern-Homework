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

    init(searchpResult: ItunesSearchpResult) {
        self.imageURL = URL(string: searchpResult.artworkUrl100 ?? "")
        self.collectionName = searchpResult.collectionName
        self.artistName = searchpResult.artistName
        self.trackName = searchpResult.trackName

        self.trackId = searchpResult.trackId
        self.previewUrl = URL(string: searchpResult.previewUrl ?? "")
        self.artistViewUrl = URL(string: searchpResult.artistViewUrl ?? "")
        self.collectionViewUrl = URL(string: searchpResult.collectionViewUrl ?? "")
        self.releaseDate = searchpResult.releaseDate
    }

    func diffIdentifier() -> NSObjectProtocol {
        return "\(trackId ?? 0)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        true
    }
}

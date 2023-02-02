//
//  SongSearchCellViewModel.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import IGListKit

class SongSearchCellViewModel: ListDiffable {

    private let trackId: Int
    let imageURL: URL
    let collectionName: String?
    let artistName: String
    let trackName: String

    init(searchpResult: ItunesSearchpResult) {
        self.trackId = searchpResult.trackId
        self.imageURL = URL(string: searchpResult.artworkUrl100)!
        self.collectionName = searchpResult.collectionName
        self.artistName = searchpResult.artistName
        self.trackName = searchpResult.trackName
    }

    func diffIdentifier() -> NSObjectProtocol {
        return (artistName + trackName + "\(trackId)") as NSObjectProtocol
    }
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        true
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itunessearchResults = try? JSONDecoder().decode(ItunessearchResults.self, from: jsonData)

import Foundation

// MARK: - ItunessearchResults
struct ItunesSearchResults: Decodable {
    let resultCount: Int
    let results: [ItunesSearchResult]
}

// MARK: - Result
struct ItunesSearchResult: Decodable {
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
    let trackRentalPrice: Double?
    let collectionHdPrice: Double?
    let trackHdPrice: Double?
    let trackHdRentalPrice: Double?
    let contentAdvisoryRating: String?
    let shortDescription: String?
    let longDescription: String?
    let hasITunesExtras: Bool?
    let collectionArtistName: String?
}

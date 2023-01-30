// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itunesLookupResults = try? JSONDecoder().decode(ItunesLookupResults.self, from: jsonData)

import Foundation

// MARK: - ItunesLookupResults
struct ItunesLookupResults: Decodable {
    let resultCount: Int
    let results: [ItunesLookupResult]
}

// MARK: - Result
struct ItunesLookupResult: Decodable {
    let wrapperType: String
    let artistType: String
    let artistName: String
    let artistLinkUrl: String
    let artistId: Int
    let amgArtistId: Int
    let primaryGenreName: String
    let primaryGenreId: Int
}

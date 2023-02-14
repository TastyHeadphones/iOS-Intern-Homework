//
//  Mocker.swift
//  iTunes-MusicTests
//
//  Created by Magic Keegan on 2/5/23.
//

@testable import iTunes_Music
import LayoutTestBase

class Mocker {

    static var itunesSearchResult: ItunesSearchResult { return ItunesSearchResult(
        wrapperType: StringValues().values.randomElement() as? String,
        kind: StringValues().values.randomElement() as? String,
        artistId: IntegerValues().values.randomElement() as? Int,
        collectionId: IntegerValues().values.randomElement() as? Int,
        trackId: IntegerValues().values.randomElement() as? Int,
        artistName: StringValues().values.randomElement() as? String,
        collectionName: StringValues().values.randomElement() as? String,
        trackName: StringValues().values.randomElement() as? String,
        collectionCensoredName: StringValues().values.randomElement() as? String,
        trackCensoredName: StringValues().values.randomElement() as? String,
        artistViewUrl: StringValues().values.randomElement() as? String,
        collectionViewUrl: StringValues().values.randomElement() as? String,
        trackViewUrl: StringValues().values.randomElement() as? String,
        previewUrl: StringValues().values.randomElement() as? String,
        artworkUrl30: StringValues().values.randomElement() as? String,
        artworkUrl60: StringValues().values.randomElement() as? String,
        artworkUrl100: StringValues().values.randomElement() as? String,
        releaseDate: StringValues().values.randomElement() as? String,
        collectionExplicitness: StringValues().values.randomElement() as? String,
        trackExplicitness: StringValues().values.randomElement() as? String,
        discCount: IntegerValues().values.randomElement() as? Int,
        discNumber: IntegerValues().values.randomElement() as? Int,
        trackCount: IntegerValues().values.randomElement() as? Int,
        trackNumber: IntegerValues().values.randomElement() as? Int,
        trackTimeMillis: IntegerValues().values.randomElement() as? Int,
        country: StringValues().values.randomElement() as? String,
        currency: StringValues().values.randomElement() as? String,
        primaryGenreName: StringValues().values.randomElement() as? String,
        isStreamable: BoolValues().values.randomElement() as? Bool,
        collectionArtistId: IntegerValues().values.randomElement() as? Int,
        collectionArtistViewUrl: StringValues().values.randomElement() as? String,
        trackRentalPrice: FloatValues().values.randomElement() as? Double,
        collectionHdPrice: FloatValues().values.randomElement() as? Double,
        trackHdPrice: FloatValues().values.randomElement() as? Double,
        trackHdRentalPrice: FloatValues().values.randomElement() as? Double,
        contentAdvisoryRating: StringValues().values.randomElement() as? String,
        shortDescription: StringValues().values.randomElement() as? String,
        longDescription: StringValues().values.randomElement() as? String,
        hasITunesExtras: StringValues().values.randomElement() as? Bool,
        collectionArtistName: StringValues().values.randomElement() as? String)
    }

    static var songSearchCellViewModel: SongSearchCellViewModel {
        return SongSearchCellViewModel(searchResult: Self.itunesSearchResult)
    }

    static var itunesLookupResult: ItunesLookupResult {
        return ItunesLookupResult(
            wrapperType: StringValues().values.randomElement() as? String,
            artistType: StringValues().values.randomElement() as? String,
            artistName: StringValues().values.randomElement() as? String,
            artistLinkUrl: StringValues().values.randomElement() as? String,
            artistId: IntegerValues().values.randomElement() as? Int,
            amgArtistId: IntegerValues().values.randomElement() as? Int,
            primaryGenreName: StringValues().values.randomElement() as? String,
            primaryGenreId: IntegerValues().values.randomElement() as? Int)
    }
}

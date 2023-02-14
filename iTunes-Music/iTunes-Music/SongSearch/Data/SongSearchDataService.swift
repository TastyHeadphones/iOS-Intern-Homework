//
//  SongSearchDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import Foundation

class SongSearchDataService: BaseDataService<ItunesSearchResults, [SongSearchCellViewModel]> {

    init(term: String, offset: Int) {
        let repository = SongSearchRepository(term: term, offset: offset)
        super.init(repository: repository)
    }

    override func transform(rawData: ItunesSearchResults?) -> [SongSearchCellViewModel]? {
        guard let rawData = rawData else {
            return nil
        }
        guard !rawData.results.isEmpty else {
            return nil
        }
        return rawData.results.compactMap { result in
            // trackId is optional in API side, but the cell need it to navigate to detail page
            guard result.trackId != nil else {
                return nil
            }
            return SongSearchCellViewModel(searchResult: result)
        }
    }
}

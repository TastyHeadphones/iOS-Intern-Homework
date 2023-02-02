//
//  SongSearchDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import Foundation

class SongSearchDataService: BaseDataService<ItunesSearchpResults, [SongSearchCellViewModel]> {

    init(term: String, offset: Int) {
        let repository = SongSearchRepository(term: term, offset: offset)
        super.init(repository: repository)
    }

    override func transform(rawData: ItunesSearchpResults?) -> [SongSearchCellViewModel]? {
        guard let rawData = rawData else {
            return nil
        }
        guard !rawData.results.isEmpty else {
            return nil
        }
        return rawData.results.map { result in
            return SongSearchCellViewModel(searchpResult: result)
        }
    }
}

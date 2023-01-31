//
//  SongSearchDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import Foundation

class SongSearchDataService: BaseDataService<ItunesSearchpResults, [SongSearchCellViewModel]> {
    override func transform(rawData: ItunesSearchpResults?) -> [SongSearchCellViewModel]? {
        guard let rawData = rawData else {
            return nil
        }
        return rawData.results.map { result in
            return SongSearchCellViewModel(searchpResult: result)
        }
    }
}

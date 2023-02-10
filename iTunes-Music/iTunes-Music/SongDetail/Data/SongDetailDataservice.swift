//
//  SongDetailDataservice.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/3/23.
//

class SongDetailDataservice: BaseDataService<ItunesLookupResults, SongDetailViewModel> {

    let cellModel: SongSearchCellViewModel

    init(trackId: Int, cellModel: SongSearchCellViewModel) {
        self.cellModel = cellModel
        let repository = SongDetailRepository(trackId: trackId)
        super.init(repository: repository)
    }

    override func transform(rawData: ItunesLookupResults?) -> SongDetailViewModel? {
        guard let rawData = rawData else {
            return nil
        }
        guard let lookupResult = rawData.results.first else {
            return nil
        }
        return SongDetailViewModel(lookupResult: lookupResult, cellModel: cellModel)
    }
}

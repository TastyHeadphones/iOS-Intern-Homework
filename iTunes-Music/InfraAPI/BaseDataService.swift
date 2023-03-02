//
//  BaseDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/29/23.
//

import Foundation
import Combine

class BaseDataService<T: Decodable, U> {
    private let repository: BaseRepository<T>

    var resource: Publishers.Map<Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, JSONDecoder.Input>, T, JSONDecoder>, U?> {
        return repository.resource
            .map { rawData in return self.transform(rawData: rawData) }
    }

    init(repository: BaseRepository<T>) {
        self.repository = repository
    }

    open func transform(rawData: T?) -> U? {
        fatalError("BaseDataService transform func must be override")
    }
}

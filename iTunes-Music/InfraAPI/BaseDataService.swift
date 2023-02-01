//
//  BaseDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/29/23.
//

import Foundation
import Combine

class BaseDataService<T: Decodable,U> {
    private let repository: BaseRepository<T>
    lazy var resource = repository.resource
        .map{ rawData in return self.transform(rawData: rawData) }

    init(repository: BaseRepository<T>) {
        self.repository = repository
    }

    open func transform(rawData: T?) -> U? {
        fatalError("BaseDataService transform func must be override")
    }
}

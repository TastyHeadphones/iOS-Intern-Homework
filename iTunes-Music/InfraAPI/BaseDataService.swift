//
//  BaseDataService.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/29/23.
//

import Foundation
import Combine

class BaseDataService<T: Decodable,U> {
    private let rawResource: Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, JSONDecoder.Input>, T, JSONDecoder>
    private var rawData:T?
    private var cancellableSet: Set<AnyCancellable> = []
    lazy var data = transform(rawData: rawData)
    init(rawResource: Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, JSONDecoder.Input>, T, JSONDecoder>) {
        self.rawResource = rawResource
    }

    open func transform(rawData: T?) -> U? {
        fatalError("BaseDataService transform func must be override")
    }

    open func fetch() {
        rawResource.sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { data in
            self.rawData = data
        }).store(in: &self.cancellableSet)
    }
}

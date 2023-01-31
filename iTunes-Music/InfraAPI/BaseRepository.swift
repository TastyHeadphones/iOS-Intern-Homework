//
//  BaseRepository.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/29/23.
//

import Foundation
import Combine

class BaseRepository<T: Decodable> {
    let url: URL
    lazy var resource = URLSession.shared.dataTaskPublisher(for: url)
        .map{ $0.data }
        .decode(type: T.self, decoder: JSONDecoder())

    init(url: URL) {
        self.url = url
    }
}

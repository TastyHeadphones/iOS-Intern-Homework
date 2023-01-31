//
//  SongSearchRepository.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import Foundation

class SongSearchRepository: BaseRepository<ItunesSearchpResults> {

    init(term: String, offset: Int) {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")
        let queryItems = [URLQueryItem(name: "term", value: term), URLQueryItem(name: "offset", value: "\(offset)")]
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            fatalError("Wrong Search URL Scheme")
        }
        super.init(url: url)
    }
}

//
//  SongDetailRepository.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/3/23.
//

import Foundation

class SongDetailRepository: BaseRepository<ItunesLookupResults> {
    init(trackId: Int) {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/lookup")
        let queryItems = [URLQueryItem(name: "id", value: "\(trackId)")]
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            fatalError("Wrong Search URL Scheme")
        }
        super.init(url: url)
    }
}

//
//  SongSearchViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import UIKit
import Combine

class SongSearchViewController: BaseViewController {

    var offset: Int = 0
    private var cancellableSet: Set<AnyCancellable> = []

    let dataService: SongSearchDataService

    override init() {
        self.dataService = SongSearchDataService(term: "五月天", offset: offset)
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupSubscribes() {
        dataService.resource.sink { com in
            print(com)
        } receiveValue: { data in
            print(data)
        }.store(in: &cancellableSet)
    }
}

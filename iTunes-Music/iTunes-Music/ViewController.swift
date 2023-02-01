//
//  ViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/27/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private var cancellableSet: Set<AnyCancellable> = []

    let d = SongSearchDataService()
//    lazy var d = SongSearchDataService(rawResource: r.resource)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        d.resource.sink { com in
            print(com)
        } receiveValue: { data in
            print(data)
        }
        .store(in: &cancellableSet)

    }


}


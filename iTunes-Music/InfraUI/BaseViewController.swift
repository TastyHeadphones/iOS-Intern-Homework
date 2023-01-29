//
//  BaseViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/28/23.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties

    // MARK: - View Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupSubscribes()
        fetchData()
    }

    // MARK: - Setup
    /// Abstract method. Subclasses should override this method to setup their view.
    open func setupViews() {

    }
    /// Abstract method. Subclasses should override this method to setup their view.
    open func setupConstraints() {

    }

    // MARK: - Subscribes
    /// Abstract method. Subclasses should override this method to setup their view.
    open func setupSubscribes() {

    }

    /// Abstract method. Subclasses should override this method to setup their view.
    open func fetchData() {

    }
}
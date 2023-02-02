//
//  BaseViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/28/23.
//

import UIKit
import IGListKit

class BaseViewController: UIViewController {
    
    // MARK: - Constants

    static let spinToken = "spinner"

    // MARK: - Properties

    var isLoading = false

    // MARK: - Initializers

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    open func spinnerSectionController() -> ListSingleSectionController {
        let configureBlock = { (_: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? SpinnerCell else {
                return
            }
            cell.activityIndicator.startAnimating()
        }

        let sizeBlock = { (_: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 100)
        }

        return ListSingleSectionController(
            cellClass: SpinnerCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}

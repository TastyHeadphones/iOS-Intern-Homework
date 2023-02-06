//
//  BaseViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/28/23.
//

import UIKit
import IGListKit
import SnapKit
import WebKit
import Combine

class BaseViewController: UIViewController {

    // MARK: - Constants

    static let spinToken = "spinner"

    // MARK: - Properties

    open var isLoading = false
    open var cancellableSet: Set<AnyCancellable> = []

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

    // MARK: - Utils Function

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

    open func emptyView() -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ITunes_12.2_logo")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }

    open func openUrl(url: URL?) {
        guard let url = url else {
            return
        }
        let webView = WKWebView()
        let webVC = UIViewController()
        webVC.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        webView.load(URLRequest(url: url))
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}

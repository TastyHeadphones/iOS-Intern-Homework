//
//  SpinnerCell.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/1/23.
//

import IGListKit

class SpinnerCell: UICollectionViewCell {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = UIActivityIndicatorView.defaultStyle
        self.contentView.addSubview(view)
        return view
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}

extension UIActivityIndicatorView {
    class var defaultStyle: UIActivityIndicatorView.Style {
        if #available(iOS 13.0, *) {
            return .medium
        } else {
            return .gray
        }
    }
}

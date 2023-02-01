//
//  SongSearchCell.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import UIKit
import SDWebImage
import IGListKit

class SongSearchCell: UICollectionViewCell {

    let containerView = UIView()
    let imageView = UIImageView()
    let collectionNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let trackNameLabel = UILabel()
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.defaultSeparator.cgColor
        return layer
    }()

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.xmedium.rawValue)
            make.top.bottom.equalToSuperview().inset(Spacing.xsmall.rawValue)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Spacing.medium.rawValue)
            make.top.bottom.equalToSuperview().inset(Spacing.xsmall.rawValue)
            make.width.equalTo(self.contentView.snp.height)
        }
        collectionNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Spacing.medium.rawValue)
            make.height.equalToSuperview()
        }
        artistNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(collectionNameLabel.snp.trailing).offset(Spacing.medium.rawValue)
            make.height.equalToSuperview()
        }
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(artistNameLabel.snp.trailing).offset(Spacing.medium.rawValue)
            make.height.equalToSuperview()
        }
        separator.frame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: CGFloat(Spacing.point.rawValue))
    }

    func setupViews() {
        backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(collectionNameLabel)
        containerView.addSubview(artistNameLabel)
        containerView.addSubview(trackNameLabel)
        containerView.layer.addSublayer(separator)
    }
}

extension SongSearchCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? SongSearchCellViewModel else { return }
        setupViews()
        setupConstraints()
        imageView.sd_setImage(with: viewModel.imageURL)
        collectionNameLabel.text = viewModel.collectionName
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.trackName
    }
}

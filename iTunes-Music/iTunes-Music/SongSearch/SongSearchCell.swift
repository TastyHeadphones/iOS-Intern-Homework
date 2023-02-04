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
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Spacing.small
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(Spacing.xmedium)
        return label
    }()
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(Spacing.xmedium)
        return label
    }()
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(Spacing.xmedium)
        return label
    }()
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.defaultSeparator.cgColor
        return layer
    }()

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.xmedium)
            make.top.bottom.equalToSuperview().inset(Spacing.small)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Spacing.medium)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(Spacing.imageHeight)
        }
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(Spacing.medium)
            make.trailing.equalToSuperview().inset(Spacing.medium)
        }
        artistNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Spacing.medium)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Spacing.medium)
        }
        collectionNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(artistNameLabel.snp.trailing).offset(Spacing.medium)
            make.trailing.equalToSuperview().inset(Spacing.medium)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Spacing.medium)
        }
        separator.frame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: CGFloat(Spacing.point))
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

    func inflate(_ viewModel: SongSearchCellViewModel) {
        setupViews()
        setupConstraints()
        imageView.sd_setImage(with: viewModel.imageURL)
        collectionNameLabel.text = viewModel.collectionName
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.trackName
    }

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? SongSearchCellViewModel else { return }
        inflate(viewModel)
    }
}

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

    let imageView = UIImageView()
    let collectionNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let trackNameLabel = UILabel()

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Spacing.medium.rawValue)
            make.height.equalToSuperview()
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
    }

    func setupViews() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(collectionNameLabel)
        addSubview(artistNameLabel)
        addSubview(trackNameLabel)
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

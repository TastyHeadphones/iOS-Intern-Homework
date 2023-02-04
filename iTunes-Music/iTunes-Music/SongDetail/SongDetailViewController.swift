//
//  SongDetailViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/3/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class SongDetailViewController: BaseViewController {

    let dataService: SongDetailDataservice

    let cellModel: SongSearchCellViewModel
    
    var viewModel: SongDetailViewModel? {
        didSet {
            imageView.sd_setImage(with: viewModel?.artworkImageUrl)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.trackNameLabel.text = self.viewModel?.trackName
                self.collectionNameLabel.text = self.viewModel?.collectionName
                self.artistNameLabel.text = self.viewModel?.artistName
                self.releaseDateNameLabel.text = self.viewModel?.releaseDate
            }
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Spacing.small
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Spacing.large)
        return label
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

    let releaseDateNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(Spacing.xmedium)
        return label
    }()

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var artistPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.addTarget(self, action: #selector(artistPreviewButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var collectionPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.addTarget(self, action: #selector(collectionPreviewButtonTapped), for: .touchUpInside)
        return button
    }()

    init(cellModel: SongSearchCellViewModel) {
        self.cellModel = cellModel
        self.dataService = SongDetailDataservice(trackId: cellModel.trackId!, cellModel: cellModel)
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(trackNameLabel)
        view.addSubview(collectionNameLabel)
        view.addSubview(releaseDateNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(playButton)
        view.addSubview(artistPreviewButton)
        view.addSubview(collectionPreviewButton)
    }

    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Spacing.large)
            make.width.height.equalTo(Spacing.detailImageHeight)
            make.centerX.equalToSuperview()
        }
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Spacing.large)
            make.leading.trailing.equalToSuperview().inset(Spacing.large)
        }
        collectionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.large)
        }
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.large)
        }
        releaseDateNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.large)
        }
        artistPreviewButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().inset(Spacing.large)
        }
        playButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        collectionPreviewButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalToSuperview().inset(Spacing.large)
        }
    }

    override func setupSubscribes() {
        dataService.resource.sink { com in
            print("\(com)")
        } receiveValue: { [weak self] data in
            guard let self = self else {
                return
            }
            guard let data = data else {
                return
            }
            self.viewModel = data
        }.store(in: &cancellableSet)
    }

    @objc
    func playButtonTapped() {
        openUrl(url: viewModel?.previewUrl)
    }

    @objc
    func artistPreviewButtonTapped() {
        openUrl(url: viewModel?.artistViewUrl)
    }

    @objc
    func collectionPreviewButtonTapped() {
        openUrl(url: viewModel?.collectionViewUrl)
    }
}

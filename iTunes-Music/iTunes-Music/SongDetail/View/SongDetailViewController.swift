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
import Toast_Swift

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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Spacing.large)
        return label
    }()

    let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = label.font.withSize(Spacing.xmedium)
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
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
        button.accessibilityIdentifier = SongDetailA11Y.playButtonIdentifier
        button.accessibilityLabel = SongDetailA11Y.playButtonLabel
        return button
    }()

    lazy var artistPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.addTarget(self, action: #selector(artistPreviewButtonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = SongDetailA11Y.artistPreviewButtonIdentifier
        button.accessibilityLabel = SongDetailA11Y.artistPreviewButtonLabel
        return button
    }()

    lazy var collectionPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.addTarget(self, action: #selector(collectionPreviewButtonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = SongDetailA11Y.collectionPreviewButtonIdentifier
        button.accessibilityLabel = SongDetailA11Y.collectionPreviewButtonLabel
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
            make.leading.trailing.equalToSuperview().inset(Spacing.xmedium)
            make.height.equalTo(imageView.snp.width)
        }
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Spacing.large)
            make.leading.trailing.equalTo(imageView)
        }
        collectionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalTo(imageView)
        }
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalTo(imageView)
        }
        releaseDateNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(Spacing.medium)
            make.leading.trailing.equalTo(imageView)
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
        dataService.resource.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let anError):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.view.makeToast(anError.localizedDescription, duration: 3.0, position: .center)
                    self.imageView.image = UIImage(systemName: "exclamationmark.icloud")
                }
            }
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

    func openUrl(url: URL?, nilMessage: String) {
        guard let url = url else {
            self.view.makeToast(nilMessage, duration: 3.0, position: .top)
            return
        }
        openUrl(url: url)
    }

    @objc
    func artistPreviewButtonTapped() {
        openUrl(
            url: viewModel?.artistViewUrl,
            nilMessage: "Sorry, the artist preview is not available for this track".localized())
    }

    @objc
    func playButtonTapped() {
        openUrl(
            url: viewModel?.previewUrl,
            nilMessage: "Sorry, the song is not available for this track".localized())
    }

    @objc
    func collectionPreviewButtonTapped() {
        openUrl(
            url: viewModel?.collectionViewUrl,
            nilMessage: "Sorry, the collection preview is not available for this track".localized())
    }
}

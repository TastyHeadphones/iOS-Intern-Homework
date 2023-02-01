//
//  SongSearchViewController.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 1/30/23.
//

import UIKit
import Combine
import Localize_Swift
import SnapKit
import IGListKit

class SongSearchViewController: BaseViewController {

    var offset: Int = 0
    var searchSongs: [SongSearchCellViewModel] = []

    private var cancellableSet: Set<AnyCancellable> = []

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search".localized()
        return label
    }()

    let searchSongsListView: ListCollectionView = ListCollectionView()

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    let dataService: SongSearchDataService

    override init() {
        self.dataService = SongSearchDataService(term: "五月天", offset: offset)
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(searchSongsListView)
        adapter.collectionView = searchSongsListView
        adapter.dataSource = self
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Spacing.large.rawValue)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(20)
        }
        searchSongsListView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    override func setupSubscribes() {
        dataService.resource.sink { com in
            print(com)
        } receiveValue: { [weak self] data in
            guard let self = self else {
                return
            }
            guard let data = data else {
                return
            }
            self.searchSongs.append(contentsOf: data)
            DispatchQueue.main.async {
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        }.store(in: &cancellableSet)
    }
}

extension SongSearchViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects = searchSongs as [ListDiffable]
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SearchSongsSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

final class SearchSongsSectionController: ListSectionController {

    private var object: SongSearchCellViewModel?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: SongSearchCell = collectionContext?.dequeueReusableCell(of: SongSearchCell.self, for: self, at: index) as! SongSearchCell
        cell.bindViewModel(object!)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? SongSearchCellViewModel
    }
}

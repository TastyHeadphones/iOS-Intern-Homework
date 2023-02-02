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

    static let offsetStep = SongSearchRepository.limit
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

    var dataService: SongSearchDataService {
        didSet {
            isLoading = true
            dataService.resource.sink { com in
                print("\(com) offset= \(self.offset)")
            } receiveValue: { [weak self] data in
                guard let self = self else {
                    return
                }
                guard let data = data else {
                    return
                }
                self.searchSongs.append(contentsOf: data)
                self.isLoading = false
                print(self.searchSongs.count)
                DispatchQueue.main.async {
                    self.adapter.performUpdates(animated: true, completion: nil)
                }
            }.store(in: &cancellableSet)
        }
    }

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
        searchSongsListView.showsVerticalScrollIndicator = false
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Spacing.large)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(20)
        }
        searchSongsListView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
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
        if isLoading {
            objects.append(Self.spinToken as ListDiffable)
        }
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let obj = object as? String, obj == Self.spinToken {
            return spinnerSectionController()
        } else {
            return SearchSongsSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension SongSearchViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading && distance < 200 {
            isLoading = true
            adapter.performUpdates(animated: true, completion: nil)
            offset += Self.offsetStep
            self.dataService = SongSearchDataService(term: "五月天", offset: offset)
        }
    }
}

class SearchSongsSectionController: ListSectionController {

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

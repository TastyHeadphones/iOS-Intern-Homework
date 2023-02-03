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

    let searchBar = UISearchBar()
    var searchBarString = ""

    let searchSongsListView: ListCollectionView = ListCollectionView()

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var dataService: SongSearchDataService {
        didSet {
            cancellableSet.removeAll()
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
        self.dataService = SongSearchDataService(term: "", offset: offset)
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "HomeTitle".localized()
        view.addSubview(searchBar)
        view.addSubview(searchSongsListView)
        searchBar.delegate = self
        adapter.collectionView = searchSongsListView
        searchSongsListView.showsVerticalScrollIndicator = false
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }

    override func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        searchSongsListView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
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
        return emptyView()
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
            self.dataService = SongSearchDataService(term: searchBarString, offset: offset)
        }
    }
}

extension SongSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarString = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        offset = 0
        searchSongs.removeAll()
        DispatchQueue.main.async {
            self.adapter.performUpdates(animated: true, completion: nil)
        }
        dataService = SongSearchDataService(term: searchBarString, offset: offset)
    }
}

class SearchSongsSectionController: ListSectionController {

    private var object: SongSearchCellViewModel?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: Spacing.cellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: SongSearchCell = collectionContext?.dequeueReusableCell(of: SongSearchCell.self, for: self, at: index) as! SongSearchCell
        cell.bindViewModel(object!)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? SongSearchCellViewModel
    }

    override func didSelectItem(at index: Int) {
        let vc = SongDetailViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

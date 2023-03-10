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
import Toast_Swift

class SongSearchViewController: BaseViewController {

    static let offsetStep = SongSearchRepository.limit
    var offset: Int = 0

    var searchSongs: [SongSearchCellViewModel] = []

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.accessibilityIdentifier = SongSearchA11Y.searchBarIdentifier
        searchBar.searchTextField.accessibilityLabel = SongSearchA11Y.searchBarLabel
        return searchBar
    }()

    var searchBarString = ""

    let searchSongsListView: ListCollectionView = ListCollectionView()

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    private func performDataServiceUpdate(with dataService: SongSearchDataService) {
        isLoading = true
        dataService.resource.sink { [weak self] completion in
            guard let self = self else {
                return
            }
            self.cancellableSet.removeAll()
            self.isLoading = false
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.adapter.performUpdates(animated: true, completion: nil)
            }
            switch completion {
            case .finished: break
            case .failure(let anError):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.view.makeToast(anError.localizedDescription, duration: 3.0, position: .center)
                }
            }
        } receiveValue: { [weak self] data in
            guard let self = self else {
                return
            }
            guard let data = data else {
                return
            }
            self.searchSongs.append(contentsOf: data)
        }.store(in: &cancellableSet)
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
            let dataService = SongSearchDataService(term: searchBarString, offset: offset)
            performDataServiceUpdate(with: dataService)
        }
    }
}

extension SongSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        offset = 0
        searchBarString = searchBar.text ?? ""
        searchBar.endEditing(true)
        searchSongs.removeAll()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.adapter.performUpdates(animated: true, completion: nil)
        }
        let dataService = SongSearchDataService(term: searchBarString, offset: offset)
        performDataServiceUpdate(with: dataService)
    }
}

class SearchSongsSectionController: ListSectionController {

    private var object: SongSearchCellViewModel?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: Spacing.cellHeight)
    }

    // swiftlint:disable force_cast
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: SongSearchCell = collectionContext?.dequeueReusableCell(
            of: SongSearchCell.self,
            for: self, at: index) as! SongSearchCell
        cell.bindViewModel(object!)
        return cell
    }
    // swiftlint:enable force_cast
    override func didUpdate(to object: Any) {
        self.object = object as? SongSearchCellViewModel
    }

    override func didSelectItem(at index: Int) {
        let detailVC = SongDetailViewController(cellModel: object!)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

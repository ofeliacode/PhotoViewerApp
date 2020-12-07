//
//  ViewController.swift
//  galleryApp
//
//  Created by Офелия Баширова on 05.12.2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK:- Variables
    var picturesArray: GalleryModel?
    let networkDataFetcher = NetworkDataFetcher()
    var numberPageResult: Int = 1
    var collectionView : UICollectionView?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
        fetchPicturesData()
    }
    
    // MARK: - Setup collectionview
    func setupCollectionview() {
            super.loadView()
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
            guard let collectionView = collectionView else {
                return
            }
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .white
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
            self.collectionView = collectionView
        }
    
    // MARK:- get fetched pictures from api into collectionview
    private func fetchPicturesData() {
            networkDataFetcher.fetchPics(pageNumber: numberPageResult, completion: { (loadedPics) in
                self.picturesArray = loadedPics
                self.collectionView?.reloadData()
            })
    }
    
    // MARK:-  Pagination: fetch new page of pictures
    func fetchNextPageOfPics() {
        networkDataFetcher.fetchPics(pageNumber: numberPageResult) { (loadedPics) in
            guard let newPage = loadedPics else { return }
            for item in newPage.hits {
                self.picturesArray?.hits.append(item)
            }
        }
    }
    
    // MARK:- building collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesArray?.hits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let picture = picturesArray?.hits[indexPath.row]
        cell.setup(picture!)
        cell.backgroundColor = .black
        return cell
    }
    // MARK:-  Scrollview + paging
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        if offsetX > contentWidth - scrollView.frame.width {
            fetchNextPageOfPics()
            numberPageResult += 1
            collectionView?.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 450)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}




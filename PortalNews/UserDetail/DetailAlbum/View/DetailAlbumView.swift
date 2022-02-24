//
//  DetailAlbumView.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit
import SkeletonView
import ImageViewer_swift

class DetailAlbumView: BaseVC {

    @IBOutlet weak var collectionPhoto: UICollectionView!
    
    var albumId = 0
    
    private let detailAlbumViewModel = DetailAlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
    }
    
    //MARK: - Cofigure View
    internal override func setupViews() {
        
        setupCollectionView()
        collectionPhoto.register(CollectionPhotoCell.collectionPhotoNib(), forCellWithReuseIdentifier: CollectionPhotoCell.identifier)
        collectionPhoto.delegate = self
        collectionPhoto.dataSource = self
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        collectionPhoto.collectionViewLayout = layout
        collectionPhoto.frame = .zero
        collectionPhoto.backgroundColor = .bgSoftBlue
        collectionPhoto.alwaysBounceVertical = true
    }
    
    //MARK: - Populate Data
    private func populateData() {
        isLoading = true
        view.showAnimatedGradientSkeleton()
        detailAlbumViewModel.populateData(albumId: albumId)
        detailAlbumViewModel.showError = { [weak self] errorMsg in
            self?.isLoading = false
            self?.view.showToast(errorMsg)
        }
        detailAlbumViewModel.fetchedPhotos = { [weak self] in
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.collectionPhoto.reloadData()
        }
    }
}

//MARK: - Collection Data
extension DetailAlbumView: SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading || detailAlbumViewModel.numberOfPhotos > 0 {
            collectionView.removeEmptyView()
        } else {
            collectionView.setEmptyView(img: .imgAlbum, title: "Photo is empty", desc: "")
        }
        
        return detailAlbumViewModel.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionPhotoCell.identifier, for: indexPath) as? CollectionPhotoCell else {
            fatalError("Cannot found collection cell")
        }
        
        let photo = detailAlbumViewModel.viewModelPhoto(index: indexPath.row)
        cell.setValue(photoUrl: photo?.thumbnail ?? "")
        return cell
    }
    
    /// Handling Skeleton View
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CollectionPhotoCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: CollectionPhotoCell.identifier, for: indexPath) as? CollectionPhotoCell else {
            fatalError("Cannot found collection cell")
        }
        return cell
    }
}

//MARK: - Collection Delegate & Delegate Flow Layout
extension DetailAlbumView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: (screenWidth/3)-16, height: 80)
    }
}


//
//  UserDetailView.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit
import SkeletonView

class UserDetailView: BaseVC {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCompanny: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var collectionAlbum: UICollectionView!
    
    var userId = 0
    
    private let userProfileViewModel = UserProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
        setValueUser()
    }
    
    //MARK: - Configure View
    internal override func setupViews() {
        super.setupViews()
        setTitle("User Detail")
        lblName.textColor = .darkBlue
        
        setupCollectionView()
        collectionAlbum.register(CollectionAlbumCell.albumCollectionNib(), forCellWithReuseIdentifier: CollectionAlbumCell.identifier)
        collectionAlbum.delegate = self
        collectionAlbum.dataSource = self
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        collectionAlbum.collectionViewLayout = layout
        collectionAlbum.frame = .zero
        collectionAlbum.backgroundColor = .bgSoftBlue
        collectionAlbum.alwaysBounceVertical = true
    }
    
    //MARK: - Populate Data  & Set Value
    private func populateData() {
        isLoading = true
        view.showAnimatedGradientSkeleton()
        userProfileViewModel.populateData(userId: userId)
        userProfileViewModel.showError = { [weak self] errorMsg in
            self?.isLoading = false
            self?.view.showToast(errorMsg)
        }
        userProfileViewModel.fetchedUSerAlbum = { [weak self] in
            self?.setValueUser()
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.collectionAlbum.reloadData()
        }
    }
    
    private func setValueUser() {
        let userTemp = userProfileViewModel.viewModelUser()
        lblName.text = userTemp?.name
        lblEmail.text = userTemp?.email
        lblAddress.text = userTemp?.address
        lblCompanny.text = userTemp?.company
    }
}

//MARK: - Collection Data
extension UserDetailView: SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading || userProfileViewModel.numberOfAlbum > 0 {
            collectionView.removeEmptyView()
        } else {
            collectionView.setEmptyView(img: .imgAlbum, title: "Album is empty", desc: "")
        }
        
        return userProfileViewModel.numberOfAlbum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionAlbumCell.identifier, for: indexPath) as? CollectionAlbumCell else {
            fatalError("Cannot found collection cell")
        }
        
        let album = userProfileViewModel.viewModelAlbum(index: indexPath.row)
        cell.setValue(albumName: album?.title ?? "")
        return cell
    }
    
    /// Handling Skeleton View
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CollectionAlbumCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: CollectionAlbumCell.identifier, for: indexPath) as? CollectionAlbumCell else {
            fatalError("Cannot found collection cell")
        }
        return cell
    }
}

//MARK: - Collection Delegate & Delegate Flow Layout
extension UserDetailView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = userProfileViewModel.viewModelAlbum(index: indexPath.item)
        toDetailAlbum(albumId: album?.id ?? 0, albumName: album?.title ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: (screenWidth/3)-16, height: 200)
    }
    
    /// Route to Detail Album
    private func toDetailAlbum(albumId: Int, albumName: String) {
        let photoView = DetailAlbumView()
        photoView.albumId = albumId
        photoView.setTitle(albumName)
        self.navigationController?.pushViewController(photoView, animated: true)
    }
}

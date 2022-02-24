//
//  DetailAlbumViewModel.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import Foundation

class DetailAlbumViewModel {
    
    private var listPhotos = [Photo]()
    
    var showError: SelectionStringClosure?
    var fetchedPhotos: SelectionClosure?
    
    var numberOfPhotos: Int {
        return listPhotos.count
    }
    
    func viewModelPhoto(index: Int) -> PhotoViewModel? {
        guard index < listPhotos.count else { return nil }
        return PhotoViewModel(listPhotos[index])
    }
    
    func populateData(albumId: Int) {
        fetchPhotos(albumId: albumId)
    }
    
    private func fetchPhotos(albumId: Int) {
        Network.request(.getPhotos(albumId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listPhoto = try? JSONDecoder().decode([Photo].self, from: resData) {
                    self?.listPhotos = listPhoto
                    self?.fetchedPhotos?()
                }
            }
        }
    }
}

//
//  UserProfileViewModel.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import Foundation

class UserProfileViewModel {
    
    private var userDetail: User?
    private var listAlbums = [Album]()
    
    var showError: SelectionStringClosure?
    var fetchedUSerAlbum: SelectionClosure?
    
    var numberOfAlbum: Int {
        return listAlbums.count
    }
    
    func viewModelAlbum(index: Int) -> AlbumViewModel? {
        guard index < listAlbums.count else { return nil }
        return AlbumViewModel(listAlbums[index])
    }
    
    func viewModelUser() -> UserViewModel? {
        guard userDetail != nil else { return nil }
        return UserViewModel(userDetail)
    }
    
    func populateData(userId: Int) {
        fetchUserDetail(userId: userId)
    }
    
    /// Get user detail
    private func fetchUserDetail(userId: Int) {
        Network.request(.detailUser(userId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let user = try? JSONDecoder().decode(User.self, from: resData) {
                    self?.userDetail = user
                    self?.fetchAllAlbums(userId: userId)
                }
            }
        }
    }
    
    /// Get list all album user
    private func fetchAllAlbums(userId: Int) {
        Network.request(.getAlbum(userId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listAlbum = try? JSONDecoder().decode([Album].self, from: resData) {
                    self?.listAlbums = listAlbum
                    self?.fetchedUSerAlbum?()
                }
            }
        }
    }
}

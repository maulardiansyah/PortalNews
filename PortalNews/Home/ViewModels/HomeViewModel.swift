//
//  HomeViewModel.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import Foundation

class HomeViewModel {
    
    private var postNews = [Post]() /// variable to store every post by pagination case
    private var postComment = [Int]()
    
    private var allUsers = [User]()
    
    private var allPostNews = [Post]() /// vartiable temp to store all post
    
    private var currentIndexPagination = 9 /// init first index until 9 for first time load post
    
    var showError: SelectionStringClosure?
    var fetchedPost: SelectionClosure?
    
    var numberOfPost: Int {
        return postNews.count
    }
    
    func viewModelPost(index: Int) -> PostViewModel? {
        guard index < postNews.count else { return nil }
        return PostViewModel(postNews[index])
    }
    
    func getCommentCount(index: Int) -> Int {
        if index < postComment.count {
            return postComment[index]
        }
        return 0
    }
    
    func viewModelUser(userId: Int) -> UserViewModel? {
        let filter = allUsers.filter { $0.id == userId }
        guard filter.count > 0 else { return nil }
        return UserViewModel(filter.first)
    }
    
    func populatePost() {
        fetchUser()
    }
    
    func loadMorePost() {
        let startIndex = currentIndexPagination + 1
        currentIndexPagination += 10
        
        guard startIndex < allPostNews.count && currentIndexPagination < allPostNews.count else { return }
        let arraySlice = allPostNews[startIndex...currentIndexPagination]
        postNews.append(contentsOf: arraySlice)
        
        for index in startIndex..<postNews.count {
            fetchComment(postId: postNews[index].id ?? 0)
        }
    }
    
    ///  Get all user to get data name and company
    private func fetchUser() {
        Network.request(.getAllUser) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listUser = try? JSONDecoder().decode([User].self, from: resData) {
                    self?.allUsers = listUser
                    self?.fetchPost()
                    self?.populateComment()
                }
            }
        }
    }
    
    /// Get all post data
    private func fetchPost() {
        Network.request(.getAllPost) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listPost = try? JSONDecoder().decode([Post].self, from: resData) {
                    self?.allPostNews = listPost
                    let slicePost = listPost[0...self!.currentIndexPagination]
                    self?.postNews.append(contentsOf: slicePost)
                    self?.populateComment()
                }
            }
        }
    }
    
    /// Get all comment every post id to get commennt count
    private func populateComment() {
        for postNews in postNews {
            fetchComment(postId: postNews.id ?? 0)
        }
    }
    
    private func fetchComment(postId: Int) {
        Network.request(.getAllCommentPost(postId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listComment = try? JSONDecoder().decode([PostComment].self, from: resData) {
                    self?.postComment.append(listComment.count)
                    let postComment = self?.postComment.count ?? 0
                    guard postComment == self!.currentIndexPagination + 1 else { return }
                    self?.fetchedPost?()
                }
            }
        }
    }
    
}

//
//  ServicesPath.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

extension Services {
    
    var path: String {
        switch self {
            
        /// Post
        case .getAllPost:
            return "/posts"
        case .detailPost(let postId):
            return "/posts/\(postId)"
        case .getAllCommentPost(let postId):
            return "/posts/\(postId)/comments"
            
        /// User
        case .detailUser(let userId):
            return "/users/\(userId)"
            
        /// Album/Photos
        case .getAlbum(let userId):
            return "/users/\(userId)/albums"
        case .getPhotos(let albumId):
            return "/albums/\(albumId)/photos"
        }
    }
}

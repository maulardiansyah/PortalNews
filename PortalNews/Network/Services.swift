//
//  Services.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

enum Services {
    
    /// Post
    case getAllPost
    case detailPost(_ postId: Int)
    case getAllCommentPost(_ postId: Int)
    
    /// User
    case getAllUser
    case detailUser(_ userId: Int)
    
    /// Album/Image
    case getAlbum(_ userId: Int)
    case getPhotos(_ albumId: Int)
}

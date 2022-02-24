//
//  AlbumPhotoViewModel.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import Foundation

class AlbumViewModel {
    
    private var album: Album?
    
    init(_ album: Album?) {
        self.album = album
    }
    
    var userId: Int {
        return album?.userId ?? 0
    }
    
    var id: Int {
        return album?.id ?? 0
    }
    
    var title: String {
        return album?.title ?? ""
    }
}

class PhotoViewModel {
    
    private var photo: Photo?
    
    init(_ photo: Photo?) {
        self.photo = photo
    }
    
    var albumId: Int {
        return photo?.albumId ?? 0
    }
    
    var id: Int {
        return photo?.id ?? 0
    }
    
    var title: String {
        return photo?.title ?? ""
    }
    
    var thumbnail: String {
        return photo?.thumbnailUrl ?? ""
    }
    
    var photoDetail: String {
        return photo?.url ?? ""
    }
}

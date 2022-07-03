//
//  StorageManager.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import FirebaseStorage

public struct UserPost {
    let postType: UserPostType
}

public enum UserPostType {
    case photo, video
}

public enum IGStorageManagerError: Error {
    case failedToDownload
}

/// Firebase StorageManager
public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    //MARK: - Public
    
    public func uploadUserPhotoPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
    
}

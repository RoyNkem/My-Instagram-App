//
//  StorageManager.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import FirebaseStorage
import FirebaseStorageInternal
import FirebaseAuth

/// Firebase StorageManager
public class StorageManager: ObservableObject {
    
//    var userStorage: StorageReference!
    
    static let shared = StorageManager()
    
    private var bucket = Storage.storage().reference()
    
    //MARK: - Public
    //Upload new post
    public func uploadUserPhotoPost(with model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let storage = bucket.storage.reference(forURL: "gs://instagram-44ca4.appspot.com")
        
//        bucket = storage.child(model.identifier)
    }
    
    //Upload or change user profile photo
    public func uploadUserProfileImage(with image: UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let imageRef = bucket.child("user/profilePhoto/\(uid).png") //creating path name for storing uploaded photo
        
        guard let imageData = image.pngData() else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        imageRef.putData(imageData,
                         metadata: metadata,
                         completion: {_, error in
            guard error == nil else {
                //fail
                print("failed to upload")
                return
            }
            //success
            imageRef.downloadURL { url, error in
                if error == nil {
                    completion(url)
                }
            }
            print("Download URL: \(imageRef)")
        })
    }
    
    //download image from storage
    public func downloadImage(with url: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(url).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            
            completion(.success(url))
            let urlString = url.absoluteString
            print("Download URL: \(urlString)")
            UserDefaults.standard.set(urlString, forKey: "url")
        }
    }
    
}

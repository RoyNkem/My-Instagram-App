//
//  Models.swift
//  Instagram
//
//  Created by Roy Aiyetin on 06/07/2022.
//

import Foundation

///Represent a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //either photo or video Url
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
    let owner: User
}

enum Gender {
    case male, female, other
}

struct UserCount {
    let following: Int
    let followers: Int
    let posts: Int
}

///Represent a user
struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthday: Date
    let profilePhoto: URL
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

///Represent a user comment
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public enum IGStorageManagerError: Error {
    case failedToDownload
}

//
//  ProfileHeaderViewModel.swift
//  Instagram
//
//  Created by Victoria Nosik on 29/03/2022.
//

import Foundation

enum ProfileButtonType {
    case edit
    case follow(isFollowing: Bool)
}

struct ProfileHeaderViewModel {
    let profilePictureUrl: URL?
    let followerCount: Int
    let followingCount: Int
    let postsCount: Int
    let buttonType: ProfileButtonType
    let name: String?
    let bio: String?
    
}

//
//  Notification.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import Foundation

struct IGNotification: Codable {
    let notificationType: Int // 1:Like, 2: Comment, 3: Follow
    let profilePictureUrl: String
    let username: String
//    Follow/Unfollow
    let isFollowing: Bool?
//    Like/Comment
    let postId: String?
    let postUrl: String?
}

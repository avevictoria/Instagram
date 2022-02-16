//
//  NotificationCellViewModel.swift
//  Instagram
//
//  Created by Victoria Nosik on 16.02.2022.
//

import Foundation

struct LikeNotificationCellViewModel {
    let username: String
    let profilePictureUrl: URL
    let postUrl: URL
}
struct FollowNotificationCellViewModel {
    let username: String
    let profilePictureUrl: URL
    let isCurrentUserFollowing: Bool
}
struct CommentNotificationCellViewModel {
    let username: String
    let profilePictureUrl: URL
    let postUrl: URL
}
 

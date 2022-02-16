//
//  NotificationCellType.swift
//  Instagram
//
//  Created by Victoria Nosik on 16.02.2022.
//

import Foundation

enum NotificationCellType {
    case follow(viewModel: FollowNotificationCellViewModel)
    case like(viewModel: LikeNotificationCellViewModel)
    case comment(viewModel: CommentNotificationCellViewModel)
}

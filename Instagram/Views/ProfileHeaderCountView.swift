//
//  ProfileeaderCountView.swift
//  Instagram
//
//  Created by Victoria Nosik on 30/03/2022.
//

import UIKit

protocol ProfileHeaderCountViewDelegate: AnyObject {
    func profileHeaderCountViewDidTapFollowers(_ containerView: ProfileHeaderCountView)
    func profileHeaderCountViewDidTapFollowing(_ containerView: ProfileHeaderCountView)
//    ??? why posts
    func profileHeaderCountViewDidTapPosts(_ containerView: ProfileHeaderCountView)
    func profileHeaderCountViewDidTapEditProfile(_ containerView: ProfileHeaderCountView)
    func profileHeaderCountViewDidTapFollow(_ containerView: ProfileHeaderCountView)
    func profileHeaderCountViewDidTapUnfollow(_ containerView: ProfileHeaderCountView)
}

class ProfileHeaderCountView: UIView {
    
    weak var delegate: ProfileHeaderCountViewDelegate?
    private var action = ProfileButtonType.edit
    
    private let followerCountButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.setTitle("-", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        return button
    }()
    
    private let followingCountButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.setTitle("-", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        return button
    }()
    
    private let postsCountButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.setTitle("-", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        return button
    }()
    
    private let actionButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(followerCountButton)
        addSubview(followingCountButton)
        addSubview(postsCountButton)
        addSubview(actionButton)
        addActions()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func addActions() {
        followerCountButton.addTarget(self, action: #selector(didTapFollowers), for: .touchUpInside)
        followingCountButton.addTarget(self, action: #selector(didTapFollowing), for: .touchUpInside)
        postsCountButton.addTarget(self, action: #selector(didTapPosts), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
//    Actions
    
    @objc func didTapFollowers() {
        delegate?.profileHeaderCountViewDidTapFollowers(self)
    }
    @objc func didTapFollowing() {
        delegate?.profileHeaderCountViewDidTapFollowing(self)
    }
    @objc func didTapPosts() {
        delegate?.profileHeaderCountViewDidTapPosts(self)
    }
    @objc func didTapActionButton() {
        switch action {
        case .edit:
            delegate?.profileHeaderCountViewDidTapEditProfile(self)
        case .follow(let isFollowing):
            if isFollowing {
                delegate?.profileHeaderCountViewDidTapUnfollow(self)
            } else {
                delegate?.profileHeaderCountViewDidTapFollow(self)
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWidth: CGFloat = (width-15)/3
        followerCountButton.frame = CGRect(x: 5, y: 5, width: buttonWidth, height: height/2)
        followingCountButton.frame = CGRect(x: followerCountButton.right+5, y: 5, width: buttonWidth, height: height/2)
        postsCountButton.frame = CGRect(x: followingCountButton.right+5, y: 5, width: buttonWidth, height: height/2)
        actionButton.frame = CGRect(x: 5, y: height-44, width: width-10, height: 40)
        
    }
    func configure(with viewModel: ProfileHeaderCountViewModel) {
        
        followerCountButton.setTitle("\(viewModel.followerCount)\nFollowers", for: .normal)
        followingCountButton.setTitle("\(viewModel.followingCount)\nFollowing", for: .normal)
        postsCountButton.setTitle("\(viewModel.postsCount)\nPosts", for: .normal)
        
        self.action = viewModel.actionType
        switch viewModel.actionType {
        case .edit:
            actionButton.backgroundColor = .systemBackground
            actionButton.setTitle("Edit Profile", for: .normal)
            actionButton.setTitleColor(.label, for: .normal)
            actionButton.layer.borderWidth = 0.5
            actionButton.layer.borderColor = UIColor.tertiaryLabel.cgColor
            
        case .follow(let isFollowing):
            actionButton.backgroundColor = isFollowing ? .systemBackground : .systemBlue
            actionButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
            actionButton.setTitleColor(isFollowing ? .label : .white, for: .normal)
            
            if isFollowing {
                actionButton.layer.borderWidth = 0.5
                actionButton.layer.borderColor = UIColor.tertiaryLabel.cgColor
            } else {
                actionButton.layer.borderWidth = 0
            }
        }
    }
}

//
//  FollowTableViewCell.swift
//  Instagram
//
//  Created by Victoria Nosik on 11.02.2022.
//

import UIKit

protocol FollowNotificationTableViewCellDelegate: AnyObject {
    func followNotificationTableViewCell(_ cell: FollowNotificationTableViewCell,
                                         didTapButton isFollowing: Bool,
                                         viewModel: FollowNotificationCellViewModel)
}

class FollowNotificationTableViewCell: UITableViewCell {

    static let identifier = "FollowNotificationTableViewCell"
    
    weak var delegate: FollowNotificationTableViewCellDelegate?
    
    private var viewModel: FollowNotificationCellViewModel?
    
    private var isFollowing = false
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profilePictureImageView)
        contentView.addSubview(followButton)
        contentView.addSubview(dateLabel)
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    
    @objc func didTapFollow() {
        guard let vm = viewModel else {
            return
        }
        delegate?.followNotificationTableViewCell(self, didTapButton: !isFollowing, viewModel: vm)
        self.isFollowing = !isFollowing
        updateButton()
    }
    
    private func updateButton() {
        followButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
        followButton.backgroundColor = isFollowing ? .tertiarySystemBackground : .systemBlue
        followButton.setTitleColor(isFollowing ? .label : .white, for: .normal)
        if isFollowing {
            followButton.layer.borderWidth = 0.5
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height/1.5
        profilePictureImageView.frame = CGRect(x: 10, y: (contentView.height-imageSize)/2, width: imageSize, height: imageSize)
        profilePictureImageView.layer.cornerRadius = imageSize/2
        followButton.sizeToFit()
        
        let buttonWidth: CGFloat = max(followButton.width, 75)
        
        followButton.frame = CGRect(
            x: contentView.width-buttonWidth-24,
            y: (contentView.height - followButton.height)/2,
            width: buttonWidth + 14,
            height: followButton.height)
        let labelSize = label.sizeThatFits(CGSize(
            width: contentView.width-profilePictureImageView.width-buttonWidth-44,
            height: contentView.height))
        label.frame = CGRect(
            x: profilePictureImageView.right+10,
            y: 0,
            width: labelSize.width,
            height: contentView.height-dateLabel.height)
        dateLabel.sizeToFit()
        dateLabel.frame = CGRect(
            x: profilePictureImageView.right+10,
            y: contentView.height-dateLabel.height-2,
            width: dateLabel.width,
            height: dateLabel.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        profilePictureImageView.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        dateLabel.text = nil
    }
    
    public func configure(with viewModel: FollowNotificationCellViewModel){
        self.viewModel = viewModel
        label.text = viewModel.username + " started following you."
        profilePictureImageView.sd_setImage(with: viewModel.profilePictureUrl, completed: nil)
        isFollowing = viewModel.isCurrentUserFollowing
        updateButton()
        dateLabel.text = viewModel.date
    }
}

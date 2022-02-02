//
//  PostLikesCollectionViewCell.swift
//  Instagram
//
//  Created by Victoria Nosik on 28.01.2022.
//

import UIKit

protocol PostLikesCollectionViewCellDelegate: AnyObject {
    func PostLikesCollectionViewCellDidTapLikes(_ cell: PostLikesCollectionViewCell)
}

class PostLikesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostLikesCollectionViewCell"
    
    weak var delegate: PostLikesCollectionViewCellDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor =  .systemBackground
        contentView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapLikes))
        label.addGestureRecognizer(tap)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapLikes() {
        delegate?.PostLikesCollectionViewCellDidTapLikes(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.width-12, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with viewModel: PostLikesCollectionViewCellViewModel) {
        let users = viewModel.likers
        label.text = "\(users.count) Likes"
        
        
    }
}

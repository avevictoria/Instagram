//
//  PostCollectionViewCell.swift
//  Instagram
//
//  Created by Victoria Nosik on 28.01.2022.
//

import UIKit

protocol PostCollectionViewCellDelegate: AnyObject {
    func PostCollectionViewCellDidTapLike(_ cell: PostCollectionViewCell)
}

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    weak var delegate: PostCollectionViewCellDelegate?
    
    private let heartImageView: UIImageView = {
        let image = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        let heartImageView = UIImageView(image: image)
        heartImageView.isHidden = true
        heartImageView.tintColor = .white
        heartImageView.alpha = 0
        return heartImageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor =  .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(heartImageView)
        let tap  = UITapGestureRecognizer(target: self, action: #selector(didTapLike))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapLike() {
        heartImageView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.heartImageView.alpha = 1
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.4) {
                    self.heartImageView.alpha = 0
                } completion: { done in
                    if done {
                        self.heartImageView.isHidden = true
                    }
                }
            }
        }
        delegate?.PostCollectionViewCellDidTapLike(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        let size: CGFloat = contentView.height/5
        heartImageView.frame = CGRect(x: (contentView.width - size)/2, y: (contentView.height - size)/2, width: size, height: size)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with viewModel: PostCollectionViewCellViewModel) {
        imageView.sd_setImage(with: viewModel.postUrl, completed: nil)
    }
}

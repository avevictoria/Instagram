//
//  ViewController.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    
    private var viewModels = [[HomeFeedCellType]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instagram"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchPost()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func fetchPost() {
//        mock data
        let postData: [HomeFeedCellType] = [
            .poster(
                viewModel: PosterCollectionViewCellViewModel(
                    username: "vika",
                    profilePictureURL: URL(string: "https://images.unsplash.com/photo-1568409226229-ae13c034d136?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80")!
                )
            ),
            .post(
                viewModel: PostCollectionViewCellViewModel(
                    postUrl: URL(string: "https://images.unsplash.com/photo-1564698010692-0fe284aae806?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80")!
                )
            ),
            .actions(viewModel: PostActionCollectionViewCellViewModel(isLiked: true)),
            .likeCount(viewModel: PostLikesCollectionViewCellViewModel(likers: ["kanyewest"])),
            .caption(viewModel: PostCaptionCollectionViewCellViewModel(username: "vika", caption: "this is 1st post")),
            .timestamp(viewModel: PostDateTimeCollectionViewCellViewModel(date: Date()))
            
        ]
        
        viewModels.append(postData)
        collectionView?.reloadData()
    }

    
//    CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = viewModels[indexPath.section][indexPath.row]
    
        switch cellType {
            
        case .poster(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PosterCollectionViewCell.identifier,
                for: indexPath
            ) as? PosterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            ) as? PostCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostActionsCollectionViewCell.identifier,
                for: indexPath
            ) as? PostActionsCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .likeCount(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostLikesCollectionViewCell.identifier,
                for: indexPath
            ) as? PostLikesCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .caption(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCaptionCollectionViewCell.identifier,
                for: indexPath
            ) as? PostCaptionCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .timestamp(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDateTimeCollectionViewCell.identifier,
                for: indexPath
            ) as? PostDateTimeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension HomeViewController: PostActionsCollectionViewCellDelegate {
    func PostActionsCollectionViewCellUpdateLike(_ cell: PostActionsCollectionViewCell, isLiked: Bool) {
        //        call DB to update like state

    }
    func PostActionsCollectionViewCellDidTapComment(_ cell: PostActionsCollectionViewCell) {

        let vc = PostViewController()
        vc.title = "Post"
        navigationController?.pushViewController(vc, animated: true)
    }
    func PostActionsCollectionViewCellDidTapShare(_ cell: PostActionsCollectionViewCell) {
        let vc = UIActivityViewController(activityItems: ["Sharing from Instagram"],
                                          applicationActivities: [])
        present(vc, animated: true)
    }
}

extension HomeViewController: PostCollectionViewCellDelegate {
    func PostCollectionViewCellDidTapLike(_ cell: PostCollectionViewCell) {

    }
}

extension HomeViewController: PostLikesCollectionViewCellDelegate {
    func PostLikesCollectionViewCellDidTapLikes(_ cell: PostLikesCollectionViewCell) {
        let vc = ListViewController()
        vc.title = "Liked by"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: PostCaptionCollectionViewCellDelegate {
    func PostCaptionCollectionViewCellDidTapCaption(_ cell: PostCaptionCollectionViewCell) {
        print("Caption tapped")
    }
    
    
}

extension HomeViewController: PosterCollectionViewCellDelegate {
    func PosterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell) {
        let sheet = UIAlertController(title: "Post Actions",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Share Post", style: .default, handler: { _ in
            
        }))
        sheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { _ in
                                      
        }))
        present(sheet, animated: true)
    }
    func PosterCollectionViewCellDidTapUserName(_ cell: PosterCollectionViewCell) {
        let vc = ProfileViewController(user: User(username: "vika", email: "vika@mail.com"))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    
    func configureCollectionView() {
        let sectionHeight: CGFloat = 240 + view.width
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ ->
                NSCollectionLayoutSection? in
    //            Item
    //            Cell for the poster
                let posterItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)
                    )
                )
                
    //            Cell for the post
                let postItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(1)
                    )
                )
                
    //            Actions cell
                let actionItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                
    //            Like count cell
                let likeCountItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                
    //            Captions cell
                let captionItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)
                    )
                )
                
    //            Timestamp cell
                let timestampItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)
                    )
                )
                
    //            Group
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(sectionHeight)
                    ),
                    subitems: [
                        posterItem,
                        postItem,
                        actionItem,
                        likeCountItem,
                        captionItem,
                        timestampItem
                    ]
                )
                
    //            Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
                return section
            })
        )
        
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            PosterCollectionViewCell.self,
            forCellWithReuseIdentifier: PosterCollectionViewCell.identifier
        )
        collectionView.register(
            PostCollectionViewCell.self,
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier
        )
        collectionView.register(
            PostActionsCollectionViewCell.self,
            forCellWithReuseIdentifier: PostActionsCollectionViewCell.identifier
        )
        collectionView.register(
            PostLikesCollectionViewCell.self,
            forCellWithReuseIdentifier: PostLikesCollectionViewCell.identifier
        )
        collectionView.register(
            PostCaptionCollectionViewCell.self,
            forCellWithReuseIdentifier: PostCaptionCollectionViewCell.identifier
        )
        collectionView.register(
            PostDateTimeCollectionViewCell.self,
            forCellWithReuseIdentifier: PostDateTimeCollectionViewCell.identifier
        )
        self.collectionView = collectionView
    }
}

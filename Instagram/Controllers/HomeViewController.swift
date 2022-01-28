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
                    user: "vika",
                    profilePictureURL: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.wired.com%2Fstory%2Fstay-in-the-moment-take-a-picture%2F&psig=AOvVaw1U2jBZ0mKTofSpYqhk3oHo&ust=1643458040766000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIiIvLi01PUCFQAAAAAdAAAAABAD")!
                )
            ),
            .post(
                viewModel: PostCollectionViewCellViewModel(
                    postUrl: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.wired.com%2Fstory%2Fstay-in-the-moment-take-a-picture%2F&psig=AOvVaw1U2jBZ0mKTofSpYqhk3oHo&ust=1643458040766000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIiIvLi01PUCFQAAAAAdAAAAABAD")!
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
    let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .systemPink]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = viewModels[indexPath.section][indexPath.row]
        switch cellType {
            
        case .poster(let viewModel):
            break
        case .post(let viewModel):
            break
        case .actions(let viewModel):
            break
        case .likeCount(let viewModel):
            break
        case .caption(let viewModel):
            break
        case .timestamp(let viewModel):
            break
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.backgroundColor = colors[indexPath.row]
        
        return cell
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
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell"
        )
        self.collectionView = collectionView
    }
}

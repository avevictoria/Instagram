//
//  PostViewController.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    let post: Post
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .systemBackground

    }

}

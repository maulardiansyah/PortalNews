//
//  HomeView.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit
import SkeletonView

class HomeView: BaseVC {
    
    @IBOutlet weak var tablePost: UITableView!
    
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: true)
    }
    
    //MARK: - Connfigure View
    internal override func setupViews() {
        super.setupViews()
        
        tablePost.addSubview(refreshControl)
        tablePost.contentInset = .init(top: 16, left: 0, bottom: 12, right: 0)
        tablePost.register(PostNewsTableCell.postNewsTableNib(), forCellReuseIdentifier: PostNewsTableCell.identifier)
        tablePost.delegate = self
        tablePost.dataSource = self
    }
    
    // MARK: - Populate Data
    private func fetchPost() {
        isLoading = true
        view.showGradientSkeleton()
        homeViewModel.populatePost()
        homeViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        homeViewModel.fetchedPost = { [weak self] in
            self?.isLoading = false
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.tablePost.reloadData()
        }
    }
    
    private func loadMorePost() {
        homeViewModel.loadMorePost()
        homeViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        homeViewModel.fetchedPost = { [weak self] in
            self?.tablePost.stopLoading()
            self?.tablePost.reloadData()
        }
    }
    
    override func refreshAction() {
        super.refreshAction()
        fetchPost()
    }
}

//MARK: - Table Data
extension HomeView: SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading || homeViewModel.numberOfPost > 0 {
            tableView.removeEmptyView()
        } else {
            tableView.setEmptyView(img: UIImage(), title: "Post is empty.", desc: "")
        }
        
        return homeViewModel.numberOfPost
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostNewsTableCell.identifier, for: indexPath) as? PostNewsTableCell else {
            fatalError("Cannot found table cell")
        }
        
        let post = homeViewModel.viewModelPost(index: indexPath.row)
        let commenntCount = homeViewModel.getCommentCount(index: indexPath.row)
        let user = homeViewModel.viewModelUser(userId: post?.userId ?? 0)
        
        cell.setPost(title: post?.title ?? "",
                     desc: post?.body ?? "",
                     commentCount: commenntCount)
        
        cell.setUser(name: user?.name ?? "",
                     company: user?.company ?? "")
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PostNewsTableCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = skeletonView.dequeueReusableCell(withIdentifier: PostNewsTableCell.identifier, for: indexPath) as? PostNewsTableCell else {
            fatalError("Cannot found table cell")
        }
        return cell
    }
}

// MARK: - Table Delegate
extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard tableView == tablePost else  { return }
        guard homeViewModel.numberOfPost > 0 else { return }
        tableView.addLoading(indexPath) { [weak self] in
            self?.loadMorePost()
        }
    }
}

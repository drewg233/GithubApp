//
//  ViewController.swift
//  Github
//
//  Created by Andrew Garcia on 3/9/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTypeSegmentedControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constant.Nib.gitRepoTableViewCell, bundle: nil), forCellReuseIdentifier: Constant.ReuseId.gitRepoTableViewCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func setupView() {
        // Nav Bar
        self.title = "GitHub Repos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        // Segmented Controller
        let font = UIFont.systemFont(ofSize: 15, weight: .bold)
        searchTypeSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let searchText = searchTextField.text else {
            return
        }
        
        let searchType: SearchType = searchTypeSegmentedControl.selectedSegmentIndex == 0 ? .username : .organization
        
        APIShared.search(by: searchType, for: searchText) { (error) in
            if let errorMessage = error {
                // Show error message
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIShared.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ReuseId.gitRepoTableViewCell) as? GitRepoTableViewCell {
            let gitRepo = APIShared.searchResults[indexPath.row]
            cell.gitRepo = gitRepo
            
            return cell
        }
        
        return UITableViewCell()
    }
}

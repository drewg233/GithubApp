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
    
    var selectedRepo: GitRepo?
    let loadingAlert = UIAlertController(title: nil, message: "Please wait..", preferredStyle: .alert)
    
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
        
        self.setBusyState(loading: true) {
            APIShared.search(by: searchType, for: searchText) { (error) in
                self.setBusyState(loading: false, completion: {
                    DispatchQueue.main.async {
                        if let errorMessage = error {
                            // Show error message
                            APIShared.searchResults = []
                            self.showError(error: errorMessage)
                        }
                        
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    func setBusyState(loading: Bool, completion: @escaping () -> ()) {
        if loading {
            DispatchQueue.main.async {
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                loadingIndicator.startAnimating();
                
                self.loadingAlert.view.addSubview(loadingIndicator)
                self.present(self.loadingAlert, animated: true, completion: {
                    completion()
                })
            }
        } else {
            DispatchQueue.main.async {
                self.loadingAlert.dismiss(animated: false, completion: {
                    completion()
                })
            }
        }
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constant.Segue.goToDetails) {
            let vc = segue.destination as? DetailViewController
            vc?.gitRepo = self.selectedRepo
        }
    }
}

extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return APIShared.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIShared.searchResults[section].repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ReuseId.gitRepoTableViewCell) as? GitRepoTableViewCell {
            let gitRepo = APIShared.searchResults[indexPath.section].repos[indexPath.row]
            cell.gitRepo = gitRepo
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedRepo: GitRepo = APIShared.searchResults[indexPath.section].repos[indexPath.row] {
            self.selectedRepo = selectedRepo
            self.performSegue(withIdentifier: Constant.Segue.goToDetails, sender: nil)
        }
    }
}

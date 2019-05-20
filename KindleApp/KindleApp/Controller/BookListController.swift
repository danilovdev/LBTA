//
//  ViewController.swift
//  KindleApp
//
//  Created by Alexey Danilov on 5/18/19.
//  Copyright © 2019 EDEN. All rights reserved.
//

import UIKit

class BookListController: UITableViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyle()
        setupNavBarButtons()
        
        navigationItem.title = "Kindle"
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.4)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        fetchBooks()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        footerView.addSubview(segmentedControl)
        
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let gridButton = UIButton(type: .system)
        let gridImage = UIImage(named: "grid_icon")?.withRenderingMode(.alwaysTemplate)
        gridButton.tintColor = .white
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        gridButton.setImage(gridImage, for: .normal)
        
        footerView.addSubview(gridButton)
        gridButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 8).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let sortButton = UIButton(type: .system)
        let sortImage = UIImage(named: "sort_icon")?.withRenderingMode(.alwaysTemplate)
        sortButton.tintColor = .white
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.setImage(sortImage, for: .normal)
        
        footerView.addSubview(sortButton)
        sortButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupNavBarButtons() {
        let menuImage = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenuPressed))
        
        let amazonImage = UIImage(named: "amazon_icon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: amazonImage, style: .plain, target: self, action: #selector(handleAmazonPressed))
    }
    
    @objc private func handleMenuPressed() {
        print("Menu pressed")
    }
    
    @objc private func handleAmazonPressed() {
        print("Amazon pressed")
    }
    
    private func setupNavigationBarStyle() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func fetchBooks() {
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Failed to fetch external json books", error)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let bookDictionaries = json as? [[String: Any]] else { return }
                    self?.books = []
                    for bookDictionary in bookDictionaries {
                        let book = Book(dictionary: bookDictionary)
                        self?.books?.append(book)
                    }
                    // get back to the main thread
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch let jsonError {
                    print("Failed to parse json properly", jsonError)
                }
            }.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        let book = books?[indexPath.row]
        bookPagerController.book = book
        let navController = UINavigationController(rootViewController: bookPagerController)
        present(navController, animated: true, completion: nil)
    }
}


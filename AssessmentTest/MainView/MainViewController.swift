//
//  ViewController.swift
//  AssessmentTest
//
//  Created by Михаил Юранов on 02.10.2020.
//  Copyright © 2020 Михаил Юранов. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, MainViewInput {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: MainViewOutput?
    var notices: [Notices] = []
        
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.didViewReady()
    }
    
    // MARK: - Methods
    func itemsChanged() {
        tableView.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func addNoticeButtonClicked(_ sender: UIButton) {
        self.presenter?.addNoticeClicked()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notices[indexPath.row].noticeTitle
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectNotice(notices[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.presenter?.didRemoveNotice(notices[indexPath.row])
    }
}


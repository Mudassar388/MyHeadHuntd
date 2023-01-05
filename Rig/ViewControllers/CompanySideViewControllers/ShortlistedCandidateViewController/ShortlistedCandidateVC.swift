//
//  ShortlistedCandidateVC.swift
//  Rig
//
//  Created by Ale on 9/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class ShortlistedCandidateVC: UIViewController {
    //MARK:- Variables
    var searchResults: [Serchresult]?
    
    // MARK: - IBOutlets

    @IBOutlet var shortlistedCandidateTableview: UITableView!

    // MARK: - View Controller Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        // Do any additional setup after loading the view.
    }

    // MARK: - Custom Methods

    func registerXib() {
        shortlistedCandidateTableview.register(UINib(nibName: "ShortlistCandidateCell", bundle: nil), forCellReuseIdentifier: "ShortlistCandidateCell")
    }

    // MARK: - IBActions

    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Tableview delegate methods

extension ShortlistedCandidateVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortlistCandidateCell", for: indexPath) as! ShortlistCandidateCell
        cell.lblName.text = (searchResults?[indexPath.row].first_name ?? "") + (searchResults?[indexPath.row].last_name ?? "")
        cell.lblDesignation.text = searchResults?[indexPath.row].designation ?? ""
        cell.profileIV.sd_setImage(with: URL(string: "\(searchResults?[indexPath.row].filesource ?? "")"), placeholderImage: UIImage(named: "logo"))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

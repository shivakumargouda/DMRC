//
//  DestinationViewController.swift
//  DMRC
//
//  Created by shivakumargouda patil on 23/11/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class DestinationViewController: UIViewController {
    
    var sourceStaion = String()
    
    private let DestinationCellReuseIdentifier = "DestinationView"
    
    let destinationStations = [ "Karol Bagh",
                                "Jhande Wallan",
                                "RK Ashram",
                                "Rajiv Chowk",
                                "Barkah Ambha",
                                "Mandi House",
                                "New Delhi",
                                "Patel Chowk",
                                "INA",
                                "Okhla"
         ]

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: DestinationCellReuseIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Station"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        setupTableView()
    }

    func setupTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

extension DestinationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinationStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DestinationCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = destinationStations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let confirmTripVC = ConfirmTripViewController()
        confirmTripVC.sourceStation = sourceStaion
        confirmTripVC.destinationStaion = destinationStations[indexPath.row]
        self.navigationController?.pushViewController(confirmTripVC, animated: true)
    }
    
}

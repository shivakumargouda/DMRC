//
//  SourceViewController.swift
//  DMRC
//
//  Created by shivakumargouda patil on 23/11/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import Foundation
import UIKit

class SourceViewController: UIViewController {
    
    private let SourceCellReuseIdentifier = "CellView"

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: SourceCellReuseIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "From Station"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        setupTableView()
        
        
        let dungeon = AdjacencyList<String>()

            //===== Blew line ===========
            let karolBagh = dungeon.createVertex(data: "KarolBagh")
            let jhandeWallan = dungeon.createVertex(data: "jhandeWallan")
            let rKAshram = dungeon.createVertex(data: "RKAshram")
            let rajivChowk = dungeon.createVertex(data: "RajivChowk")
            let barkahAmbha = dungeon.createVertex(data: "BarkahAmbha")
            let mandiHouse = dungeon.createVertex(data: "MandiHouse")

            //===== Yellow line ===========
            let newDelhi = dungeon.createVertex(data: "newDelhi")
            let patelChowk = dungeon.createVertex(data: "patelChowk")
            let iNA = dungeon.createVertex(data: "INA")

            //===== Green line ===========
            let oKHLA = dungeon.createVertex(data: "Okhla")

            dungeon.add(.undirected, from: karolBagh, to: jhandeWallan, weight: 2)
            dungeon.add(.undirected, from: jhandeWallan, to: rKAshram, weight: 2)
            dungeon.add(.undirected, from: rKAshram, to: rajivChowk, weight: 5)
            dungeon.add(.undirected, from: rajivChowk, to: barkahAmbha, weight: 5)
            dungeon.add(.undirected, from: barkahAmbha, to: mandiHouse, weight: 2)

            //===== Yellow line ===========
            dungeon.add(.undirected, from: rajivChowk, to: newDelhi, weight: 5)
            dungeon.add(.undirected, from: rajivChowk, to: patelChowk, weight: 5)
            dungeon.add(.undirected, from: patelChowk, to: iNA, weight: 2)

            //===== Green line ===========
            dungeon.add(.undirected, from: mandiHouse, to: oKHLA, weight: 5)

            dungeon.description

            if let edges = dungeon.breadthFirstSearch(from: karolBagh, to: oKHLA) {
                print(edges.count)
                
                for edge in edges {
                print("\(edge.source) -> \(edge.destination), \(String(describing: edge.weight))")
              }
            }
    }

    
    func setupTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

extension SourceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SourceCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
}

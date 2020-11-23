//
//  ViewController.swift
//  DMRC
//
//  Created by shivakumargouda patil on 23/11/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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


}


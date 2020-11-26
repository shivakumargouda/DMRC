//
//  ConfirmTripViewController.swift
//  DMRC
//
//  Created by shivakumargouda patil on 23/11/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import Foundation
import UIKit

class ConfirmTripViewController: UIViewController {

    var sourceStation = String()
    var destinationStaion = String()
    
    var routeMap = String()
    var ticketFare : Double = 0.0
    
    lazy var tickeFareLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var routeLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Confirm Trip"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        setupDRMC()
        setupTickeFareLable()
        setupRouteLable()
    }
    
    func setupTickeFareLable() {
        tickeFareLable.text = String(ticketFare)
        self.view.addSubview(tickeFareLable)
        tickeFareLable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tickeFareLable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tickeFareLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tickeFareLable.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    
    func setupRouteLable() {
        routeLable.text = routeMap
        self.view.addSubview(routeLable)
        routeLable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        routeLable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        routeLable.topAnchor.constraint(equalTo: self.tickeFareLable.bottomAnchor).isActive = true
        routeLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupDRMC() {
        
        let dMRC = AdjacencyList<String>()
        //===== Blue line ===========
        let karolBagh = dMRC.createVertex(data: "Karol Bagh", isInterchangeVertex: false)
        let jhandeWallan = dMRC.createVertex(data: "Jhande Wallan", isInterchangeVertex: false)
        let rKAshram = dMRC.createVertex(data: "RK Ashram", isInterchangeVertex: false)
        let rajivChowk = dMRC.createVertex(data: "Rajiv Chowk", isInterchangeVertex: true)
        let barkahAmbha = dMRC.createVertex(data: "Barkah Ambha", isInterchangeVertex: false)
        let mandiHouse = dMRC.createVertex(data: "Mandi House", isInterchangeVertex: true)
        //===== Yellow line ===========
        let newDelhi = dMRC.createVertex(data: "New Delhi", isInterchangeVertex: false)
        let patelChowk = dMRC.createVertex(data: "Patel Chowk", isInterchangeVertex: false)
        let iNA = dMRC.createVertex(data: "INA", isInterchangeVertex: false)
        //===== Green line ===========
        let oKHLA = dMRC.createVertex(data: "Okhla", isInterchangeVertex: false)
        
        //===== Blue line ===========
        dMRC.add(.undirected, from: karolBagh, to: jhandeWallan, weight: 0)
        dMRC.add(.undirected, from: jhandeWallan, to: rKAshram, weight: 0)
        dMRC.add(.undirected, from: rKAshram, to: rajivChowk, weight: 0)
        dMRC.add(.undirected, from: rajivChowk, to: barkahAmbha, weight: 0)
        dMRC.add(.undirected, from: barkahAmbha, to: mandiHouse, weight: 0)
        //===== Yellow line ===========
        dMRC.add(.undirected, from: rajivChowk, to: newDelhi, weight: 0)
        dMRC.add(.undirected, from: rajivChowk, to: patelChowk, weight: 0)
        dMRC.add(.undirected, from: patelChowk, to: iNA, weight: 0)
        //===== Green line ===========
        dMRC.add(.undirected, from: mandiHouse, to: oKHLA, weight: 0)
        
        //dungeon.description
        
        let sourceStation = dMRC.vertexFor(station:self.sourceStation)
        let destinationStation = dMRC.vertexFor(station: self.destinationStaion)
        
    
        if let edges = dMRC.breadthFirstSearch(from: sourceStation, to: destinationStation) {
            
            var stations = [Vertex<String>]()
            
            for (index, edge) in edges.enumerated() {
                if index == 0 {
                    stations.append(edge.source)
                    stations.append(edge.destination)
                }
                else {
                    stations.append(edge.destination)
                }
            }
            
            let interchangeStations = stations.filter { $0.isInterchangeVertex }
            
            ticketFare = (Double(stations.count) * 2.0 + Double(interchangeStations.count) * 3.0)
            
            routeMap = stations.reduce("", { x, y in
                x.description + y.description + "\n"
            })
        }
    }
}

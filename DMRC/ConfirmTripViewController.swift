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
    
    lazy var ticketFareLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = String(ticketFare)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var routeLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = routeMap
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip details"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        setupAdjacencyList()
        setupTickeFareLable()
        setupRouteLable()
    }
    
    func setupTickeFareLable() {
        self.view.addSubview(ticketFareLabel)
        ticketFareLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        ticketFareLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        ticketFareLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ticketFareLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    
    func setupRouteLable() {
        self.view.addSubview(routeLable)
        routeLable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        routeLable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        routeLable.topAnchor.constraint(equalTo: self.ticketFareLabel.bottomAnchor).isActive = true
        routeLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupAdjacencyList() {
        let adjacencyList = AdjacencyList<String>()
        //===== Blue line ===========
        let karolBagh = adjacencyList.createVertex(data: "Karol Bagh", isInterchangeVertex: false)
        let jhandeWallan = adjacencyList.createVertex(data: "Jhande Wallan", isInterchangeVertex: false)
        let rKAshram = adjacencyList.createVertex(data: "RK Ashram", isInterchangeVertex: false)
        let rajivChowk = adjacencyList.createVertex(data: "Rajiv Chowk", isInterchangeVertex: true)
        let barkahAmbha = adjacencyList.createVertex(data: "Barkah Ambha", isInterchangeVertex: false)
        let mandiHouse = adjacencyList.createVertex(data: "Mandi House", isInterchangeVertex: true)
        //===== Yellow line ===========
        let newDelhi = adjacencyList.createVertex(data: "New Delhi", isInterchangeVertex: false)
        let patelChowk = adjacencyList.createVertex(data: "Patel Chowk", isInterchangeVertex: false)
        let iNA = adjacencyList.createVertex(data: "INA", isInterchangeVertex: false)
        //===== Green line ===========
        let oKHLA = adjacencyList.createVertex(data: "Okhla", isInterchangeVertex: false)
        
        //===== Blue line ===========
        adjacencyList.add(.undirected, from: karolBagh, to: jhandeWallan, weight: 0)
        adjacencyList.add(.undirected, from: jhandeWallan, to: rKAshram, weight: 0)
        adjacencyList.add(.undirected, from: rKAshram, to: rajivChowk, weight: 0)
        adjacencyList.add(.undirected, from: rajivChowk, to: barkahAmbha, weight: 0)
        adjacencyList.add(.undirected, from: barkahAmbha, to: mandiHouse, weight: 0)
        //===== Yellow line ===========
        adjacencyList.add(.undirected, from: rajivChowk, to: newDelhi, weight: 0)
        adjacencyList.add(.undirected, from: rajivChowk, to: patelChowk, weight: 0)
        adjacencyList.add(.undirected, from: patelChowk, to: iNA, weight: 0)
        //===== Green line ===========
        adjacencyList.add(.undirected, from: mandiHouse, to: oKHLA, weight: 0)
        
        let sourceStation = adjacencyList.vertexFor(station:self.sourceStation)
        let destinationStation = adjacencyList.vertexFor(station: self.destinationStaion)
        
        if let edges = adjacencyList.breadthFirstSearch(from: sourceStation, to: destinationStation) {
            
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
            
            let interchangeStations = stations.filter { $0.isInterChangeVertex }
            ticketFare = (Double(stations.count) * 2.0 + Double(interchangeStations.count) * 3.0)
            routeMap = stations.reduce("", { x, y in
                x.description + y.description + "\n"
            })
        }
    }
}

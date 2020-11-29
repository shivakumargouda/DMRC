//
//  Dmrc.swift
//  DMRC
//
//  Created by shivakumargouda patil on 30/11/20.
//  Copyright © 2020 shivakumargouda. All rights reserved.
//

import Foundation
import UIKit

struct Dmrc {
    
    static var shared = Dmrc()
    
    var sourceStaion: String?
    var destinationStaion: String?
    fileprivate let adjacencyList = AdjacencyList<String>()
    
    private init() {
        configureAdjacencyList()
    }
    
    func configureAdjacencyList() {
        //===== Blue line ===========
        let karolBagh = adjacencyList.createVertex(data: "Karol Bagh", isInterChangeVertex: false)
        let jhandeWallan = adjacencyList.createVertex(data: "Jhande Wallan", isInterChangeVertex: false)
        let rKAshram = adjacencyList.createVertex(data: "RK Ashram", isInterChangeVertex: false)
        let rajivChowk = adjacencyList.createVertex(data: "Rajiv Chowk", isInterChangeVertex: true)
        let barkahAmbha = adjacencyList.createVertex(data: "Barkah Ambha", isInterChangeVertex: false)
        let mandiHouse = adjacencyList.createVertex(data: "Mandi House", isInterChangeVertex: true)
        
        //===== Yellow line ===========
        let newDelhi = adjacencyList.createVertex(data: "New Delhi", isInterChangeVertex: false)
        let patelChowk = adjacencyList.createVertex(data: "Patel Chowk", isInterChangeVertex: false)
        let iNA = adjacencyList.createVertex(data: "INA", isInterChangeVertex: false)
        
        //===== Green line ===========
        let oKHLA = adjacencyList.createVertex(data: "Okhla", isInterChangeVertex: false)
        
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
    }

    internal func allStations() -> [Vertex<String>] {
        var stations =  [Vertex<String>]()
        for (vertex, _) in adjacencyList.adjacencyDict {
            stations.append(vertex)
        }
        return stations
    }
    
    internal func destinationStations() -> [Vertex<String>] {
        guard let sourceStation = self.sourceStaion else {
            return allStations()
        }
        var destinations =  [Vertex<String>]()
        for (vertex, _) in adjacencyList.adjacencyDict {
            if vertex.description != sourceStation.description {
                destinations.append(vertex)
            }
        }
        return destinations
    }
    
    internal func travelStations() -> [Vertex<String>] {
        var stations = [Vertex<String>]()
        guard let fromStation = self.sourceStaion, let toStation = self.destinationStaion else {
            return stations
        }
        if let edges = adjacencyList.breadthFirstSearch(from: adjacencyList.vertexFor(station: fromStation), to: adjacencyList.vertexFor(station: toStation)) {
            for (index, edge) in edges.enumerated() {
                if index == 0 {
                    stations.append(edge.source)
                    stations.append(edge.destination)
                }
                else {
                    stations.append(edge.destination)
                }
            }
        }
        return stations
    }
    
    internal func calculateTicketFare() -> Double {
        var result = 0.0
        guard let _ = self.sourceStaion, let _ = self.destinationStaion else {
            return result
        }
        let stations = travelStations()
        let interchangeStations = stations.filter { $0.isInterChangeVertex }
        result = (Double(stations.count) * 2.0 + Double(interchangeStations.count) * 3.0)
        return result
    }
    
    internal func travelRouteMap() -> String {
        return travelStations().reduce("", { $0.description + $1.description + "\n" })
    }

}


extension NSMutableAttributedString {
    var fontSize:CGFloat { return 16 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

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

    lazy var tripLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ticketFareLabel: UILabel = {
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
        self.title = "Trip details"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        let shareButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(shareEticket))
        self.navigationItem.rightBarButtonItem  = shareButtonItem
        setupTripLable()
        setupTickeFareLable()
        setupRouteLable()
    }
    
    func setupTripLable() {
        self.view.addSubview(tripLabel)
        self.tripLabel.attributedText = NSMutableAttributedString().normal("Trip from ").bold(Dmrc.shared.sourceStaion!).normal(" to ").bold(Dmrc.shared.destinationStaion!)
        tripLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tripLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tripLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tripLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    func setupTickeFareLable() {
        self.view.addSubview(ticketFareLabel)
        self.ticketFareLabel.attributedText = NSMutableAttributedString().normal("Fare ").bold(String(Dmrc.shared.calculateTicketFare()))
        ticketFareLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        ticketFareLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        ticketFareLabel.topAnchor.constraint(equalTo: self.tripLabel.bottomAnchor).isActive = true
        ticketFareLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    func setupRouteLable() {
        self.view.addSubview(routeLable)
        self.routeLable.attributedText = NSMutableAttributedString().normal("Route Map \n ").bold(Dmrc.shared.travelRouteMap())
        routeLable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        routeLable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        routeLable.topAnchor.constraint(equalTo: self.ticketFareLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func shareEticket() {
        guard let fromStaion = Dmrc.shared.sourceStaion, let toStaion = Dmrc.shared.destinationStaion else { return }
        
        let tripDetails = "Trip from \(fromStaion) to \(toStaion)"
        let ticketFare = NSMutableAttributedString().normal("Fare ").bold(String(Dmrc.shared.calculateTicketFare()))
        let routeMap = "Route Map \n \(Dmrc.shared.travelRouteMap())"
        present(UIActivityViewController(activityItems:[tripDetails, "\n", ticketFare, "\n", routeMap], applicationActivities: nil), animated: true)
    }
}



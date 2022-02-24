//
//  ViewController.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

import UIKit

class MainController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewControllers = [HomeView()]
    }
}

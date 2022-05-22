//
//  ViewController.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import UIKit

class HomeViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    
    //MARK: Properties
    let vcIdentifiers = ["LocationsViewController", "AboutViewController"]


    //MARK: - ViewController lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let locationsVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
        addChild(locationsVC)
        locationsVC.view.frame = contentView.bounds
        contentView.addSubview(locationsVC.view)
        locationsVC.didMove(toParent: self)
    }
    
    //MARK: - Button actions
    @IBAction func didChangeValue(sender: UISegmentedControl)
    {
        let nextController = storyboard!.instantiateViewController(withIdentifier: vcIdentifiers[sender.selectedSegmentIndex])
        let previousController = children.last!

        previousController.willMove(toParent: nil)
        addChild(nextController)
        nextController.view.frame = previousController.view.frame

        transition(from: previousController, to: nextController, duration: 0.25, options: .transitionCrossDissolve, animations: {
        }, completion: { _ -> Void in
            previousController.removeFromParent()
            nextController.didMove(toParent: self)
        })
    }
}

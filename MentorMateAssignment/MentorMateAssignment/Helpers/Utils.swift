//
//  Utils.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import UIKit

class Utils {
    
    static func displayAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}

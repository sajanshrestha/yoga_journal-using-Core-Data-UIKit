//
//  YogaProfileViewController.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/14/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit

class YogaProfileViewController: UIViewController {
    
    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var averageDurationLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var yogaModel: YogaModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cancelButton.layer.cornerRadius = 8.0

        totalNumberLabel.text = "\(yogaModel.getTotalNumberOfYogas() ?? 0) yogas completed"
        
        let totalDurationString = yogaModel.getTotalDuration()?.getHourMinSec()
        
        totalDurationLabel.text = totalDurationString!.isEmpty ? "0s completed" : "\(totalDurationString!) completed"
        
        let averageDurationString = String(format: "%.1f", yogaModel.getAverageDuration() ?? 0.0)
        averageDurationLabel.text = "\(averageDurationString) seconds"
        
    }
    
    @IBAction func exitYogaProfile(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
 
    @IBAction func showHelpAlertForTotalNumber(_ sender: UIButton) {
        
        showAlert(message: "This represents the total number of yogas you have done so far")
    }
    
    @IBAction func showHelpAlertForTotalDuration(_ sender: UIButton) {
        
        showAlert(message: "This represents the total duration of all the yogas combined")
    }
    
    @IBAction func showHelpAlertForAverageDuration(_ sender: UIButton) {
        
        showAlert(message: "This represents the average duration of all your yogas")
    }
}


extension YogaProfileViewController {
    
    private func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true)
    }
}

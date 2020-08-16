//
//  ViewController.swift
//  Yoga Journal
//
//  Created by Sajan Shrestha on 8/13/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import UIKit
import CoreData

class YogaListViewController: UITableViewController {
    
    var coreDataStack: CoreDataStack!
    
    var yogaModel: YogaModel!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
                        
        yogaModel = YogaModel(coreDataStack: coreDataStack)
        yogaModel.delegate = self
           
        title = yogaModel.title
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        yogaModel.yogas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Yoga Row", for: indexPath)
        let yoga = yogaModel.yogas[indexPath.row]
        cell.textLabel?.text = yoga.name
        cell.detailTextLabel?.text = yoga.date?.getMediumFormatString()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            yogaModel.delete(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? YogaDetailViewController {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let yoga = yogaModel.yogas[indexPath.row]
            destination.yoga = yoga
            destination.yogaModel = yogaModel
        }
    }
    
    // MARK:- IBActions
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        presentYogaViewController()
    }
    
    @IBAction func profileIconClicked(_ sender: UIBarButtonItem) {
        
        presentProfileViewController()
    }
    
    @IBAction func trashIconClicked(_ sender: UIBarButtonItem) {
    
        showDeletionAlert()
    }
    
    @IBAction func filterButtonClicked(_ sender: UIBarButtonItem) {
        
        showFilterAlert()
    }
}


extension YogaListViewController {
    
    private func presentYogaViewController() {
        
        let addYogaViewController = AddYogaViewController()
        
        addYogaViewController.modalTransitionStyle = .flipHorizontal
        addYogaViewController.yogaModel = yogaModel
        addYogaViewController.delegate = self
        
        present(addYogaViewController, animated: true)
    }
    
    private func presentProfileViewController() {

         let yogaProfileController = YogaProfileViewController()
         
         yogaProfileController.modalTransitionStyle = .flipHorizontal
         yogaProfileController.yogaModel = yogaModel
         
         present(yogaProfileController, animated: true)
    }
    
    private func showDeletionAlert() {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete all the yogas?", preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "Ok", style: .default) { _ in

            self.yogaModel.deleteAllYogas()

            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alert.addAction(defaultAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
    private func showFilterAlert() {
        
        let alert = UIAlertController(title: nil, message: "Filter your yogas", preferredStyle: .actionSheet)
        
        let higherDurationYogasAction = UIAlertAction(title: "Show Yogas with hold duration of over a minute", style: .default) { _ in
            
            self.yogaModel.populateYogas(with: .yogasOverMinuteDuration)
            
            self.tableView.reloadData()
        }
        
        let showAllAction = UIAlertAction(title: "Show all Yogas", style: .default) { _ in
            
            self.yogaModel.populateYogas(with: .all)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(higherDurationYogasAction)
        alert.addAction(showAllAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension YogaListViewController: YogaDelegate {
    
    func didPopulateYogas() {
        tableView.reloadData()
    }
    
    
    func didAddYoga() {
        
        tableView.reloadData()
    }
}


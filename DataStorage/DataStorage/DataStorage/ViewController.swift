//
//  ViewController.swift
//  DataStorage
//
//  Created by Crisler Chee on 31/08/2017.
//  Copyright © 2017 Crisler Chee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var notes:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -IBActions
    @IBAction func showInput(_ sender: Any) {
    
        let alert = UIAlertController(title: "New Note", message: "Add a new Note", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            action in
            
            guard let textField = alert.textFields?.first, let noteToSave = textField.text else {
                return
            }
            
            self.notes.append(noteToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = notes[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}


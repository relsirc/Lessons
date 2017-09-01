//
//  ViewController.swift
//  DataStorage
//
//  Created by Crisler Chee on 31/08/2017.
//  Copyright © 2017 Crisler Chee. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class NoteModel: Object {
    dynamic var text = ""
}

class ViewController: UIViewController {

    var notes:[String] = []
    var savedNotes:[NSManagedObject] = []
    let realm = try! Realm()
    var realmNotes: Results<NoteModel> {
        get {
            return realm.objects(NoteModel.self)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
//        
//        let realm = try! Realm()
//        let note = NoteModel()
//        note.text = "hello"
//        
//        // Persist your data easily
//        try! realm.write {
//            realm.add(note)
//        }
//
//        let notes = realm.objects(NoteModel.self).filter {
//            
//        }
//        print(notes)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
//        
//        do {
//            savedNotes = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveNote(_ noteToSave: String) {
        
        let noteModal = NoteModel()
        noteModal.text = noteToSave
        
        try! realm.write {
            realm.add(noteModal)
        }
        
        // Core data
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        
//        // 1 Get Context to use core data store
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        // 2 Create a managed object and save it to context
//        let entity = NSEntityDescription.entity(forEntityName: "Note",
//                                       in: managedContext)!
//        
//        let note = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//        // 3 set the value of the object
//        note.setValue(noteToSave, forKeyPath: "text")
//        
//        // 4 try to save
//        do {
//            try managedContext.save()
//            savedNotes.append(note)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
    // MARK: -IBActions
    @IBAction func showInput(_ sender: Any) {
    
        let alert = UIAlertController(title: "New Note", message: "Add a new Note", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            action in
            
            guard let textField = alert.textFields?.first, let noteToSave = textField.text else {
                return
            }
            self.saveNote(noteToSave)
            //self.notes.append(noteToSave)
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
        return realmNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = realmNotes[indexPath.row]
        cell.textLabel?.text = note.text//note.value(forKeyPath: "text") as? String
        cell.selectionStyle = .none
        return cell
    }
}


//
//  ViewController.swift
//  NotesApp
//
//  Created by Anytimes on 9/27/17.
//  Copyright © 2017 crisler. All rights reserved.
//


import UIKit
import RealmSwift
import Swinject
import SwinjectStoryboard

//class NoteModel: Object {
//    dynamic var text = ""
//}

class ViewController: UIViewController {
    
    var notes:[Note] = []
    var dataFetcher: DataFetcher?
    /*
    let realm = try! Realm()
    var realmNotes: Results<NoteModel> {
        get {
            return realm.objects(NoteModel.self)
        }
    }*/
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        dataFetcher?.fetch(response: { (notes) in
            print(notes)
            self.notes.removeAll()
            self.notes = notes
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveNote(_ noteToSave: String) {
        /*
        let noteModal = NoteModel()
        noteModal.text = noteToSave
        
        try! realm.write {
            realm.add(noteModal)
        }
         */
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.message
        cell.selectionStyle = .none
        return cell
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        Container.loggingFunction = nil
        defaultContainer.storyboardInitCompleted(ViewController.self) { r, c in
            c.dataFetcher = r.resolve(DataFetcher.self)
        }
        defaultContainer.register(Networking.self) { _ in Network() }
        defaultContainer.register(DataFetcher.self) {
            r in
            DataFetcher(networking: r.resolve(Networking.self)!)
        }
    }
}

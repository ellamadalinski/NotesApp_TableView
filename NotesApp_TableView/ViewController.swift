//
//  ViewController.swift
//  NotesApp_TableView
//
//  Created by Ella Madalinski on 10/14/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies = ["Braveheart", "Star Wars", "Cars"]
    var selectedMovies = ""
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        if let mov = defaults.object(forKey: "myMovies"){
            movies = mov as! [String]
        }
    }


    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        defaults.set(movies, forKey: "myMovies")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //populates table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = movies[indexPath.row]
        cell.detailTextLabel?.text = "Fun"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let blah = tableView.cellForRow(at: indexPath)?.textLabel?.text{
            selectedMovies = blah
            print(selectedMovies)
        }
        
    }
    
    //delete if swipe left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @IBAction func addMovieAction(_ sender: UIBarButtonItem) {
        movies.append(textFieldOutlet.text!)
        tableViewOutlet.reloadData()
        textFieldOutlet.text = ""
    }
    
}


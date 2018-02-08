//
//  ViewController.swift
//  tasker
//
//  Created by sajad on 2/8/18.
//  Copyright © 2018 E.LAB. All rights reserved.
//

import UIKit

class toDoListViewController: UITableViewController {
    
    /// مصفوفه
    
    let itemArray = ["ابلع" ,"اضرب" ,"اشرب"] /// السوالف الي تطلع بال  table view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - tableview datasource methods:- التيبل فيو مالتك طريقه تكوينها
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    ///MARK - TableView Deleget Methods this method detect which row was selected
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) ///تطبع الكلمه الي انت واكف عليها بالتيبل فيو
        
        ///to make a mark when  we select any cell in the table view -
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        ///to remove the check box when we hit the cell again -
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }

        
        /// to remove gray highlighting when we select a cell -
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        
        
    }
    
    
    
    
    }


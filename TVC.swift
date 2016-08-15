//
//  TVC.swift
//  otratablallamada
//
//  Created by Marco Del Angel on 07/08/16.
//  Copyright © 2016 Marco Del Angel. All rights reserved.
//

import UIKit

class TVC: UITableViewController {
    
    var booksList:[Book] = booksData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Libros"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

       let ip  = booksList[indexPath.row] as Book
        
        cell.textLabel?.text = ip.titulo
        
        return cell
    }
    
// MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showBook"{
        
            if let dataViewController = segue.destinationViewController as? VCData{
                let ip = self.tableView.indexPathForSelectedRow?.row
                
                let selectedBook = booksList[ip!]
                
                print(selectedBook.autor)
                
                dataViewController.autor.text = selectedBook.autor
                
            }

            }
            
    }

    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
        if let bookDetailVC = segue.sourceViewController as? VCNew {
            
            //add the new player to the players array
            if let book = bookDetailVC.book {
                booksList.append(book)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: booksList.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
}

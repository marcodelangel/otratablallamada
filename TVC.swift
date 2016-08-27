//
//  TVC.swift
//  otratablallamada
//
//  Created by Marco Del Angel on 07/08/16.
//  Copyright © 2016 Marco Del Angel. All rights reserved.
//

import UIKit
import CoreData

class TVC: UITableViewController, VCNewDelegate {
    
    var booksList:[Book] = booksData
    var context : NSManagedObjectContext? =  nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        //Recuperación de datos
        
        let bookSaved = NSEntityDescription.entityForName("BookCD",
                                                          inManagedObjectContext: self.context!)
        let bookSavedRequest = bookSaved?.managedObjectModel.fetchRequestTemplateForName("RequestBook")
        do{
            let bookSavedEntity = try self.context?.executeFetchRequest(bookSavedRequest!)
            for bookSavedData in bookSavedEntity!{
                let titulo = bookSavedData.valueForKey("titulo") as! String
                let autor = bookSavedData.valueForKey("autor") as! String
                let portada = bookSavedData.valueForKey("portada") as! NSData
                let portadaImagen : UIImage = UIImage(data: portada)!
                booksList.append(Book(titulo: titulo, autor: autor, portada: portadaImagen))
            }
        }
        catch{
            
        }
        
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
        
        if segue.identifier == "showBook",
            let dataViewController = segue.destinationViewController as? VCData,
            let ip = self.tableView.indexPathForSelectedRow?.row {
            let selectedBook = booksList[ip]
            dataViewController.book = selectedBook
        }
    
        if segue.identifier == "addBookSegue",
            let newBookNavViewController =  segue.destinationViewController as? UINavigationController,
            let newBookViewController = newBookNavViewController.topViewController as? VCNew {
            newBookViewController.bookDelegate = self
        }
    
    }
    
    func didDownload(book: Book) {
            booksList.append(book)
            let indexPath = NSIndexPath(forRow: booksList.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
    }
}

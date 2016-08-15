//
//  VCNew.swift
//  otratablallamada
//
//  Created by Marco Del Angel on 07/08/16.
//  Copyright © 2016 Marco Del Angel. All rights reserved.
//

import UIKit

class VCNew: UIViewController, UITextFieldDelegate {
    
    var book:Book?
    
    @IBOutlet weak var isbnEntry: UITextField!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        isbnEntry.delegate = self
        isbnEntry.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelAction(){
        let vc = (storyboard?.instantiateInitialViewController())
        
        presentViewController(vc!, animated: true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        if Reachability.isConnectedToNetwork() == false {
            print("Internet connection FAILED")
            noInternetAlert()
        }else{
            
            var isbnCapturado = isbnEntry.text!
            
            if isbnCapturado.characters.count < 12 || isbnCapturado == "Ingresa el ISBN" || isbnCapturado.characters.count > 13{
                incorrectISBNCaptureAlert()
            } else {
                isbnCapturado.insert("-", atIndex: isbnCapturado.startIndex.advancedBy(3))
                isbnCapturado.insert("-", atIndex: isbnCapturado.startIndex.advancedBy(6))
                isbnCapturado.insert("-", atIndex: isbnCapturado.startIndex.advancedBy(10))
                isbnCapturado.insert("-", atIndex: isbnCapturado.endIndex.predecessor())
                
                let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbnCapturado
                let url = NSURL(string:urls)
                let dato:NSData? = NSData(contentsOfURL: url!)
                let texto = NSString(data: dato!, encoding: NSUTF8StringEncoding)
                
                if texto == "{}"{
                    noBookFoundAlert()
                    
                }else{
                    do {let json = try! NSJSONSerialization.JSONObjectWithData(dato!, options: NSJSONReadingOptions.MutableLeaves)
                        let dicc1 = json as! NSDictionary
                        let dicc2 = dicc1["ISBN:" + isbnCapturado] as! NSDictionary
                        let titulo = dicc2["title"] as! NSString as String
                        self.titulo.text = titulo
                        let array =  dicc2["authors"] as! NSMutableArray
                        let dicc3 = array.objectAtIndex(0) as! NSDictionary
                        let autores = dicc3["name"] as! NSString as String
                        self.autor.text = autores
                        if let dictionaryImages = dicc2["cover"] as! NSDictionary? {
                            let urlsImage = dictionaryImages["large"] as! NSString as String
                            let urlImage = NSURL(string: urlsImage)
                            let datosImage:NSData? = NSData(contentsOfURL: urlImage!)
                            let imageCover:UIImage = UIImage(data: datosImage!)!
                            self.portada.image = imageCover
                        }else{
                            let noCover:UIImage = UIImage(imageLiteral: "noCover.jpg")
                            self.portada.image = noCover
                        }
                    }
                    catch _{
                        
                    }
                }
            }
        }
        isbnEntry.resignFirstResponder()
        
        return true
    }
    func incorrectISBNCaptureAlert(){
        let alertEmpty = UIAlertController(title: "Mensaje",
                                           message: "Anota un ISBN de 13 numeros, sin guiones para iniciar la búsqueda",
                                           preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: UIAlertActionStyle.Default,
                                     handler: nil)
        alertEmpty.addAction(okAction)
        self.presentViewController(alertEmpty,
                                   animated: true,
                                   completion: nil)
    }
    
    func noBookFoundAlert(){
        let alertNoBook = UIAlertController(title: "Mensaje",
                                            message: "No existe el libro para el ISBN buscado",
                                            preferredStyle: UIAlertControllerStyle.Alert)
        let okActionNoBook = UIAlertAction(title: "Ok",
                                           style: UIAlertActionStyle.Default,
                                           handler: nil)
        alertNoBook.addAction(okActionNoBook)
        self.presentViewController(alertNoBook,
                                   animated: true,
                                   completion: nil)
    }
    func noInternetAlert() {
        let alert = UIAlertController (title: "Alerta",
                                       message: "No tienes Internet",
                                       preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertActionStyle.Default,
                                         handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true,
                                   completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "saveSegue" {

            book = Book(titulo: titulo.text, autor: autor.text, portada: portada.image)
        }
        
    }
   
}
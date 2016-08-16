//
//  VCData.swift
//  otratablallamada
//
//  Created by Marco Del Angel on 07/08/16.
//  Copyright © 2016 Marco Del Angel. All rights reserved.
//

import UIKit

class VCData: UIViewController {

    @IBOutlet weak var etiquetaTitulo: UILabel!
    @IBOutlet weak var etiquetaAutor: UILabel!
    @IBOutlet weak var contenedorPortada: UIImageView!
    
    var book : Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        etiquetaAutor.text = book!.autor
        etiquetaTitulo.text = book!.titulo
        contenedorPortada.image = book!.portada
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

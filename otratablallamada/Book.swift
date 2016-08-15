//
//  Book.swift
//  otratablallamada
//
//  Created by Marco Del Angel on 14/08/16.
//  Copyright © 2016 Marco Del Angel. All rights reserved.
//

import Foundation
import UIKit

struct Book {
    var titulo:String?
    var autor:String?
    var portada:UIImage?
    
    init(titulo:String?, autor:String?, portada:UIImage?){
        self.titulo = titulo
        self.autor = autor
        self.portada = portada
    }
}
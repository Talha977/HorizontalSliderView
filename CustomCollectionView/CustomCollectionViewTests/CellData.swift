//
//  CellData.swift
//  ExampleProjectFramework
//
//  Created by Talha Asif on 22/01/2023.
//

import Foundation
import UIKit

public class CellData {
    var stringCell = String()
    var imageCell = UIImage()
    
    public init(stringCell:String,imageCell:UIImage) {
        self.stringCell = stringCell
        self.imageCell = imageCell
    }
}

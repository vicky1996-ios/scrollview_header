//
//  SubCategoryTitleCollectionViewCell.swift
//  DinDinnTask
//
//  Created by Codigo Technologies on 28/03/21.
//

import UIKit

class SubCategoryTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

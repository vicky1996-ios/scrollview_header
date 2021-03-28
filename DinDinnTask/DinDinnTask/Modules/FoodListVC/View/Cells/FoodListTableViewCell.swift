//
//  FoodListTableViewCell.swift
//  DinDinnTask
//
//  Created by Codigo Technologies on 28/03/21.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var lblIngredients: UILabel!
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()


        self.btnAddToCart.layer.cornerRadius = self.btnAddToCart.frame.size.height/2
        self.btnAddToCart.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        
        self.bgView.layer.cornerRadius = 15
        self.bgView.layer.masksToBounds = true
 
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

final class ShadowWithCornerRadius: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            self.layer.cornerRadius = 20
            self.clipsToBounds = false
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 3
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}

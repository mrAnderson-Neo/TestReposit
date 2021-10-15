//
//  TableViewCell.swift
//  TheSocialNetwork
//
//  Created by Андрей Калюжный on 03.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelAge: UILabel!
    @IBOutlet var viewForShadow: UIView!
    @IBOutlet var imageViewForFoto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    override func prepareForReuse() {
        clear()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    func configure(textName: String, textAge: String, avatar: UIImage?) {
        labelName.text = textName
        labelAge.text = textAge
        imageViewForFoto.image = avatar
        
        settingTheVisualDisplay()
    }
    
    func configure(textName: String, avatar: UIImage?, changeLabelAge height: CGFloat) {
        labelName.text = textName
        imageViewForFoto.image = avatar
        self.labelAge.constraints[0].constant = height
    }
    
    private func clear() {
        self.labelName.text = ""
        self.labelAge.text = ""
        self.imageViewForFoto.image = nil
    }
    
    private func settingTheVisualDisplay() {
        self.imageViewForFoto.layer.cornerRadius = 35
        self.viewForShadow.layer.cornerRadius = 35
        self.viewForShadow.backgroundColor = .clear
        self.viewForShadow.layer.shadowColor = UIColor.black.cgColor
        self.viewForShadow.layer.shadowRadius = 10
        self.viewForShadow.layer.shadowOffset = CGSize(width: 5, height: 10)
        self.viewForShadow.layer.shadowOpacity = 1
    }
}

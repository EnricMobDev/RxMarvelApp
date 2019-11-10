//
//  CharacterListTableViewCell.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell, GetCellIdentifierProtocol {
    
    // MARK: - Constants
    private enum Constants {
        static let borderWidthOne : CGFloat = 3.0
        static let cornerRadius: CGFloat = 20
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawCornerRadius()
        addBorder()
    }
    
    //MARK: Shape methods
    private func drawCornerRadius() {
        containerView.layer.cornerRadius = Constants.cornerRadius
        characterImage.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func addBorder() {
        containerView.layer.borderWidth = Constants.borderWidthOne
        containerView.layer.borderColor = UIColor.black.cgColor
    }
}

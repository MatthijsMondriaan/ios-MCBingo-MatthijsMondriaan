//
//  BingoScreenCollectionViewCell.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

protocol BingoScreenCollectionViewCellDelegate: class {
    //func didChangeRoundItemInCell(cell: RoundCollectionViewCell)
    //func handleCellSwipe(gesture: UISwipeGestureRecognizer, cell: RoundCollectionViewCell)
    //func handleMinusButton(cell: RoundCollectionViewCell)
    //func handlePlusButton(cell: RoundCollectionViewCell)
}


class BingoScreenCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    public weak var delegate: BingoScreenCollectionViewCellDelegate?

    // MARK: - UI
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        /*
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
        
        containerView.layer.cornerRadius  = containerView.frame.size.width / 2
        containerView.layer.masksToBounds = true
        containerView.clipsToBounds = true
        */
    }

    private func updateUI() {
        layoutIfNeeded()
    }

}

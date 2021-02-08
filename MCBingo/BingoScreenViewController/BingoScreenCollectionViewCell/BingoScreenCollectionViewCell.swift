//
//  BingoScreenCollectionViewCell.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

protocol BingoScreenCollectionViewCellDelegate: class {
    func markBingoNumber(bingoNumber: BingoNumber)
}


class BingoScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet public weak var numberLabel: UILabel!
    @IBOutlet weak var bingoButton: UIButton!
    
    // MARK: - Properties

    public weak var delegate: BingoScreenCollectionViewCellDelegate?
    
    public var bingoNumber: BingoNumber? {
        didSet {
            if bingoNumber != nil   {
                if bingoNumber!.number.number > 0   {
                    numberLabel.text = String(bingoNumber!.number.number)
                    // If this number is marked, then set alpha to 0.5, else set alpha to zero
                    bingoButton.backgroundColor = !bingoNumber!.marked ? .clear : .black
                } else  {
                    numberLabel.text = "B"
                    
                }
            } else  {
                numberLabel.text = ""
            }
        }
    }

    // MARK: - UI
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        isUserInteractionEnabled = true
        backgroundColor = .red
        numberLabel.isUserInteractionEnabled = false
        bingoButton.backgroundColor = .clear
        bingoButton.alpha = 0.5
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
    
    // MARK: - Functions
    
    @IBAction func didTapBingoButton(_ sender: UIButton) {
        guard bingoNumber != nil, bingoNumber!.number.number > 0 else {
            return
        }
        bingoNumber!.marked = !bingoNumber!.marked
        delegate?.markBingoNumber(bingoNumber: bingoNumber!)
    }
    
}

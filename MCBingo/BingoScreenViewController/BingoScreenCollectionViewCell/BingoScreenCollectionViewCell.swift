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
    
    // MARK: - Constants
    
    let buttonImage = UIImage()
    
    // MARK: - Properties

    public weak var delegate: BingoScreenCollectionViewCellDelegate?
    
    public var bingoNumber: BingoNumber? {
        didSet {
            if bingoNumber != nil   {
                if bingoNumber!.number.number > 0   {
                    isUserInteractionEnabled = true
                    numberLabel.text = String(bingoNumber!.number.number)
                    
                    // If this cell is marked, then set button color to clear, else set color to black
                    bingoButton.backgroundColor = !bingoNumber!.marked ? .clear : .black
                } else  {
                    // If this cell has number 0, this should be the one in the center
                    numberLabel.text = "B"
                    isUserInteractionEnabled = false
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
        
    }
    
    override func prepareForReuse() {
        updateUI()
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
        
        isUserInteractionEnabled = true
        backgroundColor = .red
        numberLabel.isUserInteractionEnabled = false
        bingoButton.backgroundColor = .clear
        bingoButton.alpha = 0.5
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

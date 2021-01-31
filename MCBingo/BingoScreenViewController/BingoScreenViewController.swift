//
//  BingoScreenViewController.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

class BingoScreenViewController: UIViewController {
    
    // MARK: - Constants
    
    static let bingoItemCellIdentifier = "BingoItemCell"

    // MARK: - IB Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var bingoScreenCollectionViewCell: BingoScreenCollectionViewCell?

    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue;
        collectionView.backgroundColor = .yellow
    }
    

    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BingoScreenViewController.bingoItemCellIdentifier, for: indexPath) as! BingoScreenCollectionViewCell

        cell.delegate = self
        
        return cell
    }

}

extension BingoScreenViewController: BingoScreenCollectionViewCellDelegate {
    
}

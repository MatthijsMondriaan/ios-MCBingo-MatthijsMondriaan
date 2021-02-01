//
//  BingoScreenViewController.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

class BingoScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Constants
    
    static let bingoItemCellIdentifier = "BingoItemCellIdentifier"
    
    let horizontalCellSpacing: CGFloat = 0

    // MARK: - IB Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var bingoScreenCollectionViewCell: BingoScreenCollectionViewCell?
    
    var viewInitialLoaded: Bool = false
    var itemsPerRow: CGFloat = 5
    var numberCount = 1

    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue;
        collectionView.backgroundColor = .yellow
        
        let bingoScreenCollectionViewCell = UINib(nibName: "BingoScreenCollectionViewCell", bundle:nil)
        collectionView.register(bingoScreenCollectionViewCell, forCellWithReuseIdentifier:BingoScreenViewController.bingoItemCellIdentifier)
            
        
        collectionView.reloadData()

    }
    
    @objc func updateUI() {
        view.layoutIfNeeded()

        //setNeedsStatusBarAppearanceUpdate()
        //navigationController?.navigationBar.tintColor = UserSettings.foregroundColor


        if !viewInitialLoaded {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let viewWidth = collectionView.frame.size.width
            
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: (viewWidth / itemsPerRow) - (horizontalCellSpacing), height: (viewWidth / itemsPerRow) - horizontalCellSpacing)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = horizontalCellSpacing * 2
            collectionView!.collectionViewLayout = layout
        }
        
        collectionView.reloadData()
        
        view.layoutIfNeeded()
    }

    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BingoScreenViewController.bingoItemCellIdentifier, for: indexPath) as! BingoScreenCollectionViewCell

        cell.delegate = self
        cell.number = numberCount
        
        numberCount += 1
        
        return cell
    }

}

extension BingoScreenViewController: BingoScreenCollectionViewCellDelegate {
    
}

//
//  BingoScreenViewController.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

class BingoScreenViewController: UIViewController {
    
    // MARK: - Constants

    // MARK: - IB Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties

    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue;
        collectionView.backgroundColor = .yellow
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

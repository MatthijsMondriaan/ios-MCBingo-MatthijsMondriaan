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
    
    var welcomeObject: Welcome? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue;
        collectionView.backgroundColor = .yellow
        
        let bingoScreenCollectionViewCell = UINib(nibName: "BingoScreenCollectionViewCell", bundle:nil)
        collectionView.register(bingoScreenCollectionViewCell, forCellWithReuseIdentifier:BingoScreenViewController.bingoItemCellIdentifier)
        
        AppData.shared.onChange.bind(self) {
            if let welcome = AppData.shared.welcome {
                self.welcomeObject = welcome
            }
        }
    }
    
    @objc func updateUI() {
        view.layoutIfNeeded()

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //collectionView.contentInset = UIEdgeInsets(top: horizontalCellSpacing * 2, left: 0, bottom: 0, right: 0)
        updateUI()
    }
    
    // MARK: - IB Actions

    @IBAction func didTapFetchButton(_ sender: UIButton) {
        print("Fetch data!")
        
        Gateway.shared.getData(handler: { success, error in
            if success {
                
                return
            }
            
            if error != nil, case GateWayError.SomeError = error!  {
                //Show error
                
                return
            }
            
            /*

            if error != nil, case TaskGateWayError.NoDevice = error! {
                return
            }
            
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                print("not connected")
                
                return
            }
            
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                print("error code is \(error.code)")
                
                return
            }
            */

            //throw away anyway
            
        })
    }
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let welcome = welcomeObject {
            return welcome.numbers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BingoScreenViewController.bingoItemCellIdentifier, for: indexPath) as! BingoScreenCollectionViewCell

        cell.delegate = self
        
        if let welcome = welcomeObject {
            cell.number = welcome.numbers[indexPath.row].number
        }
                
        return cell
    }

}

extension BingoScreenViewController: BingoScreenCollectionViewCellDelegate {
    
}

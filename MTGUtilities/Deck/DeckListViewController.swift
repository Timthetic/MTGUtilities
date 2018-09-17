//
//  DeckListViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/13/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit
import CoreData

class DeckListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as? AppDelegate)!.privateContext
    
    var CELL_WIDTH: CGFloat = 200
    
    @IBAction func pinch(_ sender: UIPinchGestureRecognizer) {
        CELL_WIDTH *= sender.scale
        sender.scale = 1.0
        
        if CELL_WIDTH > view.frame.width{
            CELL_WIDTH = view.frame.width
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    
    var decks: [Deck] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return decks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as? DeckCell{
            cell.configure(forDeck: decks[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CELL_WIDTH, height: CELL_WIDTH * CONSTS.DECKCELL_ASPECT_RATIO)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSFetchRequest<Deck>(entityName: "Deck")
        context.perform { [weak self] in
            do{
                self?.decks = (try self?.context.fetch(request)) ?? []
            } catch(let error){
                print(error)
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let newDeck = Deck.addDeck(intoContext: context){
            decks.append(newDeck)
        }
        context.performAndWait {[weak self] in
            do{
                try self?.context.save()
            }catch(let error)
            {
                print(error)
            }
        }
        collectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
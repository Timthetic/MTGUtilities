//
//  PageViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/6/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class CardInfoPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, CardDataSource {
    
    
//    ///Tells pages which card to display
//    func cardToDisplay() -> Card? {
//        return card
//    }
//
//    ///Tells pages which (unique) card to display
//    func uniqueCardToDisplay() -> UniqueCard? {
//        return uniqueCard
//    }
    
    private var currentPage: Int = 0
    
    var cardDataSource: CardDataSource?
    
    var card: Card?{
        return cardDataSource?.card
    }
    var uniqueCard: UniqueCard?{
        get{
            return cardDataSource?.uniqueCard
        }
        set{
            cardDataSource?.uniqueCard = newValue
        }
    }
    
    private lazy var switchVC: SwitchViewController = {
        let vc = createVC(withSBIdentifier: "SwitchVC") as! SwitchViewController
        if !UIAccessibilityIsReduceTransparencyEnabled(){
            vc.modalPresentationStyle = .overCurrentContext
        }
        return vc
    }()
    
    private lazy var orderedViewControllers: [UIViewController] = {
        //FIXME: I really don't like this
        let card = (parent as? CardViewController)?.card
        let textVC = createVC(withSBIdentifier: "TextVC") as! TextInfoViewController
        textVC.cardDataSource = self
        let printingsVC = createVC(withSBIdentifier: "PrintingsVC") as! PrintingsInfoViewController
        printingsVC.cardDataSource = self
        let rulingsVC = createVC(withSBIdentifier: "RulingsVC") as! RulingsInfoViewController
        rulingsVC.cardDataSource = self
        return [textVC, printingsVC, rulingsVC]
    }()
    
    func createVC(withSBIdentifier identifier: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vcIndex = orderedViewControllers.index(of: viewController){
            let previousIndex = vcIndex - 1
            if previousIndex >= 0{
                return orderedViewControllers[previousIndex]
            }
            else if previousIndex == -1{
                return orderedViewControllers.last
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vcIndex = orderedViewControllers.index(of: viewController){
            let nextIndex = vcIndex + 1
            if nextIndex < orderedViewControllers.count{
                return orderedViewControllers[nextIndex]
            }
            else if nextIndex == orderedViewControllers.count{
                return orderedViewControllers.first
            }
        }
        return nil
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = orderedViewControllers.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }


    override func touchesMoved(_ touches: Swift.Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if touches.count > 1{
            return
        }
        if let touch = touches.first{
            if touch.force > CONSTS.FORCE_TOUCH_THRESHOLD{
                
                present(switchVC, animated: true, completion: nil)
            }
        }
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

protocol CardDataSource {
//    func cardToDisplay() -> Card?
//    func uniqueCardToDisplay() -> UniqueCard?
    var card: Card?{
        get
    }
    var uniqueCard: UniqueCard?{
        get set
    }
}

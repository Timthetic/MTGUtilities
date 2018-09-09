//
//  PageViewController.swift
//  MTGUtilities
//
//  Created by Tim Rediehs on 9/6/18.
//  Copyright © 2018 Timothy Rediehs. All rights reserved.
//

import UIKit

class CardInfoPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, CardDataSource {
    func cardToDisplay() -> Card? {
        return card
    }
    
    func uniqueCardToDisplay() -> UniqueCard? {
        return uniqueCard
    }
    
    var currentPage: Int = 0
    
    var card: Card?
    var uniqueCard: UniqueCard?
    
    lazy var orderedViewControllers: [UIViewController] = {
        //FIXME: I really don't like this
        let card = (parent as? CardViewController)?.card
        let textVC = createVC(withSBIdentifier: "TextVC") as! TextInfoViewController
        textVC.cardDataSource = self
        let rulingsVC = createVC(withSBIdentifier: "RulingsVC") as! RulingsInfoViewController
        rulingsVC.cardDataSource = self
        return [textVC, rulingsVC]
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func cardToDisplay() -> Card?
    func uniqueCardToDisplay() -> UniqueCard?
}

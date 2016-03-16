//
//  MainPageViewController.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/11/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    private var orderedViewControllers: [UIViewController] =
    [UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstView"),
     UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondView"),
     UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdView")];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        //sets first page in PVC to be the center index
        let firstViewController = orderedViewControllers[1];
        self.setViewControllers([firstViewController],
            direction: .Forward,
            animated: true,
            completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //set background color of page control
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                view.frame = UIScreen.mainScreen().bounds
            } else if view.isKindOfClass(UIPageControl) {
                view.backgroundColor = UIColor.clearColor()
            }
        }
    }
}


// MARK: UIPageViewControllerDataSource

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            guard orderedViewControllersCount != nextIndex else {
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex;
    }
}



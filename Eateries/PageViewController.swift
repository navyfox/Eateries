//
//  PageViewController.swift
//  Eateries
//
//  Created by Игорь Михайлович Ракитянский on 23/11/2016.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var headerArray = ["Записывайте", "Находите"]
    var subheaderArray = ["Создайте свой список любимых ресторанов", "Найдите и отметьте на карте ваши любимые ретораны"]
    var imagesArray = ["food", "iphoneMap"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayViewController(atIndex index: Int) -> contentViewController? {
        guard index >= 0 else { return nil }
        guard index < headerArray.count else { return nil }
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? contentViewController else { return nil }

        contentVC.imageFile = imagesArray[index]
        contentVC.header = headerArray[index]
        contentVC.subheader = subheaderArray[index]
        contentVC.index = index

        return contentVC
    }

    func nextVC(atIndex index: Int){
        if let contentVC = displayViewController(atIndex: index + 1) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
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

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! contentViewController).index
        index -= 1
        return displayViewController(atIndex: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! contentViewController).index
        index += 1
        return displayViewController(atIndex: index)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return headerArray.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? contentViewController
        return contentVC!.index
    }
}

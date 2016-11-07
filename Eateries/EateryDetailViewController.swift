//
//  EateryDetailViewController.swift
//  Eateries
//
//  Created by Игорь Михайлович Ракитянский on 07.11.16.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit

class EateryDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imageName)

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

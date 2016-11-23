//
//  contentViewController.swift
//  Eateries
//
//  Created by Игорь Михайлович Ракитянский on 23/11/2016.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit

class contentViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageButton: UIButton!

    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0

    @IBAction func pageButtonPressed(_ sender: UIButton) {
        switch index {
        case 0:
            let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        pageButton.layer.cornerRadius = 15
        pageButton.clipsToBounds = true
        pageButton.layer.borderWidth = 2
        pageButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        pageButton.layer.borderColor = (#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cgColor

        switch index {
        case 0: pageButton.setTitle("Дальше", for: .normal)
        case 1: pageButton.setTitle("Открыть", for: .normal)
        default:
            break
        }

        headerLabel.text = header
        subheaderLabel.text = subheader
        imageView.image = UIImage(named: imageFile)

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

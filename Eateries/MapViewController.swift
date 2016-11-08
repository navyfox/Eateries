//
//  MapViewController.swift
//  Eateries
//
//  Created by Игорь Михайлович Ракитянский on 08.11.16.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var restaurant: Restaurant!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            guard error == nil else { return }
            guard let placemarks = placemarks else { return }

            let placemark = placemarks.first!

            let annotation = MKPointAnnotation()
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type

            guard let location = placemark.location else { return }
            annotation.coordinate = location.coordinate

            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)

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

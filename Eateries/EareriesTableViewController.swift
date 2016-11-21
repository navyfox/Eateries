//
//  EareriesTableViewController.swift
//  Eateries
//
//  Created by Игорь Михайлович Ракитянский on 01.11.16.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit
import CoreData

class EareriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchResultsConroller: NSFetchedResultsController<Restaurant>!
    var restaurants: [Restaurant] = []
    var searchController: UISearchController!
    var filteredResultArray: [Restaurant] = []




//        Restaurant(name: "Ogonёk Grill&Bar", type: "ресторан", location: "Омск, пр-т Карла Маркса 18/8 8 этаж 257 офис", image: "ogonek.jpg", isVisited: false),
//        Restaurant(name: "Елу", type: "ресторан", location: "Омск", image: "elu.jpg", isVisited: false),
//        Restaurant(name: "Bonsai", type: "ресторан", location: "Омск", image: "bonsai.jpg", isVisited: false),
//        Restaurant(name: "Дастархан", type: "ресторан", location: "Омск", image: "dastarhan.jpg", isVisited: false),
//        Restaurant(name: "Индокитай", type: "ресторан", location: "Омск", image: "indokitay.jpg", isVisited: false),
//        Restaurant(name: "X.O", type: "ресторан-клуб", location: "Омск", image: "x.o.jpg", isVisited: false),
//        Restaurant(name: "Балкан Гриль", type: "ресторан", location: "Омск", image: "balkan.jpg", isVisited: false),
//        Restaurant(name: "Respublica", type: "ресторан", location: "Омск", image: "respublika.jpg", isVisited: false),
//        Restaurant(name: "Speak Easy", type: "ресторанный комплекс", location: "Омск", image: "speakeasy.jpg", isVisited: false),
//        Restaurant(name: "Morris Pub", type: "ресторан", location: "Омск", image: "morris.jpg", isVisited: false),
//        Restaurant(name: "Вкусные истории", type: "ресторан", location: "Омск", image: "istorii.jpg", isVisited: false),
//        Restaurant(name: "Классик", type: "ресторан", location: "Омск", image: "klassik.jpg", isVisited: false),
//        Restaurant(name: "Love&Life", type: "ресторан", location: "Омск", image: "love.jpg", isVisited: false),
//        Restaurant(name: "Шок", type: "ресторан", location: "Омск", image: "shok.jpg", isVisited: false),
//        Restaurant(name: "Бочка", type: "ресторан", location:  "Омск", image: "bochka.jpg", isVisited: false)]

    @IBAction func close(segue: UIStoryboardSegue){
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }

    func filterContent(seachText text: String){
        filteredResultArray = restaurants.filter{ (restaurant) -> Bool in
            return (restaurant.name?.lowercased().contains(text.lowercased()))!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar


        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
             fetchResultsConroller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsConroller.delegate = self

            do {
                try fetchResultsConroller.performFetch()
                restaurants = fetchResultsConroller.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Fetch results controller delegate

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
        tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
        tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
        tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResultArray.count
        }
        return restaurants.count
    }

    func restaurantToDisplayAt(indexPatch: IndexPath) -> Restaurant {
        let restaurant: Restaurant
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filteredResultArray[indexPatch.row]
        } else {
            restaurant = restaurants[indexPatch.row]
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesTableViewCell

        let restaurant = restaurantToDisplayAt(indexPatch: indexPath)

        cell.thumbnailImageView.image = UIImage(data: restaurant.image as! Data)
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type

        cell.accessoryType = restaurant.isVisited ? .checkmark : .none


        return cell
    }

    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let ac = UIAlertController(title: "Заголовок", message: "Тело сообщения", preferredStyle: .actionSheet)
    //        let callAction = UIAlertAction(title: "Позаонить: +7(347)111-111\(indexPath.row)", style: .default) {
    //            (action: UIAlertAction) -> Void in
    //            let alertC = UIAlertController(title: nil, message: "Вызов не может быть завершен", preferredStyle: .alert)
    //            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    //            alertC.addAction(ok)
    //            self.present(alertC, animated: true, completion: nil)
    //        }
    //        let isVisitedTrue = self.restaurantIsVisited[indexPath.row] ? "Я не был здесь" : "Я был здесь"
    //        let isVisited = UIAlertAction(title: isVisitedTrue, style: .default) { (action) in
    //            let cell = tableView.cellForRow(at: indexPath)
    //            self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
    //            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
    //        }
    //        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    //        ac.addAction(callAction)
    //        ac.addAction(isVisited)
    //        ac.addAction(cancel)
    //
    //        present(ac, animated: true, completion: nil)
    //
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
            let defaultText = "Я сейчас в" + self.restaurants[indexPath.row].name!
            if let image = UIImage(data: self.restaurants[indexPath.row].image as! Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }

        let delete = UITableViewRowAction(style: .default, title: "Удалить") {(action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
                let objectToDelete = self.fetchResultsConroller.object(at: indexPath)
                context.delete(objectToDelete)

                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        share.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return [delete, share]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as! EateryDetailViewController
                destinationViewController.restaurant = restaurantToDisplayAt(indexPatch: indexPath)
            }
        }
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension EareriesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(seachText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}

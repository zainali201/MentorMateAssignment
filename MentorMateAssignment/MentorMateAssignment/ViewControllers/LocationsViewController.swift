//
//  ViewController.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController
{
    //MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var locationsArray: [Location] = [Location]()
    var manager: LocationStorageManager!
    
    var locationManager: CLLocationManager = CLLocationManager()

    //MARK: - ViewController lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = LocationStorageManager()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //MARK: - Custom functions
    func getNearbyPlaces()
    {
        if Reachability.isConnectedToNetwork()
        {
            APIManager.shared.getNearByPlaces(latitude: "\(Globals.latitude)", longitude: "\(Globals.longitude)", completion: {(locations) in
                
                for location in locations
                {
                    let id = location.fsq_id
                    let address = location.name
                    
                    let savedLocation = self.manager.fetchDataByID(id: id)
                    
                    if savedLocation.count == 0
                    {
                        let newLocation = self.manager.insert(id: id, address: address)
                        if newLocation != nil
                        {
                            self.locationsArray.append(newLocation!)
                        }
                    }
                    else
                    {
                        self.locationsArray.append(savedLocation[0])
                    }
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tblView.reloadData()
                }
            })
        }
        else
        {
            activityIndicator.stopAnimating()
            locationsArray = manager.fetchData()
            tblView.reloadData()
        }
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return locationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let locationObj = locationsArray[indexPath.row]
        cell.lblLocation.text = locationObj.address
        
        return cell
    }
}

extension LocationsViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0
        {
            let location = locations[0]
            Globals.latitude = location.coordinate.latitude
            Globals.longitude = location.coordinate.longitude
            getNearbyPlaces()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

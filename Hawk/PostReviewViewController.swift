//
//  PostReviewViewController.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/28/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit
import CoreLocation

class PostReviewViewController: UIViewController {
    var userId: String!
    @IBOutlet var commentsField: UITextField!
    @IBOutlet var cityStateField: UITextField!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingSlider: UISlider!
    @IBOutlet var postBtn: UIButton!
    let blueColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.title = "Post a Review"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBack))
    self.navigationController?.navigationBar.tintColor = blueColor
    let yellowColor = UIColor.init(red: 255/255, green: 235/255, blue: 59/255, alpha: 1.0)
    self.view.backgroundColor = yellowColor
    self.navigationController?.navigationBar.barTintColor = yellowColor
    self.postBtn.backgroundColor = blueColor
    self.postBtn.setTitleColor(.white, for: .normal)
    self.cityStateField.text = "15 Hartwell Street, New Brunswick, NJ 08901"
    let unitStep = Double(ratingSlider.value) / step
    let roundedValue = round(unitStep)
    let result = roundedValue * step
    ratingSlider.value = Float(result)
    let ratingStr:String = String(format: "Rating: %.2f", ratingSlider.value)
    self.ratingLabel.text = ratingStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doPost(_ sender: Any) {
        let addressString = cityStateField.text
        CLGeocoder().geocodeAddressString(addressString!, completionHandler: {
            placemarks, error in
            if self.userId == nil {
                self.userId = "user1"
            }
            let placemark = placemarks?[0]
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            Networking.createReview(rating: Double(self.ratingSlider.value), lat: lat!, lon: lon!, comments: self.commentsField.text!, userId: self.userId, completionHandler: {
                response, error in
                
                let status:String = response?["status"] as! String
                if status == "ok" {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let controller = UIAlertController.init(title: "Oops!", message: response?["message"] as? String, preferredStyle: UIAlertControllerStyle.alert)
                    controller.addAction(UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(controller, animated: true, completion: nil)
                }
            })
        })
    }
    
    let step:Double = 0.5
    @IBAction func sliderValueChanged(_ sender: Any) {
        let unitStep = Double(ratingSlider.value) / step
        let roundedValue = round(unitStep)
        let result = roundedValue * step
        ratingSlider.value = Float(result)
        let ratingStr:String = String(format: "Rating: %.2f", ratingSlider.value)
        ratingLabel.text = ratingStr
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

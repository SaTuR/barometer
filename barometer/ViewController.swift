//
//  ViewController.swift
//  barometer
//
//  Created by Dylan Velez on 4/13/17.
//  Copyright © 2017 Dylan Velez. All rights reserved.
//

import UIKit
import CoreMotion
class ViewController: UIViewController {

    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var pressureProgress: UIProgressView!
    
    var isStarted = false
    let altimeter = CMAltimeter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func beginStop(_ sender: Any) {
        if let button = sender as? UIButton {
            if isStarted {
                isStarted = false
                button.backgroundColor = UIColor.blue
                button.setTitle("Comenzar medición", for: .normal)
                altimeter.stopRelativeAltitudeUpdates()
            } else {
                isStarted = true
                button.backgroundColor = UIColor.red
                button.setTitle("Detener medición", for: .normal)
                if CMAltimeter.isRelativeAltitudeAvailable() {
                    altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
                        if let data = data {
                            self.altitudeLabel.text = "\(data.relativeAltitude) m"
                            self.pressureLabel.text = "\(data.pressure) kPa"
                            
                            let progressPercentage = (data.pressure.doubleValue - 33.7) / 67.7
                            self.pressureProgress.setProgress(Float(progressPercentage), animated: true)
                        }
                    })
                }
            }
        }
    }

}


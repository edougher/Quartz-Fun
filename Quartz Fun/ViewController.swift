//
//  ViewController.swift
//  Quartz Fun
//
//  Created by Aaron Dougher on 3/19/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeColor(_ sender: UISegmentedControl) {
        let drawingColorSection = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        if let drawingColor = drawingColorSection {
            let funView = view as! QuartzFunView
            switch drawingColor {
            case .red:
                funView.currentColor = UIColor.red
                funView.useRandomColor = false
                
            case .blue:
                funView.currentColor = UIColor.blue
                funView.useRandomColor = false
                
            case .yellow:
                funView.currentColor = UIColor.yellow
                funView.useRandomColor = false
                
            case .green:
                funView.currentColor = UIColor.green
                funView.useRandomColor = false
                
            case .random:
                funView.useRandomColor = true
                
            }
        }
    }
    
    @IBAction func changeShape(_ sender: UISegmentedControl) {
        let shapeSelection = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        if let shape = shapeSelection {
            let funView = view as! QuartzFunView
            funView.shape = shape
            colorControl.isHidden = shape == Shape.image
        }
    }
    
}


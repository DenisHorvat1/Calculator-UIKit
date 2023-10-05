//
//  ViewController.swift
//  UIKitTema
//
//  Created by Denis Horvat  on 31.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var counterButton: UIButton!
    @IBOutlet var label: UILabel!
    
    var counter: Counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the views
        label.text = "\(counter.counterValue)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //(segue.destination as? CounterViewController).counter = counter
    }   

}

extension ViewController {
    @IBAction func actionButton() {
        performSegue(withIdentifier: "counterIdentifier", sender: counter)
    }
    
    @IBAction func counterActionButton () {
        counter.counterValue += 1
        label.text = "\(counter.counterValue)"
    }
    
}

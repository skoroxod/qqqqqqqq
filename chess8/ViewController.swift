//
//  ViewController.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 24.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ttt: UILabel!
    @IBOutlet weak var canvas: SKCanvas!

    var mozg: ChessBoardAlg = ChessBoardAlg()

    var ind: Int = 0
    var results: Array<Set<ChessboardCell>> = Array()
    @IBAction func button(sender: UIButton) {
        NSLog("click")

        if mozg.results.isEmpty {
            do {
            try mozg.run()
                self.results = Array(mozg.results)
                self.ind = 0;
            } catch {
                NSLog("error")
            }
        }
        if (self.ind >= results.count) {
            self.ind = 0
        }
        let item = results[self.ind++]
        self.ttt.text = "\(self.ind): " + item.sort().description
        canvas.redrawQueens(item)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


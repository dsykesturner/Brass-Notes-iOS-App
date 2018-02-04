//
//  ViewController.swift
//  BrassNotes2
//
//  Created by Daniel Sykes-Turner on 7/7/17.
//  Copyright © 2017 Universe Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StaveDelegate, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var lblSelectedPosition: UILabel!
    @IBOutlet weak var lblSelectedNote: UILabel!
    @IBOutlet weak var stave: Stave!
    var countNoteValue: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup delegates
        stave.delegate = self
        tabBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup the default selection once the auto-constraints have sorted out
        let defaultItem:UITabBarItem = tabBar.items![1]
        populateWithInstrument(instrument: defaultItem.title!)
        tabBar.selectedItem = defaultItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Interaction actions
    
    @IBAction func touchGestureDidPan(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let stepSize:CGFloat = 30

        if (translation.y > stepSize) {
            stave.decrementNote()
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        if (translation.y < -stepSize) {
            stave.incrementNote()
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    // MARK: - Regaular methods
    
    func populateWithInstrument(instrument: String) {
        
        navigationController?.navigationBar.topItem?.title = instrument
        stave.populateWithInstrument(instrument: instrument.lowercased())
    }
    
    // MARK: - StaveDelegate
    
    func staveDidChangeCurrentNote(_ note: NoteObject) {
        
        lblSelectedNote.text = note.note
        lblSelectedPosition.text = note.position
    }
    
    // MARK: - UITabBarDelegate
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Populate the stave with the lowercased name of the tab item selected
        self.populateWithInstrument(instrument: item.title!)
    }
}


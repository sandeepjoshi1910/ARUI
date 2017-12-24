//
//  ViewController.swift
//  ARUI
//
//  Created by sandeepjoshi1910 on 12/23/2017.
//  Copyright (c) 2017 sandeepjoshi1910. All rights reserved.
//

import UIKit
import ARUI
import ARKit
import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate, ARUIDelegateProtocol {
    
    @IBOutlet weak var sceneView: ARSCNView!
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    func imageResourceFor(restorationId: String) -> UIImage? {
        return UIImage(named: "AR")
    }
    
    func textResourceFor(restorationId: String) -> String? {
        return "Augmented Reality"
    }
    
    func buttonTextFor(restorationId: String) -> String? {
        return "Click Me!"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


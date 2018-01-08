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
    
    
    func textResourceFor(restorationId: String) -> ARUITextInfo? {
        
        switch restorationId {
        case "placeName":
            let textInfo = ARUITextInfo(textString: "Colosseum", color: UIColor.blue, font: "Arial")
            return textInfo
            
        case "builtIn":
            let textInfo = ARUITextInfo(textString: "Built in: 70–80 AD", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "located":
            let textInfo = ARUITextInfo(textString: "Located: city of Rome, Italy", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "capacity":
            let textInfo = ARUITextInfo(textString: "Capacity: Estimated between 50,000 and 80,000 ", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "builtBy":
            let textInfo = ARUITextInfo(textString: "Built by: Emperor Vespasian & Emperor Titus", color: UIColor.black, font: "Arial")
            return textInfo
            
        default:
            break
        }
        
        let textInfo = ARUITextInfo(textString: "Augmented Reality", color: UIColor.blue, font: "Menlo")
        return textInfo
    }
    
    
    
    
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
        var image = UIImage()
        switch restorationId {
            case "icon":
                image =  UIImage(named: "cicon")!
            case "image1":
                image =  UIImage(named: "image1")!
            case "image2":
                image =  UIImage(named: "image2")!
            case "image3":
                image =  UIImage(named: "image3")!
            case "image4":
                image =  UIImage(named: "image4")!
            default:
                break
        }
        return image
    }
    
  
    
    func buttonTextFor(restorationId: String) -> String? {
        return "Click Me!"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let ARH : ARUIHandler = ARUIHandler(nibName: "ExampleUI", delegate: self, scnView: sceneView, arViewWidth: 14.0, arViewDepth: -20.0)
        ARH.panelColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 176/255.0, alpha: 0.8)
        ARH.drawARUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }


}


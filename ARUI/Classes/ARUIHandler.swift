//
//  ARUIHandler.swift
//  ARTextNode
//
//  Created by Sandeep Joshi on 12/23/17.
//  Copyright © 2017 Sandeep Joshi. All rights reserved.
//

import UIKit
import ARKit

class ARUIHandler: NSObject {
    
    var delegate     : ARUIDelegateProtocol?
    var sceneView    : ARSCNView?
    var nibFileName  : String?
    var ARViewWidth  : CGFloat?
    var ARViewHeight : CGFloat?
    var ARViewDepth  : CGFloat?
    var ARScaling    : CGFloat?
    
    init(nibName: String, delegate: ARUIDelegateProtocol, scnView: ARSCNView, arViewWidth: Float, arViewDepth: Float) {
        super.init()
        self.nibFileName = nibName
        self.delegate    = delegate
        self.sceneView   = scnView
        self.ARViewWidth = CGFloat(arViewWidth)
        self.ARViewDepth = CGFloat(arViewDepth)
    }
    
    func drawARUI() {
        
        let parentView : UIView = Bundle.main.loadNibNamed(self.nibFileName!, owner: nil, options: nil)?.last as! UIView
        let UIviewWidth  = CGFloat(parentView.frame.width)
        let UIviewHeight = CGFloat(parentView.frame.height)
        
        self.ARScaling    = ARViewWidth! / UIviewWidth
        self.ARViewHeight = ARScaling! * UIviewHeight
        
        // Anchor for the depth info
        let anchor : ARAnchor = getMainPaneAnchor()
        
        // Node for the main background panel
        let mainPanel = getmainPanel(height: ARViewHeight!, width: ARViewWidth!)
        let mainNode  = SCNNode(geometry: mainPanel)
        
        sceneView?.session.add(anchor: anchor)
        sceneView?.scene.rootNode.addChildNode(mainNode)
        mainNode.position = SCNVector3(0.0, 0.0, self.ARViewDepth!)
        
        
        for view in parentView.subviews {
            
            let viewType : String = String(describing: Mirror(reflecting: view).subjectType)
            
            switch viewType {
                
            case "UIImageView":
                let image = delegate?.imageResourceFor(restorationId: view.restorationIdentifier!)
                addARNodeToView(isImgNode: true, isButton: false, width: view.frame.width, height: view.frame.height, x: view.frame.origin.x, y: view.frame.origin.y, image: image, text: nil)
                break
            case "UILabel":
                let text : String = (delegate?.textResourceFor(restorationId: view.restorationIdentifier!))!
                addARNodeToView(isImgNode: false, isButton: false, width: view.frame.width, height: view.frame.height, x: view.frame.origin.x, y: view.frame.origin.y, image: nil, text: text)
                break
            case "UIButton":
                let text : String = (delegate?.buttonTextFor(restorationId: view.restorationIdentifier!))!
                addARNodeToView(isImgNode: false, isButton: true, width: view.frame.width, height: view.frame.height, x: view.frame.origin.x, y: view.frame.origin.y, image: nil, text: text)
                break
                
            default:
                print("The type: \(viewType) is not supported as of now in this Pod. We regret the inconvenience")
            }
        }
        
    }
    
    private func getMainPaneAnchor() -> ARAnchor {
        var position = matrix_identity_float4x4
        position.columns.3.z = Float(self.ARViewDepth!)
        return ARAnchor(transform: position)
    }
    
    private func getmainPanel(height: CGFloat, width: CGFloat) ->SCNPlane {
        
        let mainPlane : SCNPlane = {
            let mPlane : SCNPlane = SCNPlane(width: width, height: height)
            mPlane.firstMaterial?.isDoubleSided = true
            mPlane.cornerRadius = 0.3
            mPlane.firstMaterial?.diffuse.contents = UIColor(red: 0/255.0, green: 43/255.0, blue: 54/255.0, alpha: 0.8)
            return mPlane
        }()
        return mainPlane
    }
    
    private func addARNodeToView(isImgNode: Bool, isButton: Bool, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, image: UIImage?, text: String?) {
        
        let scaledWidth : CGFloat  = self.ARScaling! * width
        let scaledHeight : CGFloat = self.ARScaling! * height
        let scaledX : CGFloat      = self.ARScaling! * x
        let scaledY : CGFloat      = self.ARScaling! * y
        
        if(isImgNode) {
            
            let imgNode = getImageNode(width: scaledWidth, height: scaledHeight, image: image!)
            sceneView?.scene.rootNode.addChildNode(imgNode)
            let xValue = -(ARViewWidth! / 2.0) + scaledWidth / 2.0 + scaledX
            let yValue = -(scaledHeight / 2.0) + ARViewHeight! / 2.0 - scaledY
            imgNode.position = SCNVector3( CGFloat(xValue), CGFloat(yValue) , CGFloat(self.ARViewDepth!))
            imgNode.position.z = imgNode.position.z + 0.05
            
        } else {
            
            let tNode = getTextNodeFor(text: text!, height: scaledHeight, width: scaledWidth)
            sceneView?.scene.rootNode.addChildNode(tNode)
            
            let xPosition = CGFloat(-(ARViewWidth!/2.0) + scaledX)
            
            if(isButton) {
                // Button has to be center aligned but text need not be...
                tNode.position = SCNVector3( xPosition - scaledWidth/2.0, CGFloat(-1.5 + ARViewHeight!/2.0 - scaledY), CGFloat(self.ARViewDepth!))
            } else {
                tNode.position = SCNVector3(xPosition, CGFloat(-1.5 + ARViewHeight!/2.0 - scaledY), CGFloat(self.ARViewDepth!))
            }
        }
    }
    
    private func getImageNode(width : CGFloat, height: CGFloat, image: UIImage) ->SCNNode{
        let mainImgMaterial = SCNMaterial()
        mainImgMaterial.diffuse.contents = image
        let mainImgPlane = SCNPlane(width: CGFloat(width), height: CGFloat(height))
        mainImgPlane.cornerRadius = 0.1
        let mainImgNode = SCNNode(geometry: mainImgPlane)
        mainImgNode.geometry?.materials = [mainImgMaterial]
        return mainImgNode
    }
    
    private func getTextNodeFor(text: String, height: CGFloat, width: CGFloat) -> SCNNode {
        
        let textPlane = SCNPlane(width: width, height: height)
        let planeNode = SCNNode(geometry: textPlane)
        let tex = SCNText(string: text, extrusionDepth: 0.04)
        tex.font = UIFont(name: "Arial", size: 0.5)
        tex.isWrapped = true
        
        let textMaterial = SCNMaterial()
        textMaterial.diffuse.contents = tex
        planeNode.geometry?.materials = [textMaterial]
        let textNode = SCNNode(geometry: tex)
        textNode.addChildNode(planeNode)
        return textNode
    }
    
}


public protocol ARUIDelegateProtocol {
    func imageResourceFor(restorationId: String) -> UIImage?
    func textResourceFor(restorationId: String)  -> String?
    func buttonTextFor(restorationId: String)    -> String?
}


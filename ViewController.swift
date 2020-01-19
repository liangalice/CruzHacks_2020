//
//  ViewController.swift
//  day2
//
//  Created by Alice Liang on 1/18/20.
//  Copyright © 2020 Alice Liang. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

//5
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    // variables
    private var nodeStart: SCNNode!
    private var nodeEnd: SCNNode!
    private var node : SCNNode!
    var firstPosition = false
    var secondPosition = false
    var thirdPosition = false
    var fourthPosition = false
    
    public var x  = Float(0)
    public var y  = Float(0)
    public var z  = Float(0)
    
    public var x2  = Float(0)
    public var y2  = Float(0)
    public var z2  = Float(0)
    
    public var x3  = Float(0)
    public var y3  = Float(0)
    public var z3  = Float(0)
    
    public var x4  = Float(0)
    public var y4  = Float(0)
    public var z4  = Float(0)
    
    public var h1 = SCNVector3(0,0,0)
    public var h2 = SCNVector3(0,0,0)
    public var h3 = SCNVector3(0,0,0)
    public var h4 = SCNVector3(0,0,0)
    
    
    
    
   // float currPos = SCNVector3(0,0,-0.1)

    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show statistics such as fps and timing information
        self.sceneView.showsStatistics = true
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        self.addTapGesture();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sceneView.session.pause()
    }

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
    
    func addNode(x : Float = 0 , y: Float = 0, z: Float = 0.1){
        let circle = SCNNode(geometry: SCNSphere(radius: 0.003))
        self.node = circle
        sceneView.scene.rootNode.addChildNode(self.node)
    }
  
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func didTap(_ gesture: UIPanGestureRecognizer) {
        // 1
        let tapLocation = gesture.location(in: self.sceneView)
        let results = self.sceneView.hitTest(tapLocation, types: .featurePoint)
     
        // 2
        guard let result = results.first else {
            return
        }
        
        // 3
        let translation = result.worldTransform.translation
        
        //4
        guard let node = self.node else {
            self.addNode(x: translation.x, y: translation.y, z: translation.z)
            return
        }
        
        let sphere = SCNNode(geometry: SCNSphere(radius: 3))
        node.position = SCNVector3Make(translation.x, translation.y, translation.z)
        self.sceneView.scene.rootNode.addChildNode(self.node)
        self.sceneView.scene.rootNode.addChildNode(sphere)
        
        
        if(firstPosition == false){
            x = self.node.worldPosition.x
            y = self.node.worldPosition.y
            z = self.node.worldPosition.z
             h1 = self.node.worldPosition
            firstPosition = true
        }
        else if(firstPosition == true){
            x2 = self.node.worldPosition.x
            y2 = self.node.worldPosition.y
            z2 = self.node.worldPosition.z
             h2 = self.node.worldPosition
            secondPosition = true
        }
       else if(secondPosition == true){
            x3 = self.node.worldPosition.x
            y3 = self.node.worldPosition.y
            z3 = self.node.worldPosition.z
            h3 = self.node.worldPosition
            thirdPosition = true
        }
        //else if(thirdPosition == true){
        else{
            x4 = self.node.worldPosition.x
            y4 = self.node.worldPosition.y
            z4 = self.node.worldPosition.z
            h4 = self.node.worldPosition
           // fourthPosition = true
            print(h1,h2,h3,h4)
        }
            
      
        //print(self.node.worldPosition.y)
    }
    
}

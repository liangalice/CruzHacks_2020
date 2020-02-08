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

    var holder = 0
    
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
    
    public var d1 = Float(0)
    public var d2 = Float(0)
    
    public var volume = Float(0)
    
    
    
    
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
        let circle = SCNNode(geometry: SCNSphere(radius: 0.0003))
        self.node = circle
        sceneView.scene.rootNode.addChildNode(self.node)
    }
  
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
        
    }
    func getPos(from: SCNVector3 , to: SCNVector3) ->Float{
        let x = from.x - to.x
        let y = from.y - to.y
        let z = from.z - to.z
        return sqrtf((x*x)+(y*y)+(z*z))
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
            holder = 1
            
           // print(h1)
            
        }
        else if(holder == 1 ){
            x2 = self.node.worldPosition.x
            y2 = self.node.worldPosition.y
            z2 = self.node.worldPosition.z
             h2 = self.node.worldPosition
//            let xHH = x-x2
//            let yHH = y-y2
//            let zHH = z-z2
            holder = 2
            //print(h1)
            //print(h2)
            d1 = 100*(getPos(from:h2,to:h1))
        
            
        }
       else if(holder == 2){
            x3 = self.node.worldPosition.x
            y3 = self.node.worldPosition.y
            z3 = self.node.worldPosition.z
            h3 = self.node.worldPosition
            holder = 3
         //   print(h3)
        }
        else if(holder == 3){
        
            x4 = self.node.worldPosition.x
            y4 = self.node.worldPosition.y
            z4 = self.node.worldPosition.z
            h4 = self.node.worldPosition
           // fourthPosition = true
          //  print(h4)
            d2 = 100*getPos(from:h4,to:h3)
         //   print(getVolume(d1get:d1,d2get:d2))
        }
            
      
        //print(self.node.worldPosition.y)
    }
    
    func getVolume(d1get : Float,d2get : Float) -> Float{
    // d1 is horizontal
       // print("diameter is below")
      //  print(d1)
        let radius = d1/2
      //  print("radius is below" )
      //  print(radius)
      //  print("height is below")
      //  print(d2)
         volume = ((Float.pi*(radius*radius)*d2))
     //   print("volume is")
     //   print(volume)
        
        return volume
        //return volume
    }
    

    
    @IBAction func buttonaction(_ sender: UIButton){
        let a = getVolume(d1get : d1, d2get : d2 )

        if sender.title(for: .normal) == "Button"{
            sender.setTitle("\(a)", for: .normal)
        }
    
    
   
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.destination is transferFunction){
            let vc = segue.destination as? transferFunction
            vc?.volume = volume
        }
    }
    var username:String = ""
    
    @IBOutlet weak var usernameLabel:UILabel?
    
}

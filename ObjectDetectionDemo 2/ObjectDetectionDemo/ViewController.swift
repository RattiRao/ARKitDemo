//
//  ViewController.swift
//  ObjectDetectionDemo
//
//  Created by Ratti on 05/07/19.
//  Copyright © 2019 Ratti. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        if let obj = ARReferenceObject.referenceObjects(inGroupNamed:"demo",bundle: nil)
        {
            configuration.detectionObjects = obj
            sceneView.session.run(configuration)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if let objAnchor = anchor as? ARObjectAnchor
        {
            let translation = objAnchor.transform.columns.3
            let pos = float3(translation.x, translation.y, translation.z)
            let nodeArrow = getDetectionNode()
            nodeArrow.position = SCNVector3(pos)
            sceneView.scene.rootNode.addChildNode(nodeArrow)
        }
    }
    
    func getDetectionNode() -> SCNNode {
        let sceneURL = Bundle.main.url(forResource: "detection", withExtension: "scn", subdirectory: "art.scnassets")!
        let referenceNode = SCNReferenceNode(url: sceneURL)!
        referenceNode.load()
        return referenceNode
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

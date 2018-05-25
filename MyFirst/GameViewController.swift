//
//  GameViewController.swift
//  MyFirst
//
//  Created by sj on 09/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit



class GameViewController: UIViewController {
    var operationQueue: OperationQueue?
    var activityIndicator: UIActivityIndicatorView?
    var gameController: GameController?
    var button: UIButton?
    
    
    
    var gameView: SCNView {
        return view as! SCNView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button?.setTitleColor(UIColor.red, for: UIControlState.normal)
        button?.setTitle("begin", for: .normal)
        button?.backgroundColor = UIColor.white
        button?.addTarget(self, action: #selector(test), for: UIControlEvents.touchUpInside)
        let myView = UIView()
       // myView.addSubview(button!)
        self.view.addSubview(button!)
        self.view.bringSubview(toFront: button!)
        let gameView = self.view as! SCNView
        if UIDevice.current.userInterfaceIdiom == .pad {
           self.gameView.contentScaleFactor = min(1.3, self.gameView.contentScaleFactor)
            self.gameView.preferredFramesPerSecond = 60
        }
         gameController = GameController()
        let scene = SCNScene(named: "art.scnassets/character/max.scn")
        gameView.scene = scene!
/*
 
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let url = URL(string: "http://127.0.0.1/Assets/character/max.scn")!
        let url1 = URL(string: "http://127.0.0.1/Assets/character")!
        let url2 = URL(string: "max_A0.png")!
        let url3 = URL(string: "max_DiffuseE.png")!
    //    let sceneSource = SCNSceneSource(url: url, options: [SCNSceneSource.LoadingOption.animationImportPolicy : SCNSceneSource.AnimationImportPolicy.doNotPlay])!
    //    if sceneSource != nil {
          //sceneSource.entryWithIdentifier(<#T##uid: String##String#>, withClass: <#T##T.Type#>)
       //     print("ok")
      //  }
        
     //   let scene  = SCNSceneSource(url: url!, options: [SCNSceneSource.LoadingOption.assetDirectoryURLs: SCNSceneSource.LoadingOption.assetDirectoryURLs.rawValue])
       // var scene1: SCNScene!
    //    let dir = [SCNSceneSource.LoadingOption.assetDirectoryURLs: SCNSceneSource.LoadingOption.assetDirectoryURLs.rawValue]
    //    let ani = [SCNSceneSource.LoadingOption.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.doNotPlay]
    
        
       // let options = [SCNSceneSource.LoadingOption.assetDirectoryURLs: url1,
              //         SCNSceneSource.LoadingOption.animationImportPolicy:  SCNSceneSource.AnimationImportPolicy.doNotPlay] as [SCNSceneSource.LoadingOption : Any]
        let options = [SCNSceneSource.LoadingOption.assetDirectoryURLs:[url]]
        do {
           // scene = try SCNScene(url: url, options: nil)
        } catch {
            print(error)
            //fatalError(Error)
        }
     // guard  let scene1 = SCNScene(named: "art.scnassets/freeMountain.dae") else {
     //   print("rrr:")
     //   return
     //   }
     //   var  mountain: SCNNode!
     //   mountain = scene1.rootNode.childNode(withName: "Free_Mountain", recursively: true)
      //  mountain.simdPosition = simd_float3(0, 0, 0)
     //   scene.rootNode.addChildNode(mountain)
        
        
 
    
        
        let manager = FileManager()
        let urlForDocument = manager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask)
       let urlX = urlForDocument[0] as NSURL
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: urlX.path!)
        print("contentsOfPath: \(contentsOfPath)")
        let filePath: String = NSHomeDirectory() + "/Documents/hangge.txt"
        let exit = manager.fileExists(atPath: filePath)
        let Me: String = (NSHomeDirectory() + "/documents/Me")
            
        
   //  try manager.createDirectory(at: Me, withIntermediateDirectories: true, attributes: nil)
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        //scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
       scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
      //  let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // animate the 3d object
     //   ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
    
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
         
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
 
 */
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @objc
    func test(_ sender: UIButton) {
            print("touch")
    }
    fileprivate func startBasicDemo() {
        
    
        let imageUrls = [
            "localhost/assets/qq.png",
            "localhost/assets/login_close.png",
            "localhost/assets/login_head.png",
            "localhost/assets/register_close.png"
        ]
       var  image1: UIImageView?
        var  image2: UIImageView?
        var  image3: UIImageView?
        var  image4: UIImageView?
        var imageViews: [UIImageView] = []
        
        
       
        operationQueue = OperationQueue()
        operationQueue?.maxConcurrentOperationCount = 3
        
       activityIndicator = UIActivityIndicatorView()
        
        activityIndicator?.startAnimating()
        
        //        使用数组给图片赋值
        //        use Array set image
        for imageView in imageViews {
            operationQueue?.addOperation {
                if let url = URL(string: "https://placebeard.it/355/140") {
                    do {
                        let image = UIImage(data:try Data(contentsOf: url))
                        
                        DispatchQueue.main.async {
                            imageView.image = image
                            
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        
        //        global queue
        DispatchQueue.global().async {
            [weak self] in
            
            //            等待所有操作都完成了,回到主线程停止刷新器。
            //            wait Until All Operations are finished, then stop animation of activity indicator
            self?.operationQueue?.waitUntilAllOperationsAreFinished()
            DispatchQueue.main.async {
                
                self?.activityIndicator?.stopAnimating()
            }
        }
    }

}

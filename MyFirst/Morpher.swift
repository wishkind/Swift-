//
//  Morpher.swift
//  MyFirst
//
//  Created by sj on 10/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SceneKit



class Morpher: NSObject {
    
    
    init(_ scnView: SCNView) {
    
        let modelNode = scnView.scene!.rootNode.childNode(withName: "ModelNode", recursively: true)
        let modelMesh = modelNode?.childNode(withName: "MeshName", recursively: true)

        let verts = modelMesh?.geometry?.sources(for: SCNGeometrySource.Semantic.vertex)
        let normals = modelMesh?.geometry?.sources(for: SCNGeometrySource.Semantic.normal)
        let texcoords = modelMesh?.geometry?.sources(for: SCNGeometrySource.Semantic.texcoord)
        let boneWeights = modelMesh?.geometry?.sources(for: SCNGeometrySource.Semantic.boneWeights)
        let boneIndices = modelMesh?.geometry?.sources(for: SCNGeometrySource.Semantic.boneIndices)
    
        let geometry = modelMesh?.geometry?.element(at: 0)
    
        let vertsData = NSData(data: verts![0].data) as Data
        let texcoordsData = NSData(data: texcoords![0].data) as Data
        let boneWeightsData = NSData(data: boneWeights![0].data) as Data
        let boneIndicesData = NSData(data: boneIndices![0].data) as Data
        let geometryData = NSData(data: geometry!.data) as Data
// Note: the vertex and normal data is shared.

        let newVerts = SCNGeometrySource(data: vertsData,
                                         semantic: .vertex,
                                         vectorCount: verts![0].vectorCount,
                                         usesFloatComponents: verts![0].usesFloatComponents,
                                         componentsPerVector: verts![0].componentsPerVector,
                                         bytesPerComponent: verts![0].bytesPerComponent,
                                         dataOffset: verts![0].dataOffset,
                                         dataStride: verts![0].dataStride)

        let newNormals = SCNGeometrySource(data: vertsData as Data,
                                           semantic: .normal,
                                           vectorCount: normals![0].vectorCount,
                                           usesFloatComponents: normals![0].usesFloatComponents,
                                           componentsPerVector: normals![0].componentsPerVector,
                                           bytesPerComponent: normals![0].bytesPerComponent,
                                           dataOffset: normals![0].dataOffset,
                                           dataStride: normals![0].dataStride)


        let newTexcoords = SCNGeometrySource(data: texcoordsData,
                                     semantic: .texcoord,
                                     vectorCount: texcoords![0].vectorCount,
                                     usesFloatComponents: texcoords![0].usesFloatComponents,
                                     componentsPerVector: texcoords![0].componentsPerVector,
                                     bytesPerComponent: texcoords![0].bytesPerComponent,
                                     dataOffset: texcoords![0].dataOffset,
                                     dataStride: texcoords![0].dataStride)



        let newBoneWeights = SCNGeometrySource(data: boneWeightsData,
                                       semantic: .boneWeights,
                                       vectorCount: boneWeights![0].vectorCount,
                                       usesFloatComponents: boneWeights![0].usesFloatComponents,
                                       componentsPerVector: boneWeights![0].componentsPerVector,
                                       bytesPerComponent: boneWeights![0].bytesPerComponent,
                                       dataOffset: boneWeights![0].dataOffset,
                                       dataStride: boneWeights![0].dataStride)

        let newBoneIndices = SCNGeometrySource(data: boneIndicesData,
                                       semantic: .boneIndices,
                                       vectorCount: boneIndices![0].vectorCount,
                                       usesFloatComponents: boneIndices![0].usesFloatComponents,
                                       componentsPerVector: boneIndices![0].componentsPerVector,
                                       bytesPerComponent: boneIndices![0].bytesPerComponent,
                                       dataOffset: boneIndices![0].dataOffset,
                                       dataStride: boneIndices![0].dataStride)
        
        
        let newGeometry = SCNGeometryElement(data: geometryData,
                                     primitiveType: geometry!.primitiveType,
                                     primitiveCount: geometry!.primitiveCount,
                                     bytesPerIndex: geometry!.bytesPerIndex)

        let newMeshGeometry = SCNGeometry(sources: [newVerts, newNormals, newTexcoords, newBoneWeights, newBoneIndices], elements: [newGeometry])

        newMeshGeometry.firstMaterial = modelMesh?.geometry!.firstMaterial

        let newModelMesh = SCNNode(geometry: newMeshGeometry)

        let bones = modelMesh?.skinner?.bones
        let boneInverseBindTransforms = modelMesh?.skinner?.boneInverseBindTransforms
        let skeleton = modelMesh!.skinner!.skeleton!
        let baseGeometryBindTransform = modelMesh!.skinner!.baseGeometryBindTransform

        newModelMesh.skinner = SCNSkinner(baseGeometry: newMeshGeometry,
                                          bones: bones!,
                                          boneInverseBindTransforms: boneInverseBindTransforms,
                                          boneWeights: newBoneWeights,
                                          boneIndices: newBoneIndices)

        newModelMesh.skinner?.baseGeometryBindTransform = baseGeometryBindTransform

// Before this assignment, newModelMesh.skinner?.skeleton is nil.
newModelMesh.skinner?.skeleton = skeleton
// After, it is still nil... however, skeleton itself is completely valid.

modelMesh?.removeFromParentNode()

newModelMesh.name = "MeshName"

        let meshParentNode = modelNode?.childNode(withName: "MeshParentNode", recursively: true)

meshParentNode?.addChildNode(newModelMesh)
    
        let hero: SCNNode = SCNScene(named: "Hero")!.rootNode
        let hat: SCNNode = SCNScene(named: "FancyFedora")!.rootNode
        hat.skinner?.skeleton = hero.skinner?.skeleton
        
        
        
        
        /*
    [Export ("initWithFrame:")]
    public UIView (System.Drawing.RectangleF frame) : base (NSObjectFlag.Empty)
 {
    // Invoke the init method now.
    var initWithFrame = new Selector ("initWithFrame:").Handle;
    if (IsDirectBinding)
    Handle = ObjCRuntime.Messaging.IntPtr_objc_msgSend_RectangleF (this.Handle, initWithFrame, frame);
    else
    Handle = ObjCRuntime.Messaging.IntPtr_objc_msgSendSuper_RectangleF (this.SuperHandle, initWithFrame, frame);
    }
 */
 
 

        
        guard let url = Bundle.main.url(forResource: "file", withExtension: "scn") else {
            fatalError("wrong")
        }
        
        let ss = SCNSceneSource(url: url as URL, options: [:])
        
        let identifiers = ss?.identifiersOfEntries(withClass: SCNGeometry.self) as! [String]
        for id in identifiers {
            print(id)
        }
        
        let url1 = URL(string: "http://127.0.0.1/Assets/character")
        do {
            let s1 = try SCNScene(url: url1!, options: [SCNSceneSource.LoadingOption.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.play])
        } catch {
            
        }
        var sceneData: Data?
        do {
            sceneData = try NSData(contentsOf: url, options: NSData.ReadingOptions.dataReadingMapped) as Data
        } catch {
            print("\(error)")
        }
       // let options = [SCNSceneSource.LoadingOption.overrideAssetURLs: true,
                //       SCNSceneSource.LoadingOption.assetDirectoryURLs: Bundle.urls(self))
        //let source = SCNSceneSource(data: sceneData as Data, options: options)
        
       
}
    
   
    
    
    
    
    func extractAnimationsFromSceneSource(sceneSource: SCNSceneSource) {
        
        let animationsIDs = sceneSource.identifiersOfEntries(withClass: CAAnimation.self) as [String]
        var animations: [CAAnimation] = []
        for animationID in animationsIDs {
            if let animation = sceneSource.entryWithIdentifier(animationID, withClass: CAAnimation.self) as? CAAnimation {
            
                animations.append(animation)
            }
        }
        
    }
   
}

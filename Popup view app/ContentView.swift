//
//  ContentView.swift
//  Popup view app
//
//  Created by Nethan on 9/3/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @State var clicked = false
    var body: some View {
   
        
        Button {
            clicked = true
        } label: {
            Text("Click")
        }
        .sheet(isPresented: $clicked) {
            VStack {
                VStack {
                    Spacer()
                    Text("Nethan's AirPods Max")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
             
                SceneKitView(scene: SCNScene(named: "airpods-max.usdz")!)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
                
                Image(systemName: "battery.75")
                    .foregroundColor(.green)
                    .font(.title)
                Spacer()
                Text("75%")
                    .foregroundColor(.black)
                Spacer()
                Spacer()
                
            }
            .background(Color.white)
            .presentationDetents([.height(350)])
        }
        
    }
}

struct SceneKitView: UIViewRepresentable {
    let scene: SCNScene
    let cameraNode = SCNNode()

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = scene
        scnView.backgroundColor = UIColor.white
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        
        // Set up camera
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scnView.pointOfView = cameraNode
        
        let boundingBox = scene.rootNode.boundingBox
                let center = SCNVector3(
                    x: (boundingBox.max.x - boundingBox.min.x) / 2 + boundingBox.min.x,
                    y: (boundingBox.max.y - boundingBox.min.y) / 2 + boundingBox.min.y,
                    z: (boundingBox.max.z - boundingBox.min.z) / 2 + boundingBox.min.z
                )
                scene.rootNode.position = SCNVector3(x: -center.x, y: -center.y, z: -center.z)
                
        
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

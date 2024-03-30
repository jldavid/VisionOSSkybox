import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(\.openWindow) var openWindow
    @EnvironmentObject var skyBoxSettings: SkyboxSettings
    
    var body: some View {
        RealityView { content in
            //create skybox
            guard let skyBoxEntity = createSkybox() else{return }
            
            content.add(skyBoxEntity)
            
            //Add to content
            
        } update: { content in
            //print("Latest skybox settings is: \(skyBoxSettings.currentSkybox)")
            
            updateSkybox(with: skyBoxSettings.currentSkybox, content: content)
        }
        .onAppear(perform: {
            openWindow(id: "SkyBoxControls")
        })
    }
    
    private func createSkybox() -> Entity? {
        //Mesh( large image)
        let skyBoxMesh = MeshResource.generateSphere(radius: 1000)
        
        //Material(skybox images)
        var skyBoxMaterial = UnlitMaterial()
        guard let skyBoxTexture = try? TextureResource.load(named: "Forest")else{return nil}
        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture))
        
        
        //Entity
        let skyBoxEntity = Entity()
        skyBoxEntity.components.set(ModelComponent(mesh: skyBoxMesh, materials: [skyBoxMaterial]
        ))
        
        skyBoxEntity.name = "SkyBox"
        
        //map image to inner surface of sphere
        skyBoxEntity.scale = .init(x: -1,y: 1, z: 1)
        
        return skyBoxEntity
    }
    
    private func updateSkybox(with newSkyBoxName: String, content: RealityViewContent) {
        //Getting skybox entity from content
        let skyBoxEntity = content.entities.first { entity in
            entity.name == "SkyBox"
        }
        
        //Update it's material to latest skybox
        guard let updatedSkyBoxTexture = try? TextureResource.load(named: newSkyBoxName) else{ return}
        var updatedSkyBoxMaterial = UnlitMaterial()
        updatedSkyBoxMaterial.color = .init(texture: .init(updatedSkyBoxTexture))
        
        skyBoxEntity?.components.set(
            ModelComponent(mesh: MeshResource.generateSphere(radius: 1000), materials: [updatedSkyBoxMaterial]))
        
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}

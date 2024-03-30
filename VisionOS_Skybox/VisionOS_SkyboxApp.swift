import SwiftUI

@main
struct VisionOS_SkyboxApp: App {
    @ObservedObject var skyBoxSettings = SkyboxSettings()
    
    var body: some Scene {
        

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environmentObject(skyBoxSettings)
        }
        .immersionStyle(selection: .constant(.full), in: .full)
        
        WindowGroup(id: "SkyBoxControls") {
            SkyBoxControlsView()
                .environmentObject(skyBoxSettings)
        }
        .defaultSize(width: 30, height: 30)
    }
}

class SkyboxSettings : ObservableObject{
    @Published var currentSkybox = ""
}

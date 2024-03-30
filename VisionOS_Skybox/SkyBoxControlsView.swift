import SwiftUI

struct SkyBoxControlsView: View {
    @EnvironmentObject var skyBoxSettings: SkyboxSettings
    var body: some View {
        VStack{
            Text("What world would you like to visit?")
            
            HStack{
                SkyBoxButton(onClick: {
                    skyBoxSettings.currentSkybox = "Space"
                }, iconName: "network")
                
                SkyBoxButton(onClick: {
                    skyBoxSettings.currentSkybox = "Forest"
                }, iconName: "bolt.horizontal.fill")
                
                //SkyBoxButton(onClick: {
                    //skyBoxSettings.currentSkybox = "Station"
                //}, iconName: "moon") 
            }
        }
    }
}

#Preview {
    SkyBoxControlsView()
}

struct SkyBoxButton: View {
    
    var onClick: () -> Void
    var iconName: String
    
    var body: some View {
        Button(action: {
            onClick()
            
        },label: {
            Image(systemName: iconName)
        })
    }
}

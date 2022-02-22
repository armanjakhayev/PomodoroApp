import SwiftUI

struct AppView: View {
    init() { UITabBar.appearance().unselectedItemTintColor = UIColor.white }
    @State private var selectedTab: Int = 1
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack{
                    TabView(selection: $selectedTab) {
                        Main()
                            .tabItem {
                                Label("Main", systemImage: "house")
                            }
                            .tag(1)
                        Settings()
                            .tabItem {
                                Label("Settings", systemImage: "slider.horizontal.3")
                            }
                            .tag(2)
                    }
                    .accentColor(.white)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

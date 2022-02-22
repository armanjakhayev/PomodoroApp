import SwiftUI
    
struct Settings: View {
    @State var focusTimeInMinute: Int = 26
//    @Binding var focusTimeInSeconds: Int
    @State var breakTimeInMinute: Int = 6
//    @Binding var breakTimeInSeconds: Int
    var minutes = [Int](0..<60)
    
    var body: some View {
        VStack(spacing: 0){
            Text("Settings")
                .fontWeight(.bold)
                .padding(.top,56)
            HStack(spacing: 0){
                Text("Focus Time")
                Spacer()
                Picker(selection: $focusTimeInMinute, label: Text("")){
                    ForEach(0..<self.minutes.count) { index in
                        Text("\(self.minutes[index]) m").tag(index)
                    }.foregroundColor(.white)
                }
            }.padding(.trailing).padding(.top, 45)
            Divider()
                .frame(height: 0.5).background(Color.gray)
                .padding(.top, 11)
            HStack(spacing: 0){
                Text("Break Time")
                Spacer()
                Picker(selection: $breakTimeInMinute, label: Text("")){
                    ForEach(0..<self.minutes.count) { index in
                        Text("\(self.minutes[index]) m").tag(index)
                    }.foregroundColor(.white)
                }
            }.padding(.trailing).padding(.top, 21)
            Divider()
                .frame(height: 0.5).background(Color.gray)
                .padding(.top, 11)
            Spacer()
        }
        .font(.system(size: 17))
        .foregroundColor(.white)
        .padding(.leading)
        .background(Color("MyBlack"))
        .edgesIgnoringSafeArea(.all)
    }
}



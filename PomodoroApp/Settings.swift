import SwiftUI
    
struct Settings: View {
    @Binding var focusTimeInMinute: Int
    @Binding var breakTimeInMinute: Int
    var minutes = [Int](0..<60)
    @State var focusMinutes: Int = 25
    @State var breakMinutes: Int = 5

    var body: some View {
        
        VStack(spacing: 0){
                Text("Settings")
                    .fontWeight(.bold)
                    .padding(.top,56)
            HStack(spacing: 0){
                Text("Focus Time")
                Spacer()
                Picker(selection: $focusMinutes, label: Text("")){
                    ForEach(0..<self.minutes.count) { index in
                        Text("\(self.minutes[index]) m").tag(index)
                    }
                }
            }.padding(.trailing).padding(.top, 45)
            Divider()
                .frame(height: 0.5).background(Color.gray)
                .padding(.top, 11)
            HStack(spacing: 0){
                Text("Break Time")
                Spacer()
                Picker(selection: $breakMinutes, label: Text("")){
                    ForEach(0..<self.minutes.count) { index in
                        Text("\(self.minutes[index]) m").tag(index)
                    }
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
        .onChange(of: focusMinutes) { newValue in
            focusTimeInMinute = focusMinutes * 60

        }
        .onChange(of: breakMinutes) { newValue in
            breakTimeInMinute = breakMinutes * 60
        }
    }
}



import SwiftUI

struct Category: View {
    @Binding var isShowing: Bool
    @Binding var selectBG: String


    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                VStack{
                    Spacer()
                    FocusCategoryPanel
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local).onEnded({ value in
            if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                isShowing = false
            }
        }))
    }
    
    var FocusCategoryPanel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            Text("Focus Category")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(.bottom,318)
            bottomSheetHeader
            .padding(.bottom, 316)
            .padding(.horizontal,22)
            VStack {
                HStack(spacing: 20){
                    CustomButton(selectBG: $selectBG, text: "Work", selectImage: "BGWork")
                    CustomButton(selectBG: $selectBG, text: "Study", selectImage: "BGStudy")
                }.padding(.vertical,10)
                HStack(spacing: 20){
                    CustomButton(selectBG: $selectBG, text: "Workout", selectImage: "BG")
                    CustomButton(selectBG: $selectBG, text: "Reading", selectImage: "BGReading")
                }.padding(.vertical,10)
                HStack(spacing: 20){
                    CustomButton(selectBG: $selectBG, text: "Meditation", selectImage: "BGMeditation")
                    CustomButton(selectBG: $selectBG, text: "Others", selectImage: "BGOthers")
                }.padding(.vertical,10)
            }.padding(.top,40)
        }.frame(height: 390)
    }
    
    var bottomSheetHeader: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .onTapGesture {
                    isShowing = false
                }
        }
    }
}

struct CustomButton: View {
    @Binding var selectBG: String
    let text: String
    var selectImage: String
    
    var body: some View {
        Button(action: {
            selectBG = selectImage
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("LightGray"))
                    .frame(width: 172, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16).stroke(Color("DarkGray"), lineWidth: 1).frame(width: 172, height: 60))
                Text(text)
                    .foregroundColor(.black)
            }
        }
    }
}

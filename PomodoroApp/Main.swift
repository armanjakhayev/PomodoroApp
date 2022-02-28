import SwiftUI
import Combine

struct Main: View {
    @State var showCategorySheet = false
    @State var selectBG: String = "BG"
    @State var timeToShow = 1500
    @State var focusTimeInSeconds = 1500
    @State var breakTimeInSeconds = 300
    @State var isFocusTime = true
    @State var isWorking = false
    @State var start = false
    @State var to: CGFloat = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil

    let workPeriodLenght = 1500
    let breakPeriodLenght = 300
    
    var body: some View {
        NavigationView{
            ZStack{
                Image(selectBG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Button(action: {
                        self.showCategorySheet = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .opacity(0.3)
                            HStack{
                                Image(systemName: "pencil")
                                Text("Focus Caregory")
                            }
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        }.frame(width: 170, height: 36)
                    }.padding(.top,138)
                    ZStack{
                        ZStack{
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(Color.white.opacity(0.3), lineWidth: 6)
                                .frame(width: 248, height: 248)
                                .overlay(
                                    Circle()
                                        .trim(from: 0, to: (1 - to))
                                        .stroke(Color.white, lineWidth: 6)
                                        .rotationEffect(.init(degrees: -90)))
                            VStack(spacing: 4){
                                Text(convertSecondToTime(timeInSecond:timeToShow))
                                    .font(.system(size: 44, weight: .bold))
                                    .foregroundColor(.white)
                                Text(isFocusTime ? "Focus on your task" : "Break")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                        }
                    }.padding(.top,50)
                    .onReceive(timer) { _ in
                        if isWorking {
                            if isFocusTime {
                                if focusTimeInSeconds > 0 {
                                    let totalFocusSeconds = 1500.0
                                    focusTimeInSeconds -= 1
                                    timeToShow = focusTimeInSeconds
                                    to = (CGFloat(focusTimeInSeconds)/totalFocusSeconds)
                                } else {
                                    isFocusTime = false
                                    focusTimeInSeconds = workPeriodLenght
                                }
                            } else {
                                let totalBreakSeconds = 300
                                if breakTimeInSeconds > 0 {
                                    breakTimeInSeconds -= 1
                                    timeToShow = breakTimeInSeconds
                                    to = (CGFloat(self.breakTimeInSeconds) / CGFloat(totalBreakSeconds))
                                }
                                else {
                                    isWorking = false
                                    isFocusTime = true
                                }
                            }
                        }
                    }
                    HStack{
                        VStack{
                            Button(action: {
                                instantiateTimer()
                                self.start.toggle()
                                self.isWorking.toggle()
                            }){
                                ZStack{
                                    Circle()
                                        .fill(.white)
                                        .opacity(0.3)
                                        .frame(width: 56, height: 56)
                                    Image(systemName: self.start ? "pause.fill" : "play")
                                        .font(.system(size: 22.5, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal,40)
                        VStack{
                            Button(action: {
                                self.isWorking = false
                                self.start = false
                                resetCounter()
                                timeToShow = focusTimeInSeconds
                                self.to = 1
                            }){
                                ZStack{
                                    Circle()
                                        .fill(.white)
                                        .opacity(0.3)
                                        .frame(width: 56, height: 56)
                                    Image(systemName: "square.fill")
                                        .font(.system(size: 22.5, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal,40)
                    }
                    .padding(.top,60)
                    Spacer()
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: Settings( focusTimeInMinute: $focusTimeInSeconds, breakTimeInMinute: $breakTimeInSeconds)) {
                        ZStack {
                            VStack(spacing: 6){
                                Image(systemName: "slider.horizontal.3")
                                Text("Settings")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                            }.foregroundColor(.white)
                        }
                    }.navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(" ")
                        .padding(.bottom,50)
                }
                Category(isShowing: $showCategorySheet, selectBG: $selectBG)
            }
            .edgesIgnoringSafeArea(.all)
        }.accentColor(.white)
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
        
    func cancelTimer() {
        self.focusTimeInSeconds = 1500
        self.breakTimeInSeconds = 300
        self.connectedTimer?.cancel()
        return
    }
        
    func resetCounter() {
        self.focusTimeInSeconds = 1500
        self.breakTimeInSeconds = 300
        self.isFocusTime = true
        self.isWorking = false
        return
    }
        
    func restartTimer() {
        self.cancelTimer()
        self.instantiateTimer()
        return
    }
    
}

struct ButtonCategory: View {

    var body: some View {
        Button(action: {
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .opacity(0.3)
                HStack{
                    Image(systemName: "pencil")
                    Text("Focus Caregory")
                }
                .foregroundColor(.white)
                .font(.system(size: 16))
            }.frame(width: 170, height: 36)
        }
    }
}

func convertSecondToTime(timeInSecond: Int) -> String {
    let minutes = timeInSecond / 60
    let seconds = timeInSecond % 60
    
    return String (format: "%02d:%02d", minutes, seconds)
}

func getSecondfromMinutes(timeInMinutes: Int) -> Int {
    let minutes = timeInMinutes * 60
    return minutes
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

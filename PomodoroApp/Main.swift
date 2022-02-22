import SwiftUI
import Combine

struct Main: View {
    @State var showCategorySheet = false
    @State var selectBG: String = "BG"
    @State var timeToShow = 10
    @State var focusTimeInSeconds = 10
    @State var breakTimeInSeconds = 5
    @State var isFocusTime = true
    @State var isWorking = false
    @State var start = false
    @State var to: CGFloat = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    let workPeriodLenght = 5
    let breakPeriodLenght = 3

    var body: some View {
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
                }
                .padding(.bottom,52)
                ZStack{
                    ZStack{
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.white.opacity(0.3), lineWidth: 6)
                            .frame(width: 248, height: 248)
                            .overlay(
                                Circle()
                                    .trim(from: 0, to: (1.0 - to))
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
                }
                .onReceive(timer) { _ in
                    var totalSeconds = 10.0
                    if isWorking {
                        if isFocusTime {
                            if focusTimeInSeconds > 0 {
                                focusTimeInSeconds -= 1
                                timeToShow = focusTimeInSeconds
                                to = (CGFloat(self.focusTimeInSeconds) / CGFloat(totalSeconds))
                            } else {
                                isFocusTime = false
                                focusTimeInSeconds = workPeriodLenght
                                
                            }
                        } else {
                            totalSeconds = 5.0
                            if breakTimeInSeconds > 0 {
                                breakTimeInSeconds -= 1
                                timeToShow = breakTimeInSeconds
                                to = (CGFloat(self.breakTimeInSeconds) / CGFloat(totalSeconds))
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
                .padding(.bottom,160)
            }
            Category(isShowing: $showCategorySheet, selectBG: $selectBG)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
        
    func cancelTimer() {
        self.focusTimeInSeconds = 10
        self.breakTimeInSeconds = 5
        self.connectedTimer?.cancel()
        return
    }
        
    func resetCounter() {
        self.focusTimeInSeconds = 10
        self.breakTimeInSeconds = 5
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

func convertSecondToTime(timeInSecond: Int) ->String {
    let minutes = timeInSecond / 60
    let seconds = timeInSecond % 60
    
    return String (format: "%02d:%02d", minutes, seconds)
}


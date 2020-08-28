//
//  ContentView.swift
//  TrucoWatch WatchKit Extension
//
//  Created by Victoria Faria on 27/08/20.
//

import SwiftUI


struct FirstPage: View {

    @State var secondScreenShown = false
    @State var timerVal = 1

    var body: some View {
        ScrollView{
            VStack {
                Image("logo").resizable().frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                Spacer()

                Text("Bem vindo ao").font(Font.system(size: 18))
                Text("Truco Watch").font(Font.system(size: 20)).bold()
            }
        }
    }
}

struct SecondView: View {

    @State var secondScreenShown = false
    @State var timerVal = 1

    var body: some View {
        ScrollView{
            VStack {
                Text("Todos prontos?").font(Font.system(size: 17)).bold()
                Text("3 cartas é o jogo!").font(Font.system(size: 15))
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                NavigationLink(
                    destination: PlayView(playScreenShown: $secondScreenShown, timerVal: timerVal),
                    isActive: $secondScreenShown,
                    label: {
                        Text("Nova Partida")
                    })
            }
        }
    }
}

struct PlayView: View {

    @Binding var playScreenShown: Bool
    @State var timerVal = 1

    @State var counterWe = 0
    @State var counterThey = 0


    var body: some View {
        VStack{
            Text("Placar").font(Font.system(size: 15))
            Spacer()
            HStack{
                Spacer()
                Text("Nós").font(Font.system(size: 18))
                Spacer()
                Text("Eles").font(Font.system(size: 18))
                Spacer()
            }
            HStack{
                Spacer()
                Text("\(counterWe)").font(Font.system(size: 23)).bold()
                Spacer()
                Text("\(counterThey)").font(Font.system(size: 23)).bold()
                Spacer()
            }
            Spacer()
            HStack{
                Button(action: {
                    self.counterWe += 1
                }, label: {
                    Text("+")
                })
                Button(action: {
                    self.counterThey += 1
                }, label: {
                    Text("+")
                })
            }
        }
    }
}

// ----------- Page control ---------------
struct PagerManager<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    //Set the initial values for the variables
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    @GestureState private var translation: CGFloat = 0

    //Set the animation
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)


            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}


struct ContentView: View {
    @State private var currentPage = 0

    var body: some View {

        //Pager Manager
        VStack{
            PagerManager(pageCount: 2, currentIndex: $currentPage) {
                FirstPage()
                SecondView()
            }

            Spacer()

            //Page Control
            HStack{
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage==1 ? Color.gray:Color.white)
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage==1 ? Color.white:Color.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

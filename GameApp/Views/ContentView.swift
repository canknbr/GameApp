//
//  ContentView.swift
//  GameApp
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State var isShowInfo = false
    @State var reels: Array = [0, 1, 2]
    @State var highScore: Int = UserDefaults.standard.integer(forKey: "highscore")
    @State var coins: Int = 100
    @State var betAmount: Int = 10
    @State var isActivateBet10: Bool = true
    @State var isActivateBet20: Bool = false
    @State var showingModal: Bool = false
    @State var animatingSymbol: Bool = false
    @State var animatingModal: Bool = false
    let feedback = UINotificationFeedbackGenerator()
    func spinReels() {
        reels = reels.map({ _ in
            Int.random(in: 0 ... symbols.count - 1)
        })
        playSound(soundName: "spin", soundType: "mp3")
        feedback.notificationOccurred(.success)
    }

    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            playerWins()
            if coins > highScore {
                newHighScore()
            }
            playSound(soundName: "win", soundType: "mp3")
        } else {
            playerLoses()
        }
    }

    func playerWins() {
        coins += betAmount * 10
    }

    func newHighScore() {
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "highscore")
        playSound(soundName: "high-score", soundType: "mp3")
    }

    func playerLoses() {
        coins -= betAmount
    }

    func activateBet20() {
        betAmount = 20
        isActivateBet20 = true
        isActivateBet10 = false
        playSound(soundName: "casino-chips", soundType: "mp3")
        feedback.notificationOccurred(.success)
    }

    func activateBet10() {
        betAmount = 10
        isActivateBet10 = true
        isActivateBet20 = false
        playSound(soundName: "casino-chips", soundType: "mp3")
        feedback.notificationOccurred(.success)
    }

    func isGameOver() {
        if coins <= 0 {
            showingModal = true
            playSound(soundName: "game-over", soundType: "mp3")
        }
    }

    func resetGame() {
        UserDefaults.standard.set(0, forKey: "highscore")
        highScore = 0
        coins = 100
        activateBet10()
        playSound(soundName: "chimeup", soundType: "mp3")
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                Spacer()
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }.modifier(ScoreContainerModifier())
                    Spacer()
                    HStack {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)

                    }.modifier(ScoreContainerModifier())
                }

                VStack(alignment: .center, spacing: 0) {
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5 ... 0.7)), value: animatingSymbol)
                            .onAppear {
                                animatingSymbol.toggle()
                                playSound(soundName: "riseup", soundType: "mp3")
                            }
                        
                    }
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7 ... 0.9)), value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }
                        }
                        Spacer()
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9 ... 1.1)), value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }
                        }
                    }
                    .frame(maxWidth: 500)

                }.layoutPriority(2)
                Button {
                    withAnimation {
                        animatingSymbol = false
                    }
                    spinReels()
                    withAnimation {
                        animatingSymbol = true
                    }
                    checkWinning()
                    isGameOver()
                } label: {
                    Image("gfx-spin")
                        .resizable()
                        .renderingMode(.original)
                        .modifier(ImageModifier())
                }

                Spacer()

                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            activateBet20()
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivateBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActivateBet20 ? 0 : 20)
                            .opacity(isActivateBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                        Spacer()
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActivateBet10 ? 0 :-20)
                            .opacity(isActivateBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        Button {
                            activateBet10()
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivateBet10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                    }
                }.padding()
            }
            .overlay(
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")

                })
                .modifier(ButtonModifier())
                .padding(.leading, -10)
                .padding(.top, -5)
                , alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    isShowInfo.toggle()
                }, label: {
                    Image(systemName: "info.circle")

                }).sheet(isPresented: $isShowInfo, content: {
                    InfoView()
                })
                .modifier(ButtonModifier())
                .padding(.trailing, -10)
                .padding(.top, -5)
                , alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 820)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)

            if $showingModal.wrappedValue {
                ZStack {
                    Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)).edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0) {
                        Text("Game Over")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        Spacer()

                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad luck! You lost all of the coins.\nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)

                            Button {
                                showingModal = false
                                animatingModal = false
                                activateBet10()
                                coins = 100
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .tint(.accentColor)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .stroke(Color("ColorPink"), lineWidth: 2)
                                    )
                            }
                        }
                        Spacer()

                    }.frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 270, maxHeight: 280, alignment: .center)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                        .opacity($animatingModal.wrappedValue ? 1 : 0)
                        .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                        .animation(.spring(response: 0.6,dampingFraction: 1.0,blendDuration: 1.0), value: animatingModal)
                        .onAppear {
                            animatingModal = true
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

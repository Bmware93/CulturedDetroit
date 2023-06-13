//
//  DetroitDialView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct DetroitDialView: View {
    @ObservedObject var vm: DestinationsViewModel
    var body: some View {
        VStack {
            CircularProgressView(vm: vm)
        }
    }
}


struct CircularProgressView: View {
    @ObservedObject var vm: DestinationsViewModel
    var body: some View {
        VStack {
            Text("Downtown")
                .font(.title).bold()
                .padding(.bottom, 30)
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                LinearGradient(
                    gradient: gradientColors(),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .mask({
                    Circle()
                        .trim(from: 0.0, to: CGFloat(vm.progress))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                })
                 .rotationEffect(Angle(degrees: -90))
                
                LinearGradient(
                    gradient: gradientColors(),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask({
                    Text("\(Int(vm.progress * 100))%")
                        .font(.largeTitle)
                        .bold()
                })
            }
        }
        .padding(80)
    }
    private func gradientColors() -> Gradient {
        let colors: [Color] = [.purple, .red, .orange, .yellow, .indigo]
        return Gradient(colors: colors)
        }
}


struct DetroitDialView_Previews: PreviewProvider {
    static var previews: some View {
        DetroitDialView(vm: DestinationsViewModel())
    }
}

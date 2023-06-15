//
//  AnnotationView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 6/1/23.
//

import SwiftUI

struct AnnotationView: View {
    @State private var showTitle = true
    var destination: Destination
    
    var body: some View {
        VStack(spacing: 0) {
            Text(destination.name)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "questionmark.circle.fill")
                .font(.title)
                .foregroundColor(.gray)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.gray)
                .offset(x: 0, y: -5)
        }
//        .onTapGesture {
//            withAnimation(.easeInOut) {
//                showTitle.toggle()
//            }
//        }
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView(destination: Destination(id: "123", name: "Pizza Cat", coordinates: DestionationCoordinates(latitude: 0.0, longitude: 0.0), review_count: 123, rating: 2.3, location: Businesslocation(address1: "123", city: "Det", zip_code: "48204", state: "MI"), display_phone: "123-123-1234"))
    }
}

//
//  BusinessDetailView.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 6/15/23.
//

import SwiftUI


struct BusinessDetailView: View {
    var destination: Destination
    
    @State private var button = true
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                AsyncImage(url: destination.image_url) { image in
                    image.image?.resizable()
                }
                .frame(width: 350, height: 250)
                .scaledToFit()
                .cornerRadius(10)
                .padding()
                .aspectRatio( contentMode: .fit)
                
                
                HStack {
                    Text(destination.name)
                        .padding(.horizontal)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .padding(.trailing,3)
                        .foregroundColor(.yellow)
                    
                    Text(String(destination.rating))
                        .font(.footnote)
                    Text( "(" + String(destination.review_count) + ")")
                        .padding(.trailing, 15)
                        .font(.footnote)
                }
                
                HStack {
                    Text(destination.location.address1)
                        .padding(.leading)
                    Text(destination.location.city + ",")
                    Text(destination.location.state)
                }
                .padding(.bottom,5)
                
                
                HStack {
                    Image(systemName: "phone")
                        .font(.headline)
                        .padding(.leading)
                    
                    
                    Text(destination.display_phone)
                }
                
                
                
                
                
                
                Spacer()
                
            }
            
            //            if button {
            //                Button("Click Me!") {
            //                    switchButton()
            //                }
            //            } else {
            //                Button("New Button!") {
            //                    // Action for the new button
            //                    print("You pressed the new button!")
            //                }
            if button {
                Button {
                    switchButton()
                }label: {
                    Text("Start Journey")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                Spacer()
            } else {
                Button {
                    // MARK: Place completeTask Function here
//                    switchButton()
                }label: {
                    Text("Complete")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
            }
        }
    }
    func switchButton() {
        button = false
    }
}



struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetailView(destination: Destination(id: "123", name: "Parc Detroit", coordinates: DestionationCoordinates(latitude: 0.0, longitude: 0.0 ), review_count: 123, rating: 5.7, location: Businesslocation(address1: "800 Woodward Ave", city: "Detroit", zip_code: "48204", state: "MI"), display_phone: "(281) 330-8004"))
    }
}

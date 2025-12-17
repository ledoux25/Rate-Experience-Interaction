//
//  RatingStars.swift
//  ExpolanRatingComponent
//
//  Created by Sanguo Joseph Ledoux on 12/17/25.
//

import SwiftUI

struct RatingStars: View {
    @Binding var rating: Int
    var body: some View {
        HStack(){
            ZStack(alignment: .leading) {
                GeometryReader{ proxy in
                    LinearGradient(
                        stops: [
                            .init(color: .orange, location: 0.0),
                            .init(color: .yellow.opacity(0.9), location: 0.2),
                            .init(color: .green.opacity(0.9), location: 0.8),
                            .init(color: .clear, location: 1.1)
                        ], startPoint: .leading, endPoint: .trailing
                    )
                    .blur(radius: 15)
                    .scaleEffect(x:CGFloat(Double(rating)/5.0), y:1, anchor: .leading)
                    .frame(alignment: .leading)
                    
                }
                HStack {
                    ForEach(1...5, id: \.self){ index in
                        
                        Image(systemName: "star.fill")
                            .foregroundStyle(index <= rating ? .white : .gray)
                            .onTapGesture {
                                withAnimation(.bouncy(duration:0.5)){
                                    
                                    if rating == index {
                                        rating = 0
                                    }else{
                                        rating = index
                                    }
                                    
                                }
                                
                                
                                
                            }
                        
                        if index < 5{
                            Spacer()
                        }
                        
                    }
                }
                .padding(.horizontal,20)
            }
            
        }
        .frame(maxHeight: 50)
        .background(.black.opacity(0.5))
        .clipShape(.rect(cornerRadius: 18))
    }
}


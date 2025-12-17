//
//  ContentView.swift
//  ExpolanRatingComponent
//
//  Created by Sanguo Joseph Ledoux on 12/16/25.
//

import SwiftUI
import WrappingHStack

struct GetHeightModifier: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    withAnimation(.bouncy(duration:1)){
                        height = geo.size.height
                    }
                }
                return Color.clear
            }
        )
    }
}

struct ContentView: View {
    @State private var isPresented: Bool = true
    @State private var rating: Int = 0
    @State private var sheetHeight: CGFloat = 0
    @State private var comment = ""
    @State private var selectedTag = ""
    let tagLabels = ["Energy Prediction", "Magic Planner", "Design","Speed", "Animations"]
    var ratingTitle: String {
        return rating > 3 ? "What did you like the most ?" : "What can be improved ?"
    }
    var isRating : Bool {
        return rating > 0
    }
    var body: some View {

                
        ZStack(alignment: .bottom, ){
            Color.black
                
                    VStack{
                        VStack(alignment: .leading, ){
                            ZStack{
                                Group{
                                    Image(systemName: "pencil.and.outline")
                                        .foregroundStyle(Color.white)
                                }
                                .frame(width: 45, height: 45)
                                .background{
                                    LinearGradient(stops: [
                                        .init(color: .white, location: 0.0),
                                        .init(color: .black, location: 0.5)
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .blur(radius: 10)
                                    
                                }
                                .clipShape(.rect(cornerRadius: 18))
                                .rotationEffect(.degrees(18))
                                .offset(x: isRating ? 40 : 0)
                                .scaleEffect(0.95)
                                
                                
                                Group{
                                    Image(systemName: "star.bubble.fill")
                                        .foregroundStyle(Color.black.opacity(0.85))
                                }
                                .frame(width: 45, height: 45)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 18))
                                .rotationEffect(.degrees(isRating ? -18 : 0))


                            }


                            
                            
                            Text("Rate Your Experience")
                                .font(.title2.bold())
                            

                            RatingStars(rating: $rating)
                                .padding(.bottom,10)
                            

                            
                            Group{
                                if isRating {
                                    VStack(alignment: .leading, ) {
                                        Text(ratingTitle)
                                            .font(.headline.bold())
                                            .padding(.vertical,10)
                                        
                                        
                                        
                                        HStack{
                                            
                                        }
                                        
                                        TextField("", text: $comment, prompt:Text("Write a comment").foregroundStyle(.gray))
                                            .safeAreaInset(edge: .leading, content: {Image(systemName: "pencil.and.outline")})
                                            .padding(.horizontal)
                                            .padding(.vertical,15)
                                            .background(.white.opacity(0.1))
                                            .cornerRadius(18)
                                            .foregroundStyle(.white)
                                        
                                        
                                        WrappingHStack( tagLabels, id: \.self, lineSpacing: 10) { tag in
                                            Text(tag)
                                                .padding(8)
                                                .fontWeight(.medium)
                                                .background(selectedTag == tag ? .white :.white.opacity(0.1))
                                                .foregroundColor(selectedTag == tag ? .black : .white.opacity(0.85))
                                                .font(.subheadline)
                                                .cornerRadius(12)
                                                .onTapGesture{
                                                    withAnimation{
                                                        if selectedTag == tag {
                                                            selectedTag = ""
                                                        }else{
                                                            selectedTag =  tag
                                                        }
                                                    }
                                                }
                                        }
                                        .padding(.vertical,10)
                                    }
                                    .transition(.asymmetric(insertion: .offset(x:0,y:100).combined(with: .opacity), removal: .offset(x:0,y:200).combined(with: .opacity)))
                                }
                            }
                            
                            
                            
                            Group {
                                Button(isRating ? "Submit" :"Cancel"){
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background( isRating ? .white :.white.opacity(0.1))
                                .clipShape(.rect(cornerRadius: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(isRating ? .black : .white)
                            }

                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(15)
                        
                    }
                    .foregroundStyle(.white)
                    .ignoresSafeArea()
                    .background(.gray.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 28))
                    .padding(.horizontal,8)
                    .padding(.bottom,40)
                }
        .ignoresSafeArea()
        
            }

        }
        

#Preview {
    ContentView()
}

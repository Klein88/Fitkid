//
//  HonorView.swift
//  Fit Kid  use pod
//
//  Created by 许鹏程 on 2023/6/27.
//

import SwiftUI


struct HonorView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    

    var body: some View {
       ZStack {
          BlurView(style: .systemMaterial)

          TitleView()
             .blur(radius: show ? 20 : 0)
             .animation(.default)

          CardBottomView()
             .blur(radius: show ? 20 : 0)
             .animation(.default)

          CardView()
             .background(show ? Color.red : Color("background9"))
             .cornerRadius(10)
             .shadow(radius: 20)
             .offset(x: 0, y: show ? -400 : -40)
             .scaleEffect(0.85)
             .rotationEffect(Angle(degrees: show ? 15 : 0))
             .blendMode(.hardLight)
             .animation(.easeInOut(duration: 0.6))
             .offset(x: viewState.width, y: viewState.height)

          CardView()
             .background(show ? Color("background5") : Color("background8"))
             .cornerRadius(10)
             .shadow(radius: 20)
             .offset(x: 0, y: show ? -200 : -20)
             .scaleEffect(0.9)
             .rotationEffect(Angle(degrees: show ? 10 : 0))
             .blendMode(.hardLight)
             .animation(.easeInOut(duration: 0.4))
             .offset(x: viewState.width, y: viewState.height)

          CertificateView()
             .offset(x: viewState.width, y: viewState.height)
             .scaleEffect(0.95)
             .rotationEffect(Angle(degrees: show ? 5 : 0))
             .animation(.spring())
             .onTapGesture {
                self.show.toggle()
             }
             .gesture(
                DragGesture()
                   .onChanged { value in
                      self.viewState = value.translation
                      self.show = true
                   }
                   .onEnded { _ in
                      self.viewState = CGSize.zero
                      self.show = false
                   }
             )
       }
    }
}

struct HonorView_Previews: PreviewProvider {
    static var previews: some View {
        HonorView()
    }
}

struct CardView: View {
   var body: some View {
      return VStack {
         Text("待添加")
            .foregroundColor(.black)
      }
      .frame(width: 340.0, height: 220.0)
   }
}

struct CertificateView: View {

   var item = Certificate(title: "奖章", image: "Certificate1", width: 340, height: 220)

   var body: some View {
      return VStack {
         HStack {
            VStack(alignment: .leading) {
               Text(item.title)
                  .font(.headline)
                  .fontWeight(.bold)
                  .foregroundColor(Color("accent"))
                  .padding(.top)

               Text("Card")
                  .foregroundColor(.white)
            }
            Spacer()

        }
         .padding(.horizontal)
         Spacer()

         Image(item.image)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .offset(y: 50)
      }
      .frame(width: CGFloat(item.width), height: CGFloat(item.height))
      .background(Color.black)
      .cornerRadius(10)
      .shadow(radius: 10)
   }
}

struct TitleView: View {
    @Environment(\.presentationMode) var presentationMode
   var body: some View {
      return VStack {
         HStack {

                 
            Text("奖章🎖️")
               .foregroundColor(.black)
               .font(.largeTitle)
               .fontWeight(.heavy)

            Spacer()
             Button(action: {
                 presentationMode.wrappedValue.dismiss()
             }, label: {
                 Image(systemName: "x.circle")
                     .font(.title)
                     .foregroundColor(.black)
             })
         }
//         Image("Illustration5")

         Spacer()
      }.padding()
   }
}

struct CardBottomView: View {
   var body: some View {
      return VStack(spacing: 50.0) {
         Rectangle()
            .foregroundColor(.gray)
            .frame(width: 60, height: 6)
            .cornerRadius(3.0)
            .opacity(0.1)

          ScrollView(.vertical, showsIndicators: false){
              Text("这里将展示您账户下同类型的奖章")
                  .foregroundColor(.black)
                  .lineLimit(nil)
          }

         Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity)
      .padding()
      .padding(.horizontal)
      .background(BlurView(style: .systemMaterial))
      .cornerRadius(30)
      .shadow(radius: 20)
      .offset(y: UIScreen.main.bounds.height - 215)
   }
}

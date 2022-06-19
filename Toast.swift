import SwiftUI


struct ToastModify: ViewModifier {
    @Binding var isShow: Bool
    var message: String = ""
    var icon: String = ""
    func body(content: Content) -> some View {
        ZStack{
            content
            toastView
        }
    }
    private var toastView: some View {
        ZStack{
            if isShow{
                VStack{
                    if icon != ""{
                        Image(systemName: icon).resizable().scaledToFit().foregroundColor(Color(NSColor.textBackgroundColor))
                    }
                    if message != ""{
                        Text(message).foregroundColor(Color(NSColor.textBackgroundColor)).font(.title3)
                    }
                }.frame(width: 150, height: 150, alignment: .center).padding(35)
                    .background(Color(NSColor.textColor)).cornerRadius(20)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1)) {
                            isShow = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                            self.isShow = false
                        })
                }
            }
        }
    }
}
extension View {
    func toast(message: String, isShow: Binding<Bool>, icon: String) -> some View {
        self.modifier(ToastModify(isShow: isShow, message: message, icon: icon))
    }
}

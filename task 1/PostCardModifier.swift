import SwiftUI


struct PostCardModifier: ViewModifier {
    @State private var isReplying = false
    @State var replyText = ""
   
    

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if isReplying {
                    TextField("Add a reply", text: $replyText)
                        .onSubmit {
                            _ = Reply(authorName: "Srivatsa", replyContent: replyText, timestamp: Date())
                            isReplying = false
                            replyText = ""
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Button("Reply") {
                        isReplying = true
                    }
                }
            }
    }
}

import SwiftUI
struct CommentView: View {
    @State private var isSelected: Bool = false
    let isPost: Bool = false
    let reply: Reply
    @State private var newReplyText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(reply.authorName)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.226863414, green: 0.368391633, blue: 0.7132768035, alpha: 1)))
                Spacer()
                Menu {
                    Button("Report User") {
                        
                    }
                    Button("Report Message") {
                    }
                    Button(action: {
                        UIPasteboard.general.string = reply.replyContent
                    }) {
                        Text("Copy")
                        
                    }
                } label: {
                    Image("dots")
                }
            }
            if numberOfWords(in: reply.replyContent) > 8 {
                if isSelected {
                    Text(reply.replyContent)
                        .font(.body)
                    Button(action: {
                        isSelected.toggle()
                    }) {
                        Text("see less")
                            .foregroundColor(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)))
                        
                    }
                } else {
                    Text(String(reply.replyContent.split(separator: " ").prefix(8).joined(separator: " ")))
                        .font(.body)
                    
                    Button(action: {
                        isSelected.toggle()
                    }) {
                        Text("see more")
                            .foregroundColor(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)))
                        
                    }
                }
            } else {
                Text(reply.replyContent)
                    .font(.body)
            }
            
            if !reply.replies.isEmpty {
                ForEach(reply.replies) { childReply in
                    CommentView(reply: childReply)
                        .padding(.leading, 20)
                }
            }
            
            if isPost {
                HStack {
                    TextField("Add a reply", text: $newReplyText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        onReplyAppended(text: newReplyText)
                        newReplyText = ""
                    }) {
                        Text("Send")
                    }
                }
                .padding(.top)
            }
        }
        .padding(15)
    }
    
    func numberOfWords(in text: String) -> Int {
        let words = text.split(separator: " ")
        return words.count
    }
    
    func onReplyAppended(text: String) {
        let newReply = Reply(id: UUID(), authorName: "You", replyContent: text, timestamp: Date())
        reply.replies.append(newReply)
    }
}




struct CommentsView: View {
    let comments: [Reply]
    let onReply: (String) -> Void
    @Binding var showAllReplies: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(showAllReplies ? comments : Array(comments.prefix(2))) { reply in
                CommentView(reply: reply)
                    .padding(.horizontal)
            }
            if comments.count > 0 {
                Button(action: {
                    withAnimation {
                        showAllReplies.toggle()
                    }
                }) {
                    Image("slider")
                }
            }
        }
    }
}


struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(reply: Reply(id: UUID(), authorName: "Tester", replyContent: "hello", likeCount: 20, isLiked: true, replies: [Reply(authorName: "Srivatsa", replyContent: "HI, MY NAME IS SRIVATSA DAVULURI lsd fjsdkjl skdf jsd jfksdfk jfsd kfjsdklfjsjlkfsd kljfsljkdfk jsdklj fl sd lfsd", timestamp: Date())], timestamp: Date()))
        
    }
}





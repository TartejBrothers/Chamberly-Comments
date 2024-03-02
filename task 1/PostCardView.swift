import SwiftUI

struct PostCardView: View {
    @State private var showAllReplies = false
    @State private var isLiked: Bool = false
    @Binding var post: Post
    @State private var replyText = ""
    @State private var showReplyField = false
    
    func onAddReply() {
        if !replyText.isEmpty {
            post.addReply(text: replyText)
            showReplyField = false
            replyText = ""
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: -10) {
                CommentView(reply: Reply(id: post.id, authorName: post.authorName, replyContent: post.content, timestamp: post.comments.first?.timestamp ?? Date()))
                
                HStack(spacing: 20) {
                    HStack(spacing: 3) {
                        Button {
                            isLiked.toggle()
                            if isLiked {
                                post.totalLikes += 1
                            } else {
                                post.totalLikes -= 1
                            }
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        Text("\(post.totalLikes)")
                    }
                    
                    HStack(spacing: 3) {
                        Button(action: {
                            showReplyField.toggle()
                        }) {
                            Image("reply_button")
                                .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                        }
                        Text("\(post.comments.count)")
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                
                if showReplyField {
                    HStack (spacing: 30) {
                        ScrollView{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 175, height: 50)
                                .padding(.horizontal,5)
                                .padding(.vertical,15)
                                .foregroundColor(.white)
                                .shadow(color: Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)), radius: 1)
                                .overlay(
                                    TextField("Write your reply...", text: $replyText, axis: .vertical)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .padding(.horizontal,10)
                                        .foregroundColor(.black)
                                )
                        }
                        Button(action: {
                            onAddReply()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                if !post.comments.isEmpty {
                    if showAllReplies {
                        CommentsView(
                            comments: post.comments,
                            onReply: { replyText in
                                let newReply = Reply(id: UUID(), authorName: "You", replyContent: replyText, timestamp: Date())
                                post.comments.append(newReply)
                            },
                            showAllReplies: $showAllReplies
                        )
                        .padding(.bottom, 20)
                    } else {
                        VStack{
                            Button(action: {
                                withAnimation{
                                    showAllReplies.toggle()
                                }
                            }) {
                                Image("slider")
                                    
                                    
                                    
                            }.padding(.top, 10.0)
                            .padding(.leading, 20.0)
                            .padding(.bottom, 10.0)
                                
                        }
                        .frame(maxWidth: .infinity ,alignment: .center)
                            
                           
                    }
                }
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 0.5)
        }
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(content: "Sample content", authorName: "John", comments:[Reply(authorName: "Alice", replyContent: "sample content 2", timestamp: Date())], totalLikes: 10)
        return PostCardView(post: .constant(post))
    }
}

import Foundation

class Post: Identifiable, ObservableObject, Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    let id = UUID()
    let content: String
    var authorName: String
    @Published var comments: [Reply]
    var totalLikes: Int
    let timestamp: Date

    init(content: String, authorName: String, comments: [Reply] = [], totalLikes: Int = 0,timestamp: Date = Date()) {
        self.content = content
        self.authorName = "Hello"
        self.comments = comments
        self.totalLikes = totalLikes
        self.timestamp = timestamp
        
    }

    func addReply(text: String) {
            let timestamp = Date()
            let newReply = Reply(id: UUID(), authorName: "You", replyContent: text, timestamp: Date())
            comments.insert(newReply, at: 0)
        }
}



class Reply: Identifiable {
    let id: UUID
    let authorName: String
    let replyContent: String
    let timestamp: Date
    var likeCount: Int
    var isLiked: Bool
    var replies: [Reply]

    init(id: UUID = UUID(), authorName: String, replyContent: String, likeCount: Int = 0, isLiked: Bool = false, replies: [Reply] = [], timestamp: Date) {
        self.id = id
        self.authorName = authorName
        self.replyContent = replyContent
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.replies = replies
        self.timestamp = timestamp
    }
}

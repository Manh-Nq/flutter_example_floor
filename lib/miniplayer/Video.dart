class UserVideo {
  final String username;
  final String profileImageUrl;
  final String subscribers;

  const UserVideo({
    required this.username,
    required this.profileImageUrl,
    required this.subscribers,
  });
}
const UserVideo currentUser = UserVideo(
  username: 'Marcus Ng',
  profileImageUrl:
  'https://yt3.ggpht.com/ytc/AAUvwniE2k5PgFu9yr4sBVEs9jdpdILdMc7ruiPw59DpS0k=s88-c-k-c0x00ffffff-no-rj',
  subscribers: '100K',
);

class Video {
  final String id;
  final UserVideo author;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final DateTime timestamp;
  final String viewCount;
  final String likes;
  final String dislikes;

  const Video({
    required this.id,
    required this.author,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.timestamp,
    required this.viewCount,
    required this.likes,
    required this.dislikes,
  });
}


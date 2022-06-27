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
  username: 'Animal',
  profileImageUrl: 'https://www.flaticon.com/free-icon/poster_252341',
  subscribers: '100tr',
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
List<Video> fakeItems() {
  List<Video> videos=[];
  for(int i=0; i<10;i++){
    videos.add(fakeVideo());
  }

  return videos;
}

Video fakeVideo(){
  return  Video(
    id: 'x606y4QWrxo',
    author: currentUser,
    title: 'this is animal in animal world',
    thumbnailUrl:
    'https://images.pexels.com/photos/751829/pexels-photo-751829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    duration: '8:20',
    timestamp: DateTime(2021, 3, 20),
    viewCount: '10K',
    likes: '958',
    dislikes: '4',
  );
}

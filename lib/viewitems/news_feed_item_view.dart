import 'package:flutter/material.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/images.dart';

class NewsFeedItemView extends StatelessWidget {

  final NewsFeedVO? mNewsFeed;
  final Function(int) onTapDelete;

  const NewsFeedItemView({
    Key? key,
    required this.mNewsFeed,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfileImageView(
              profileImage: mNewsFeed?.profilePicture ?? "",
            ),
            const SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              userName: mNewsFeed?.userName ?? "",
            ),
            Spacer(),
            MoreButtonView(
              onTapDelete: () {
                onTapDelete(mNewsFeed?.id ?? 0);
              },
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Visibility(
          visible: ((mNewsFeed?.postImage ?? "").isNotEmpty),
          child: PostImageView(
            postImage: mNewsFeed?.postImage ?? "",
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostDescriptionView(
          description: mNewsFeed?.description ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            Text(
              "See Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.mode_comment_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {

  final String description;


  PostDescriptionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      // "You're bound to find the perfect beach caption to complement the stunning landscapes, golden hour selfies, and silly group photos filling your camera roll. Joke lovers will scream \"shell yeah!\"",
      description,
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {

  final String postImage;


  PostImageView({required this.postImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        placeholder: NetworkImage(
          NETWORK_IMAGE_POST_PLACEHOLDER,
        ),
        image: NetworkImage(
          // "https://images.unsplash.com/photo-1591266360949-c54e3296de4c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VhJTIwdmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
          postImage,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;

  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: Text("Edit"),
          value: 1,
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          child: const Text("Delete"),
          value: 2,
        )
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {

  final String profileImage;

  ProfileImageView({required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        // "https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg",
        profileImage,
      ),
      radius: MARGIN_LARGE,
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {

  final String userName;

  NameLocationAndTimeAgoView({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              "- 2 hours ago",
              style: TextStyle(
                fontSize: TEXT_SMALL,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Paris",
          style: TextStyle(
            fontSize: TEXT_SMALL,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy_json_app/core/extensions/fp_async_value.dart';
import 'package:dummy_json_app/core/extensions/localizations_extension.dart';
import 'package:dummy_json_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dummy_json_app/src/features/user/presentation/providers/user_provider.dart';

class UserProfileScreen extends ConsumerWidget {
  static const String name = 'user_profile_screen';
  static const String route = 'user_profile_screen';

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(getUserProvider);

    final l10n = context.l10n;

    return userProvider.mapEither(
      data: (data) {
        final user = data.value;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(l10n.profile),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      UserProfileImage(imageUrl: user.image),
                      const SizedBox(height: 10),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: Styles.titleTextStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${user.age} ${l10n.years}, ${user.gender}',
                        style: Styles.subtitleTextStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                UserInfoCard(
                  title: l10n.contactInfo,
                  children: [
                    UserInfoRow(
                      icon: Icons.email,
                      label: l10n.email,
                      value: user.email,
                    ),
                    const Divider(),
                    UserInfoRow(
                      icon: Icons.phone,
                      label: l10n.phone,
                      value: user.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                UserInfoCard(
                  title: l10n.personalInfo,
                  children: [
                    UserInfoRow(
                      icon: Icons.cake,
                      label: l10n.birthdate,
                      value:
                          '${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}',
                    ),
                    const Divider(),
                    UserInfoRow(
                      icon: Icons.perm_identity,
                      label: l10n.id,
                      value: user.id.toString(),
                    ),
                    const Divider(),
                    UserInfoRow(
                      icon: Icons.male,
                      label: l10n.gender,
                      value: user.gender,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: (_) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error) => Scaffold(
        body: Center(
          child: Text(error.error.toString()),
        ),
      ),
    );
  }
}

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.cardTitleTextStyle,
              ),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(width: 10),
        Text(
          '$label:',
          style: Styles.detailLabelTextStyle,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: Styles.detailValueTextStyle,
          ),
        ),
      ],
    );
  }
}

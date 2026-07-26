import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GlassAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final VoidCallback? onTap;

  const GlassAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 80,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.glassWhite,
          borderRadius: BorderRadius.circular(size * 0.35),
          border: Border.all(color: AppColors.glassBorder, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.glassShadow,
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(size * 0.35),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildFallback();
                  },
                ),
              )
            : _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    final initials = _getInitials(name);
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}

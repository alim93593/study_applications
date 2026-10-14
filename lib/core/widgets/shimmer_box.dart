import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// تأثير Shimmer (وميض متحرك) مبسط بدون باكدجات خارجية.
/// Why: skeletons ثابتة كانت تبان كصناديق ميتة — الوميض يوحي بتحميل حيّ.
/// StatefulWidget مسموح هنا حسب AGENTS (ملكية AnimationController).
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    required this.child,
    this.borderRadius = 16,
  });

  final Widget child;
  final double borderRadius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.colors.mutedCard;
    final highlight = context.colors.card;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + _controller.value * 2.0, 0),
              end: Alignment(-0.4 + _controller.value * 2.0, 0),
              colors: [base, highlight, base],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class GetPetsButton extends StatefulWidget {
  final String? selectedAnimalType;
  final VoidCallback? onPressed;
  final bool isLoading;

  const GetPetsButton({
    super.key,
    required this.selectedAnimalType,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<GetPetsButton> createState() => _GetPetsButtonState();
}

class _GetPetsButtonState extends State<GetPetsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getAnimalEmoji(String? animalType) {
    if (animalType == null) return '🐾';

    switch (animalType.toLowerCase()) {
      case 'dog':
        return '🐕';
      case 'cat':
        return '🐱';
      case 'rabbit':
        return '🐰';
      case 'bird':
        return '🐦';
      default:
        return '🐾';
    }
  }

  Color _getAnimalColor(String? animalType) {
    if (animalType == null) return const Color(0xFF6B73FF);

    switch (animalType.toLowerCase()) {
      case 'dog':
        return const Color(0xFF8B4513);
      case 'cat':
        return const Color(0xFFFF8C00);
      case 'rabbit':
        return const Color(0xFF708090);
      case 'bird':
        return const Color(0xFF4169E1);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  String _getButtonText() {
    if (widget.isLoading) return 'Mencari...';
    if (widget.selectedAnimalType != null) {
      return 'Cari ${widget.selectedAnimalType}';
    }
    return 'Cari Hewan Peliharaan';
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final animalColor = _getAnimalColor(widget.selectedAnimalType);
    final animalEmoji = _getAnimalEmoji(widget.selectedAnimalType);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: animalColor.withAlpha(
              (isEnabled ? 0.25 : 0.1 * 255).round(),
            ),
            blurRadius: isEnabled ? 12 : 6,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(
              0xFF6B73FF,
            ).withAlpha(((isEnabled ? 0.15 : 0.05) * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: isEnabled
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          animalColor,
                          animalColor.withAlpha((0.5 * 255).round()),
                          const Color(
                            0xFF6B73FF,
                          ).withAlpha((0.9 * 255).round()),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      )
                    : LinearGradient(
                        colors: [Colors.grey.shade400, Colors.grey.shade300],
                      ),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: isEnabled
                      ? () {
                          _animationController.forward().then((_) {
                            _animationController.reverse();
                          });
                          widget.onPressed?.call();
                        }
                      : null,
                  onTapDown: (_) {
                    if (isEnabled) _animationController.forward();
                  },
                  onTapUp: (_) {
                    if (isEnabled) _animationController.reverse();
                  },
                  onTapCancel: () {
                    if (isEnabled) _animationController.reverse();
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        else ...[
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            tween: Tween(begin: 0.8, end: 1.0),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Text(
                                  animalEmoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 12),

                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(
                                (0.2 * 255).round(),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withAlpha(
                                  (0.3 * 255).round(),
                                ),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],

                        const SizedBox(width: 12),

                        Flexible(
                          child: Text(
                            _getButtonText(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (!widget.isLoading) ...[
                          const SizedBox(width: 8),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: Matrix4.translationValues(
                              isEnabled ? 0 : -4,
                              0,
                              0,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white.withAlpha(
                                (0.9 * 255).round(),
                              ),
                              size: 20,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

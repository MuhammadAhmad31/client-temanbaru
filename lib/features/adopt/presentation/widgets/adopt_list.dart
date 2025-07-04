import 'package:client/features/adopt/domain/entity/adopt.dart';
import 'package:flutter/material.dart';

class AdoptCard extends StatefulWidget {
  final Adopt adopt;
  final VoidCallback? onTap;

  const AdoptCard({super.key, required this.adopt, this.onTap});

  @override
  State createState() => _AdoptCardState();
}

class _AdoptCardState extends State<AdoptCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _scaleAnimation;
  bool _isHovered = false;

  static const Color primaryColor = Color(0xFF6B73FF);
  static const Color secondaryColor = Color(0xFF9B59B6);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFF8C00);
      case 'approved':
        return const Color(0xFF4CAF50);
      case 'rejected':
        return const Color(0xFFE74C3C);
      case 'completed':
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.hourglass_empty_rounded;
      case 'approved':
        return Icons.check_circle_rounded;
      case 'rejected':
        return Icons.cancel_rounded;
      case 'completed':
        return Icons.verified_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  IconData _getAnimalIcon(String type) {
    switch (type.toLowerCase()) {
      case 'dog':
        return Icons.pets;
      case 'cat':
        return Icons.catching_pokemon;
      case 'rabbit':
        return Icons.cruelty_free;
      case 'bird':
        return Icons.flutter_dash;
      default:
        return Icons.pets;
    }
  }

  Color _getAnimalColor(String type) {
    return primaryColor;
  }

  String _getAnimalEmoji(String type) {
    switch (type.toLowerCase()) {
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

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) return 'Hari ini';
      if (difference == 1) return '1 hari lalu';
      if (difference < 7) return '$difference hari lalu';
      if (difference < 30) return '${(difference / 7).floor()} minggu lalu';
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(widget.adopt.status);
    _getAnimalColor(widget.adopt.type);
    final animalEmoji = _getAnimalEmoji(widget.adopt.type);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha((0.1 * 255).round()),
                    blurRadius: _isHovered ? 20 : 12,
                    offset: const Offset(0, 8),
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                  BoxShadow(
                    color: statusColor.withAlpha((0.1 * 255).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: widget.onTap != null
                        ? () {
                            _animationController.forward().then((_) {
                              _animationController.reverse();
                            });
                            widget.onTap?.call();
                          }
                        : null,
                    onTapDown: (_) => _animationController.forward(),
                    onTapUp: (_) => _animationController.reverse(),
                    onTapCancel: () => _animationController.reverse(),
                    onHover: (hovered) {
                      setState(() {
                        _isHovered = hovered;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primaryColor.withAlpha((0.02 * 255).round()),
                            secondaryColor.withAlpha((0.05 * 255).round()),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withAlpha(
                                        (0.1 * 255).round(),
                                      ),
                                      secondaryColor.withAlpha(
                                        (0.05 * 255).round(),
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: primaryColor.withAlpha(
                                      (0.2 * 255).round(),
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      animalEmoji,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Request #${widget.adopt.id}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      statusColor,
                                      statusColor.withAlpha(
                                        (0.8 * 255).round(),
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: statusColor.withAlpha(
                                        (0.3 * 255).round(),
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(widget.adopt.status),
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.adopt.status.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withAlpha(
                                        (0.1 * 255).round(),
                                      ),
                                      secondaryColor.withAlpha(
                                        (0.05 * 255).round(),
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: primaryColor.withAlpha(
                                      (0.2 * 255).round(),
                                    ),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withAlpha(
                                        (0.15 * 255).round(),
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: widget.adopt.image.isNotEmpty
                                      ? Image.network(
                                          widget.adopt.image,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        primaryColor.withAlpha(
                                                          (0.2 * 255).round(),
                                                        ),
                                                        secondaryColor
                                                            .withAlpha(
                                                              (0.1 * 255)
                                                                  .round(),
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    _getAnimalIcon(
                                                      widget.adopt.type,
                                                    ),
                                                    size: 32,
                                                    color: primaryColor,
                                                  ),
                                                );
                                              },
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                primaryColor.withAlpha(
                                                  (0.2 * 255).round(),
                                                ),
                                                secondaryColor.withAlpha(
                                                  (0.1 * 255).round(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            _getAnimalIcon(widget.adopt.type),
                                            size: 32,
                                            color: primaryColor,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.adopt.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2C3E50),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        _buildInfoChip(
                                          icon: Icons.cake_rounded,
                                          text: widget.adopt.age,
                                          color: secondaryColor,
                                        ),
                                        const SizedBox(width: 8),
                                        _buildInfoChip(
                                          icon:
                                              widget.adopt.gender
                                                      .toLowerCase() ==
                                                  'male'
                                              ? Icons.male_rounded
                                              : Icons.female_rounded,
                                          text: widget.adopt.gender,
                                          color:
                                              widget.adopt.gender
                                                      .toLowerCase() ==
                                                  'male'
                                              ? primaryColor
                                              : secondaryColor,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    _buildInfoChip(
                                      icon: _getAnimalIcon(widget.adopt.type),
                                      text: widget.adopt.type.toUpperCase(),
                                      color: primaryColor,
                                      isLarge: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  primaryColor.withAlpha((0.3 * 255).round()),
                                  secondaryColor.withAlpha((0.2 * 255).round()),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryColor.withAlpha(
                                            (0.1 * 255).round(),
                                          ),
                                          secondaryColor.withAlpha(
                                            (0.05 * 255).round(),
                                          ),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.schedule_rounded,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Dibuat',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _formatDate(widget.adopt.created_at),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2C3E50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withAlpha(
                                        (0.05 * 255).round(),
                                      ),
                                      secondaryColor.withAlpha(
                                        (0.03 * 255).round(),
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: primaryColor.withAlpha(
                                      (0.2 * 255).round(),
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.qr_code_rounded,
                                      size: 14,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'ID: ${widget.adopt.animal_id}',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
    bool isLarge = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 12 : 8,
        vertical: isLarge ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withAlpha((0.3 * 255).round()),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isLarge ? 16 : 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: isLarge ? 13 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

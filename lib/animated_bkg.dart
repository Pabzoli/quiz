import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: IllusoryMotion()));
}

class IllusoryMotion extends StatefulWidget {
  @override
  _IllusoryMotionState createState() => _IllusoryMotionState();
}

class _IllusoryMotionState extends State<IllusoryMotion>
    with SingleTickerProviderStateMixin {
  final List<String> _imagePaths = [
    'assets/background_image1.jpg',
    'assets/background_image2.jpg',
    'assets/background_image3.jpg',
    'assets/background_image4.jpg',
    'assets/background_image5.jpg',
    'assets/background_image6.jpg',
    'assets/background_image7.jpg',
  ];

  String _currentImagePath = '';

  late LightParticlePainter _particlePainter;

  @override
  void initState() {
    super.initState();
    _currentImagePath = _imagePaths[Random().nextInt(_imagePaths.length)];

    _particlePainter = LightParticlePainter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              _currentImagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            _particlePainter,
          ],
        ),
      ),
    );
  }
}

class LightParticlePainter extends StatefulWidget {
  @override
  _LightParticlePainterState createState() => _LightParticlePainterState();
}

class _LightParticlePainterState extends State<LightParticlePainter>
    with SingleTickerProviderStateMixin {
  final int numberOfParticles = 125;
  final List<Particle> particles = [];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 16),
    )..addListener(() {
        for (var particle in particles) {
          particle.move();
        }
        setState(() {});
      });

    for (int i = 0; i < numberOfParticles; i++) {
      particles.add(
        Particle(
          Offset(Random().nextDouble(), Random().nextDouble()),
          Random().nextDouble() * 2 + 1,
        ),
      );
    }

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: LightParticleCustomPainter(particles),
    );
  }
}

class LightParticleCustomPainter extends CustomPainter {
  final List<Particle> particles;

  LightParticleCustomPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeCap = StrokeCap.round;

    for (var particle in particles) {
      canvas.drawCircle(particle.position, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  late Offset position;
  late double speed;

  Particle(this.position, this.speed);

  void move() {
    position += Offset(0, speed);
    if (position.dy > 800) {
      position = Offset(Random().nextDouble() * 800, 0);
    }
  }
}

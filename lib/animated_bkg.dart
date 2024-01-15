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

class CircularAnimation extends StatefulWidget {
  @override
  _CircularAnimationState createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _fadeOutAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCirc,
    ));

    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF4365),
              Color(0xFF8A2387),
              Color(0xFF0057FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation.value,
                  child: null, //this is where to put the navigation
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    Center(
                      child: Opacity(
                        opacity: _fadeOutAnimation.value,
                        child: Container(
                          width: screenWidth * _fadeOutAnimation.value,
                          height: screenHeight * _fadeOutAnimation.value,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(
                              _fadeOutAnimation.value * 200,
                            ),
                          ),
                          child: Center(
                            child: Opacity(
                              opacity: 1.0 - _fadeOutAnimation.value,
                              child: Text(
                                'Ease Out Text',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * _fadeInAnimation.value,
                      left: screenWidth * _fadeInAnimation.value,
                      child: Opacity(
                        opacity: _fadeInAnimation.value,
                        child: Container(
                          width: screenWidth * (1 - _fadeInAnimation.value),
                          height: screenHeight * (1 - _fadeInAnimation.value),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              (1 - _fadeInAnimation.value) * 200,
                            ),
                          ),
                          child: Center(
                            child: Opacity(
                              opacity: _fadeInAnimation.value,
                              child: Text(
                                'Ease In Text',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

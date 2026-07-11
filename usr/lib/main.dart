import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF818CF8),
          surface: Color(0xFF1E293B),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(color: Color(0xFF94A3B8), fontSize: 18, height: 1.6),
          bodyMedium: TextStyle(color: Color(0xFF94A3B8), fontSize: 16, height: 1.5),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PortfolioHomePage(),
      },
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A).withOpacity(0.95),
        elevation: 0,
        title: const Text('<DevPortfolio />', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: isMobile
            ? null
            : [
                _NavBarItem(title: 'Home', onTap: () => _scrollToSection(_homeKey)),
                _NavBarItem(title: 'About', onTap: () => _scrollToSection(_aboutKey)),
                _NavBarItem(title: 'Skills', onTap: () => _scrollToSection(_skillsKey)),
                _NavBarItem(title: 'Projects', onTap: () => _scrollToSection(_projectsKey)),
                _NavBarItem(title: 'Contact', onTap: () => _scrollToSection(_contactKey)),
                const SizedBox(width: 24),
              ],
      ),
      drawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF1E293B),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                children: [
                  const DrawerHeader(
                    child: Center(
                      child: Text('<DevPortfolio />', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  _DrawerItem(title: 'Home', icon: Icons.home_outlined, onTap: () { Navigator.pop(context); _scrollToSection(_homeKey); }),
                  _DrawerItem(title: 'About', icon: Icons.person_outline, onTap: () { Navigator.pop(context); _scrollToSection(_aboutKey); }),
                  _DrawerItem(title: 'Skills', icon: Icons.code, onTap: () { Navigator.pop(context); _scrollToSection(_skillsKey); }),
                  _DrawerItem(title: 'Projects', icon: Icons.work_outline, onTap: () { Navigator.pop(context); _scrollToSection(_projectsKey); }),
                  _DrawerItem(title: 'Contact', icon: Icons.mail_outline, onTap: () { Navigator.pop(context); _scrollToSection(_contactKey); }),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _HeroSection(key: _homeKey, onContactTap: () => _scrollToSection(_contactKey)),
            _AboutSection(key: _aboutKey),
            _SkillsSection(key: _skillsKey),
            _ProjectsSection(key: _projectsKey),
            _ContactSection(key: _contactKey),
            const _FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF94A3B8),
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF38BDF8)),
      title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
      onTap: onTap,
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  
  const _HeroSection({super.key, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          return Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 3,
                  child: Column(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hi, my name is',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Jane Doe.',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: isMobile ? 48 : 72),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I build things for the web and mobile.',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(color: const Color(0xFF94A3B8), fontSize: isMobile ? 32 : 56),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'I\'m a software engineer specializing in building exceptional digital experiences. Currently, I\'m focused on building accessible, human-centered products.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: onContactTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: const Color(0xFF0F172A),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Get In Touch'),
                      ),
                    ],
                  ),
                ),
                if (!isMobile) const SizedBox(width: 64),
                if (isMobile) const SizedBox(height: 48),
                Expanded(
                  flex: isMobile ? 0 : 2,
                  child: Container(
                    width: isMobile ? 250 : 400,
                    height: isMobile ? 250 : 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 4),
                      color: const Color(0xFF1E293B),
                    ),
                    child: const Center(
                      child: Icon(Icons.code, size: 120, color: Color(0xFF38BDF8)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 32),
        ),
        const SizedBox(width: 16),
        Container(
          height: 1,
          width: 200,
          color: const Color(0xFF334155),
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B).withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'About Me'),
            const SizedBox(height: 32),
            Text(
              'Hello! My name is Jane and I enjoy creating things that live on the internet. My interest in web and mobile development started back in 2015 when I decided to try editing custom Tumblr themes — turns out hacking together HTML & CSS taught me a lot about HTML & CSS!\n\nFast-forward to today, and I\'ve had the privilege of working at an advertising agency, a start-up, a huge corporation, and a student-led design studio. My main focus these days is building accessible, inclusive products and digital experiences at Upstatement for a variety of clients.\n\nHere are a few technologies I\'ve been working with recently:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'My Skills'),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 2 : constraints.maxWidth < 900 ? 3 : 4;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 2.5,
                  children: const [
                    _SkillCard(skill: 'Flutter', icon: Icons.flutter_dash),
                    _SkillCard(skill: 'Dart', icon: Icons.code),
                    _SkillCard(skill: 'JavaScript', icon: Icons.javascript),
                    _SkillCard(skill: 'React', icon: Icons.web),
                    _SkillCard(skill: 'Node.js', icon: Icons.dns),
                    _SkillCard(skill: 'Firebase', icon: Icons.local_fire_department),
                    _SkillCard(skill: 'Supabase', icon: Icons.storage),
                    _SkillCard(skill: 'Git', icon: Icons.commit),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String skill;
  final IconData icon;

  const _SkillCard({required this.skill, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 12),
          Text(skill, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B).withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'Some Things I\'ve Built'),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 800;
                return Wrap(
                  spacing: 32,
                  runSpacing: 32,
                  alignment: WrapAlignment.center,
                  children: [
                    _ProjectCard(
                      title: 'E-commerce Platform',
                      description: 'A full-stack e-commerce solution built with Flutter, Firebase, and Stripe. Includes real-time inventory and admin dashboard.',
                      tags: const ['Flutter', 'Firebase', 'Stripe'],
                      width: isMobile ? double.infinity : 450,
                    ),
                    _ProjectCard(
                      title: 'Social Media Dashboard',
                      description: 'A web app for tracking social media metrics across platforms. Features interactive charts and custom reporting.',
                      tags: const ['React', 'Node.js', 'Chart.js'],
                      width: isMobile ? double.infinity : 450,
                    ),
                    _ProjectCard(
                      title: 'Task Management Mobile App',
                      description: 'A beautifully designed task manager with offline support, cloud sync, and collaborative features for teams.',
                      tags: const ['Flutter', 'Supabase', 'SQLite'],
                      width: isMobile ? double.infinity : 450,
                    ),
                    _ProjectCard(
                      title: 'AI Image Generator',
                      description: 'An application that interfaces with OpenAI\'s DALL-E API to generate, save, and share custom images based on prompts.',
                      tags: const ['Flutter', 'OpenAI API', 'Provider'],
                      width: isMobile ? double.infinity : 450,
                    ),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final double width;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tags,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.folder_outlined, size: 40, color: Color(0xFF38BDF8)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.open_in_new, color: Color(0xFF94A3B8)),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: tags.map((tag) => Text(tag, style: const TextStyle(color: Color(0xFF818CF8), fontSize: 14))).toList(),
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 120.0),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '04. What\'s Next?',
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Although I\'m not currently looking for any new opportunities, my inbox is always open. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Say Hello'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(Icons.code, color: Color(0xFF94A3B8)), onPressed: () {}),
              IconButton(icon: const Icon(Icons.link, color: Color(0xFF94A3B8)), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Built with Flutter',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

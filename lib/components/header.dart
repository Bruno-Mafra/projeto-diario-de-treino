import 'package:flutter/material.dart';
import '../screens/login.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const Header({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.black),
            ),
            PopupMenuButton(
              offset: const Offset(0, 45),
              icon: const Icon(Icons.settings, color: Colors.black),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: const Text('Perfil'),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: const Text('Sair'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginScreen(title: 'Diário de Treino')),
                    );
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

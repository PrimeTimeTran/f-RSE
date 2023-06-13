import 'package:flutter/material.dart';

navbarIcons(context) {
  return [
    IconButton(
      icon: const Icon(Icons.home),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Hi'),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.attach_money),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Hi'),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.explore),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Hi'),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.article),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Hi'),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Hi'),
          ),
        );
      },
    ),
  ];
}

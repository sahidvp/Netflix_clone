// import 'package:flutter/material.dart';
// import 'package:netfli_project/screens/home.dart';
 


// class BottomNavigationbar extends StatefulWidget {
//   const BottomNavigationbar({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigationbar> createState() => _BottomNavigationbarState();
// }

// class _BottomNavigationbarState extends State<BottomNavigationbar> {
//   int _selectedBottom = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 11,
//         unselectedFontSize: 10,
//         onTap: (int index) {
          
          
//             // Navigate to other pages based on the selected index
//             setState(() {
//               _selectedBottom = index;
//             });
          
//         },
//         currentIndex: _selectedBottom,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.videogame_asset_rounded),
//             label: "Games",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.ondemand_video_sharp),
//             label: "Coming Soon",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.file_download_outlined),
//             label: "Downloads",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: "Search",
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Visibility(
//             visible: _selectedBottom == 0,
//             child: const HomeScreen(),
//           ),
//           Visibility(
//             visible: _selectedBottom == 1,
//             child:const HomeScreen(), // Navigate to GamesScreen
//           ),
//           Visibility(
//             visible: _selectedBottom == 2,
//             child: const HomeScreen(), // Navigate to ComingSoonScreen
//           ),
//           Visibility(
//             visible: _selectedBottom == 3,
//             child: const HomeScreen(), // Navigate to DownloadsScreen
//           ),
//           Visibility(
//             visible: _selectedBottom == 4,
//             child: const Center(
//               child: Text("More"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:netfli_project/screens/comingsoon.dart';
import 'package:netfli_project/screens/download.dart';
import 'package:netfli_project/screens/gamescreen.dart';
import 'package:netfli_project/screens/home.dart';

import 'package:netfli_project/screens/searchpage.dart';

class BottomNavigationbar extends StatefulWidget {
  const BottomNavigationbar({Key? key}) : super(key: key);

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  int _selectedBottom = 0;

  // List of pages to navigate to
  final List<Widget> pages = [
    const HomeView(),
    const GameScreen(),
    const FavoriteView(),
    const Downloads(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        onTap: (int index) {
          if (index == 4) {
            // Navigate to SearchPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          } else {
            // Navigate to other pages based on the selected index
            setState(() {
              _selectedBottom = index;
            });
          }
        },
        currentIndex: _selectedBottom,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_rounded),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video_sharp),
            label: "To watch",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download_outlined),
            label: "Downloads",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
        ],
      ),
      body: pages[_selectedBottom], // Display the selected page
    );
  }
}

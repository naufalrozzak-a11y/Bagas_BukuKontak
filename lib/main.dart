import 'package:flutter/material.dart';

void main() {
  runApp(const BukuKontakApp());
}

class BukuKontakApp extends StatelessWidget {
  const BukuKontakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Buku Kontak',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tambah': (context) => const TambahKontakScreen(),
        '/tentang': (context) => const TentangScreen(),
      },
    );
  }
}

// -----------------------------------------------------------------------------
// HALAMAN UTAMA (Beranda: AppBar, Navigation Drawer, TabBar, TabBarView, FAB)
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List data kontak awal
  final List<Map<String, String>> _daftarKontak = [
    {
      'nama': 'Bagoes Vernanda',
      'email': 'nisa@gmail.com',
      'phone': '0895421903057',
    },
  ];

  void _tambahKontak(String nama, String email, String phone) {
    setState(() {
      _daftarKontak.add({'nama': nama, 'email': email, 'phone': phone});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BUKU KONTAK'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_circle), text: 'Kontak'),
              Tab(icon: Icon(Icons.star), text: 'Favorit'),
            ],
          ),
        ),
        // Navigation Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'BUKU KONTAK',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Kontak'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Tambah Kontak'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.pushNamed(context, '/tambah');
                  if (result != null && result is Map<String, String>) {
                    _tambahKontak(
                      result['nama']!,
                      result['email']!,
                      result['phone']!,
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Favorit'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Tentang'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/tentang');
                },
              ),
            ],
          ),
        ),
        // TabBarView Content
        body: TabBarView(
          children: [
            // Tab 1: Kontak
            _daftarKontak.isEmpty
                ? const Center(child: Text('Belum ada kontak'))
                : ListView.builder(
                    itemCount: _daftarKontak.length,
                    itemBuilder: (context, index) {
                      final item = _daftarKontak[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            item['nama'] != null && item['nama'].toString().isNotEmpty 
                                ? item['nama'].toString()[0].toUpperCase() 
                                : '?',
                          ),
                        ),
                        title: Text(item['nama'] ?? ''),
                        subtitle: Text('${item['email']}\n${item['phone']}'),
                        isThreeLine: true,
                      );
                    },
                  ),
            // Tab 2: Favorit (Data Diri Kamu)
            const ListTile(
              leading: CircleAvatar(
              child: Text(
                item['nama'] != null && item['nama'].toString().isNotEmpty 
                    ? item['nama'].toString()[0].toUpperCase() 
                    : '?',
              ),
            ),
              title: Text('M Naufal F'),
              subtitle: Text('naufal@gmail.com\n081234567890'),
              isThreeLine: true,
            ),
            ], // Penutup array children
        ),
        // FloatingActionButton
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/tambah');
            if (result != null && result is Map<String, String>) {
              _tambahKontak(
                result['nama']!,
                result['email']!,
                result['phone']!,
              );
            }
          },
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HALAMAN TAMBAH KONTAK
// -----------------------------------------------------------------------------
class TambahKontakScreen extends StatefulWidget {
  const TambahKontakScreen({super.key});

  @override
  State<TambahKontakScreen> createState() => _TambahKontakScreenState();
}

class _TambahKontakScreenState extends State<TambahKontakScreen> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Kontak')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'No Handphone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nama = _namaController.text;
                final email = _emailController.text;
                final phone = _phoneController.text;

                if (nama.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
                  Navigator.pop(context, {
                    'nama': nama,
                    'email': email,
                    'phone': phone,
                  });
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HALAMAN TENTANG
// -----------------------------------------------------------------------------
class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Bagoes Vernanda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('XII RPL B'),
            SizedBox(height: 4),
            Text('SMK Negeri 5 Surakarta'),
          ],
        ),
      ),
    );
  }
}

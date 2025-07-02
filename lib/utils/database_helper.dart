import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_db.db');

    return await openDatabase(
      path,
      version: 2, // Increment version jika ada perubahan skema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            level TEXT,
            nama_lengkap TEXT,
            kelas TEXT,
            nim TEXT UNIQUE
          )
        ''');

        // Data dummy (hanya untuk contoh)
        await _insertDummyData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle upgrade database jika diperlukan
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE users ADD COLUMN email TEXT');
        }
      },
    );
  }

  // Method INTERNAL untuk insert data (tidak diekspos ke UI)
  Future<void> _insertDummyData(Database db) async {
    await db.insert('users', {
      'username': 'andi',
      'password': '12345',
      'level': 'Mahasiswa',
      'nama_lengkap': 'Andi Wijaya',
      'kelas': 'IF-1A',
      'nim': '12345678',
    });

    await db.insert('users', {
      'username': 'Naufal Dewa',
      'password': '2456',
      'level': 'Mahasiswa',
      'nama_lengkap': 'Muhammad Naufal Deewana',
      'kelas': '4-ITA2',
      'nim': '223140154',
    });

    await db.insert('users', {
      'username': 'lutfi',
      'password': '88888',
      'level': 'Mahasiswa',
      'nama_lengkap': 'Mokhamad Lutfi',
      'kelas': '4-ITA2',
      'nim': '223140172',
    });
  }

  // Method untuk login (digunakan di UI)
  Future<Map<String, dynamic>?> loginUser(
      String nim, String password, String level) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'nim = ? AND password = ? AND level = ?',
      whereArgs: [nim, password, level],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Method untuk debug/get all users (opsional)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Method INTERNAL untuk insert data (hanya bisa dipanggil via kode)
  Future<int> _insertUser({
    required String username,
    required String password,
    required String level,
    required String namaLengkap,
    required String kelas,
    required String nim,
  }) async {
    final db = await database;
    return await db.insert('users', {
      'username': username,
      'password': password,
      'level': level,
      'nama_lengkap': namaLengkap,
      'kelas': kelas,
      'nim': nim,
    });
  }
}

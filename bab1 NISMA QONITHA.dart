import 'dart:async';

class Product {
  String productName;/
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);

  @override
  String toString() {
    return 'Produk: $productName, Harga: Rp${price.toStringAsFixed(2)}, Tersedia: $inStock';
  }
}
enum Role { Admin, Customer }

class User {
  String name;
  int age;
  late List<Product>? products;
  Role? role;

  User(this.name, this.age, {this.role});

  void viewProducts() {
    if (products != null && products!.isNotEmpty) {
      print('Daftar Produk:');
      products!.forEach((product) {
        print(product);
      });
    } else {
      print('Tidak ada produk tersedia.');
    }
  }
}
class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age, role: Role.Admin);

  void addProduct(Product product, Map<String, Product> productMap, Set<String> productSet) {
    try {
      if (!product.inStock) {
        throw Exception('Produk sedang habis stok.');
      }
      if (productSet.contains(product.productName)) {
        print('${product.productName} sudah ada dalam daftar produk.');
      } else {
        productSet.add(product.productName);
        productMap[product.productName] = product;
        products = productMap.values.toList();
        print('Produk berhasil ditambahkan: ${product.productName}');
      }
    } on Exception catch (e) {
      print('Kesalahan: $e');
    }
  }

  void removeProduct(String productName, Map<String, Product> productMap, Set<String> productSet) {
    if (productSet.contains(productName)) {
      productSet.remove(productName);
      productMap.remove(productName);
      products = productMap.values.toList();
      print('Produk berhasil dihapus: $productName');
    } else {
      print('Produk $productName tidak ditemukan.');
    }
  }
}
class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, role: Role.Customer);
}
Future<void> fetchProductDetails(String productName) async {
  print('Mengambil detail produk untuk $productName...');
  await Future.delayed(Duration(seconds: 2)); 
  print('Detail untuk $productName berhasil diambil.');
}

void main() async {
  Map<String, Product> productMap = {};
  Set<String> productSet = {};

  AdminUser admin = AdminUser('nisma', 20);
  CustomerUser customer = CustomerUser('sila', 20);

  Product product1 = Product('Laptop', 1000.0, true);
  Product product2 = Product('Smartphone', 500.0, true);
  Product product3 = Product('Tablet', 300.0, false); 

  admin.addProduct(product1, productMap, productSet);
  admin.addProduct(product2, productMap, productSet);
  admin.addProduct(product3, productMap, productSet); 

  admin.viewProducts();

  admin.removeProduct('Smartphone', productMap, productSet);

  admin.viewProducts();

  customer.products = admin.products;
  customer.viewProducts();

  await fetchProductDetails('Laptop');
}
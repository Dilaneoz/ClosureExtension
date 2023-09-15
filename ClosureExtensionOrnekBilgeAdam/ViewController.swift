//
//  ViewController.swift
//  ClosureExtensionOrnekBilgeAdam
//
//  Created by Dilan Öztürk on 28.03.2023.
//

import UIKit

// closure lar geriye değer döndürebilen ve aynı zamanda da değişken atanabilen fonksiyonlardır. değişkende saklanabilen kod bloklarına closure diyoruz. özelleştirilmiş fonksiyon olarak da düşünülebilir. parametre alan almayan, geriye değer döndürmeyen gibi türleri de var.
// escaping diye bir closure da var onu daha sonra görücez

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // extension
        let sayi = 5.kareAl() // classtan nesne oluşturmaya gerek kalmadan fonksiyonu kullanabildik
        print(sayi)
        
        let str = "mer".birlestir("haba")
        print(str)
        
        let arrayOrnek : [Any] = [1,2,"dilan",3,4,5,true,"hakan"] // any herhangi bir tipte veri alabiliyor demektir
        print(arrayOrnek.toplamiBul())
        
        // parametre almayan ve geriye değer döndürmeyen bir closure
        // bu diğer programlama dillerinde lambda expression diye geçer. tek bir satırda birden fazla fonksiyonu çağırıp kullanmak
        let selamVer : () -> String = {
            return "merhaba dünya"
        }
        let gelenMesaj = selamVer() // bi üstteki fonksiyonu kullanmak için bunu yazarız
        print(gelenMesaj)
        
        // parametre alan closure
        let toplaClosure : (Int,Int) -> Int = {sayi1, sayi2 in
            return sayi1 + sayi2
        }
        toplaClosure(5,5)
        
        let toplaClosure2 : (Int,Int) -> Int = { // bu şekilde de yazılır
            return ($0 + $1) // dolar işareti o an kullandığımız elemanı temsil eder
        }
        print(toplaClosure2(5,5).description)
        
        // trailing closure
        func mesajVer (name : String, closure : (String) -> Void){ // trailing closure da bir fonksiyonu başka bir fonksiyona parametre olarak atarız. bir fonksiyon başka bir fonksiyonu son parametresi olarak kabul ederse bir fonksiyonun içine aldığı parametrenin en sonuncusu closure olduğundan bu tarz closure lara trailing closure denir
            print("\(name) mesaj gönderecek")
            closure(name) // burayı anlamadım
            print("\(name) mesaj gönderecek")
        }
        
        mesajVer(name: "dilan") { name in // mesajVer fonksiyonunu bu şekilde kullanabiliriz
            print(name, "sana mesaj gönderiyor")
        }
        
        let filtrelenmisSayilar = buyukOlanSayilariFiltrele(deger: 2, sayilar: [3,4,1,0,7,10,2,5]) // 2 den büyük olan sayıları filtrele
        print(filtrelenmisSayilar)
        
        let closureIleFiltrelenmis = closureIleFiltreleme(closure: {(sayi) -> Bool in // bi fonksiyonu başka bir fonksiyona parametre olarak gönderdik. o fonksiyonun da bizden istediği değerleri kendisine gönderiyoruz.
            return sayi > 2
        }, sayilar : [3,4,1,0,7,10,2,5])
        print(closureIleFiltrelenmis)
        
        func buyukOlanSayilariFiltrele(deger : Int, sayilar : [Int]) -> [Int] { // bu closure değil bi fonksiyon. bu fonksiyon bir tane deger alıyor. örneğin 5ten büyük olanları filtrele diycez. "deger : Int" bu başlangıç değişkeni, "sayilar : [Int]" bu da kendisine göndericeğimiz sayıdır. "-> [Int]" bunun sonucunda da 10 tane sayı gönderdiysek o 10 sayıdan ikiden büyük olanlar filtreli bir şekilde gelicek
            var filtrelenmisDizi = [Int]() // boş bir dizi tanımladık
            for num in sayilar { // kendisine gelen arrayin içindeki elemanları kontrol edicek. örneğin gelen sayı bir sonraki sayıdan büyük mü değil mi
                if num > deger {
                    filtrelenmisDizi.append(num) // büyük olan sayı bu dizinin içine eklenecek
                }
            }
            return filtrelenmisDizi // geriye filtrelenmisDizi dönecek
        }
        
        // üstteki fonksiyonu closure olarak da kullanabiliriz
        func closureIleFiltreleme(closure : (Int) -> Bool, sayilar : [Int]) -> [Int] {
            var buyukOlanSayilar = [Int]()
            for sayi in sayilar {
                if closure(sayi) {
                    buyukOlanSayilar.append(sayi)
                }
            }
            return buyukOlanSayilar
        }
    }
    
}

// extension, bir class a o class tan bir türetme yapmadan da bir değişkeni/fonksiyonu kullanabilmemizi sağlamaktadır. extension ın genişletme anlamı vardır class ları genişletiriz. örneği normalde bir sayının karesini hesaplayan bir fonksiyona ihtiyacımız varsa ayrı bir matematik class ı yapıp o class ın içerisinde bu fonksiyonu kullanabilmek için fonksiyonu yazmak ve ilgili class tan bir nesne oluşturmak gerekir. ama extensionları kullanarak
extension Int { // burada Int class ımızın içine bir fonksiyon tanımladık. bu fonksiyonu da geri dönüş değeriyle birlikte tanımladık. bu fonksiyonu üstteki class ın viewDidLoad fonksiyonu içinde kullanabiliriz
    func kareAl () -> Int{
        return self * self
    }
}

extension String {
    func birlestir (_ parametre : String) -> String {
        return self + parametre
    }
}

extension Array {
    func toplamiBul() -> Int {
        var toplam : Int = 0
        for item in self { // self bana bu extension fonksiyonumda göndericeğim değeri/parametreyi temsil eder
            let intItem = item as? Int ?? 0 // o anki item eğer int bir değişkense kendi değerini al yoksa 0 değerini al
            toplam += intItem
        }
        return toplam
    }
}

//extensionlar bu şekilde de kullanılabilir
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

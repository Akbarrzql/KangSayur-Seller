import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/sale_bloc.dart';
import 'package:kangsayur_seller/bloc/state/sale_state.dart';
import 'package:kangsayur_seller/repository/sale_repository.dart';
import 'package:kangsayur_seller/ui/produk/kategori_produk.dart';
import 'package:kangsayur_seller/ui/promo/list_promo.dart';
import 'package:kangsayur_seller/ui/widget/main_button.dart';
import 'package:kangsayur_seller/ui/widget/textfiled.dart';
import 'package:intl/intl.dart';
import '../../bloc/event/sale_event.dart';
import '../../common/color_value.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({Key? key, required this.selectedCategories,
    this.title = "",
    this.variant = const [],
    this.variantPrice = const [],
    this.stock = 0,
    this.price = 0,
    this.image = "",
    this.idProduk = 0,
    this.idVariant = const [],
  }) : super(key: key);
  final List<bool> selectedCategories;
  final String title;
  final List<String> variant;
  final List<int> variantPrice;
  final int stock;
  final int price;
  final String image;
  final int idProduk;
  final List<int> idVariant;

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {

  bool sesi1 = false;
  bool sesi2 = false;
  bool sesi3 = false;
  bool sesi4 = false;

  bool _isCategorySelected = false;
  final List<TextEditingController> _hargaPromoController = [
    TextEditingController(),
  ];

  final List<TextEditingController> _stockController = [
    TextEditingController(),
  ];

  //chip  list
  List<bool> chip = [false, false, false, false, false, false];

  bool withInputFormatter = false;

  final _formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp. ',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Check if any category is already selected
    _hargaPromoController.addAll(List.generate(widget.selectedCategories.length, (_) => TextEditingController()));
    _stockController.addAll(List.generate(widget.selectedCategories.length, (_) => TextEditingController()));

    // Check if any category is already selected
    for (var i = 0; i < widget.selectedCategories.length; i++) {
      if (widget.selectedCategories[i]) {
        _isCategorySelected = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => SalePagBloc(salePageRepository: SaleRepository()),
      child: BlocConsumer<SalePagBloc, SaleState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SaleInitial){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Daftar Promo',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: ColorValue.neutralColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorValue.neutralColor,
                  ),
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Periode Promo",
                          style: textTheme.subtitle1!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Promo akan dimulai sesuai zona waktu Jakarta (GMT +7)",
                          style: textTheme.bodyText2!.copyWith(
                            color: ColorValue.hintColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ActionChip(
                                  label: Text(
                                    "Jam 10:00 - 12:00",
                                    style: textTheme.bodyText2!.copyWith(
                                      color: sesi1 ? Colors.white : ColorValue.neutralColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      sesi1 = !sesi1;
                                      sesi2 = false;
                                      sesi3 = false;
                                      sesi4 = false;
                                    });
                                  },
                                  backgroundColor: sesi1 ? ColorValue.primaryColor : ColorValue.neutralColor.withOpacity(0.1),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                ActionChip(
                                  label: Text(
                                    "Jam 12:00 - 14:00",
                                    style: textTheme.bodyText2!.copyWith(
                                      color: sesi2 ? Colors.white : ColorValue.neutralColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      sesi2 = !sesi2;
                                      sesi1 = false;
                                      sesi3 = false;
                                      sesi4 = false;
                                    });
                                  },
                                  backgroundColor: sesi2 ? ColorValue.primaryColor : ColorValue.neutralColor.withOpacity(0.1),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ActionChip(
                                  label: Text(
                                    "Jam 18:00 - 20:00",
                                    style: textTheme.bodyText2!.copyWith(
                                      color: sesi3 ? Colors.white : ColorValue.neutralColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      sesi1 = false;
                                      sesi2 = false;
                                      sesi3 = !sesi3;
                                      sesi4 = false;
                                    });
                                  },
                                  backgroundColor: sesi3 ? ColorValue.primaryColor : ColorValue.neutralColor.withOpacity(0.1),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                ActionChip(
                                  label: Text(
                                    "Jam 20:00 - 22:00",
                                    style: textTheme.bodyText2!.copyWith(
                                      color: sesi4 ? Colors.white : ColorValue.neutralColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      sesi2 = false;
                                      sesi1 = false;
                                      sesi3 = false;
                                      sesi4 = !sesi4;
                                    });
                                  },
                                  backgroundColor: sesi4 ? ColorValue.primaryColor : ColorValue.neutralColor.withOpacity(0.1),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                        Text(
                          "Pilih Produk",
                          style: textTheme.subtitle1!.copyWith(
                            color: ColorValue.neutralColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Pilih produk yang akan diikuti promo",
                          style: textTheme.bodyText2!.copyWith(
                            color: ColorValue.hintColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        if (_isCategorySelected)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < widget.selectedCategories.length; i++)
                                if (widget.selectedCategories[i])
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                                  width: 314,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: ColorValue.neutralColor.withOpacity(0.1),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  width: 70,
                                                                  height: 80,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    image:  DecorationImage(
                                                                      image: NetworkImage(widget.image), // Change to appropriate variable
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10,),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      widget.title, // Change to appropriate variable
                                                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 14,
                                                                        color: ColorValue.neutralColor,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 5,),
                                                                    Text(
                                                                      "Stock ${widget.stock}", // Change to appropriate variable
                                                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12,
                                                                        color: ColorValue.hintColor,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 5,),
                                                                    Row(
                                                                      children: [
                                                                        for (var j = 0; j < widget.variant.length; j++)
                                                                          Container(
                                                                            margin: const EdgeInsets.only(right: 5),
                                                                            child: ActionChip(
                                                                              label: Text(
                                                                                widget.variant[j].toString(), // Change to appropriate variable
                                                                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: 12,
                                                                                  color: chip[j] ? Colors.white : ColorValue.neutralColor,
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  chip[j] = !chip[j];
                                                                                  for (var k = 0; k < chip.length; k++) {
                                                                                    if (k != j) {
                                                                                      chip[k] = false;
                                                                                    }
                                                                                  }
                                                                                });
                                                                              },
                                                                              backgroundColor: chip[j] ? ColorValue.primaryColor : Colors.grey.withOpacity(0.1),
                                                                              elevation: 1,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                              visualDensity: VisualDensity.compact,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                              ),
                                                                            ),
                                                                          )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.topRight,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  widget.selectedCategories[i] = false;
                                                                  _isCategorySelected = widget.selectedCategories.contains(true);
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color: Colors.red,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 20,),
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                        alignment: Alignment.centerLeft,
                                                        height: 50,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                            color: ColorValue.hintColor,
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Harga Normal ${
                                                          //set state jika ada perubahan harga dari chip variant
                                                          //format ke rupiah
                                                          chip[0] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[0]) : chip[1] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[1]) : chip[2] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[2]) : chip[3] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[3]) : chip[4] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[4]) : chip[5] ? NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.variantPrice[5]) : NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ').format(widget.price)
                                                          }",
                                                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                            color: ColorValue.neutralColor,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                            color: ColorValue.hintColor,
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                                          child: TextFormField(
                                                            controller: _stockController[i],
                                                            keyboardType: TextInputType.number,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: "Stok Barang Promo",
                                                              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                color: ColorValue.hintColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(
                                                            color: ColorValue.hintColor,
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                                          child: TextFormField(
                                                            controller: _hargaPromoController[i],
                                                            keyboardType: TextInputType.number,
                                                            inputFormatters: [_formatter],
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: "Rp. ",
                                                              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                color: ColorValue.hintColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                              main_button("Buat Promo", context, onPressed: (){
                                BlocProvider.of<SalePagBloc>(context).add(SalePost(
                                  sessionId: sesi1 ? "1" : sesi2 ? "2" : sesi3 ? "3" : sesi4 ? "4" : "0",
                                  produkId: widget.idProduk.toString(),
                                  varianId: chip[0] ? widget.idVariant[0].toString() : chip[1] ? widget.idVariant[1].toString() : chip[2] ? widget.idVariant[2].toString() : chip[3] ? widget.idVariant[3].toString() : chip[4] ? widget.idVariant[4].toString() : chip[5] ? widget.idVariant[5].toString() : "0",
                                  hargaSale: _hargaPromoController[0].text.isNotEmpty ? _hargaPromoController[0].text.toString().replaceAll("Rp. ", "").replaceAll(".", "") : widget.price.toString(),
                                  stokSale: _stockController[0].text.isNotEmpty ? _stockController[0].text.toString() : widget.stock.toString(),
                                ));
                                print(_hargaPromoController[0].text.isNotEmpty ? _hargaPromoController[0].text.toString().replaceAll("Rp. ", "").replaceAll(".", "") : widget.price.toString());
                                print(chip[0] ? widget.idVariant[0].toString() : chip[1] ? widget.idVariant[1].toString() : chip[2] ? widget.idVariant[2].toString() : chip[3] ? widget.idVariant[3].toString() : chip[4] ? widget.idVariant[4].toString() : chip[5] ? widget.idVariant[5].toString() : "0");
                              })
                            ],
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorValue.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const KategoriProdukPage()));
                            },
                            child: Text(
                              "Pilih Kategori Iklan",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daftar Produk",
                                  style: textTheme.subtitle1!.copyWith(
                                    color: ColorValue.neutralColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  "Daftar produk yang sudah  di promo",
                                  style: textTheme.subtitle1!.copyWith(
                                    color: ColorValue.hintColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ListPromoPage()));
                              },
                              child: Text(
                                "Lihat",
                                style: textTheme.subtitle1!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ),
            );
          }else if (state is SaleLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if (state is SaleLoaded) {
            return const ListPromoPage();
          }else if (state is SaleError) {
            print(state.message);
            return Center(
              child: Text(state.message),
            );
          }else{
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kangsayur_seller/ui/promo/promo.dart';

import '../../common/color_value.dart';
import '../bottom_navigation/bottom_navigation.dart';

class ListPromoPage extends StatefulWidget {
  const ListPromoPage({Key? key}) : super(key: key);

  @override
  State<ListPromoPage> createState() => _ListPromoPageState();
}

class _ListPromoPageState extends State<ListPromoPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Informasi Iklan',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PromoPage(selectedCategories: [],),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorValue.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.3,
                      50,
                    ),
                  ),
                  child: Text(
                    'Buat Promo',
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: ColorValue.hintColor,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 33,
                                      decoration: BoxDecoration(
                                        color: ColorValue.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Jam 10.00 - 12.00',
                                        style: textTheme.bodyText2!.copyWith(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: (){},
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: ColorValue.neutralColor,
                                        ),
                                      ),
                                    )
                                  ]
                                ),
                              ),
                              const Divider(
                                color: ColorValue.hintColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/wortel.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Wortel 1/KG',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: ColorValue.neutralColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          'Rp 6.000',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: Colors.red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          'Rp 4.000',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: ColorValue.neutralColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorValue.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      40,
                                    ),
                                  ),
                                  child: Text(
                                    'Lihat Detail',
                                    style: textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

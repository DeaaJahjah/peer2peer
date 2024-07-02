import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/drop_down_custom.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_drawer.dart';
import 'package:lets_buy/features/posts/models/category_model.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/models/type_model.dart';
import 'package:lets_buy/features/posts/widgets/category_dropdown.dart';
import 'package:lets_buy/features/posts/widgets/porduct_card.dart';
import 'package:lets_buy/features/posts/widgets/types_dropdown.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  bool isSwitched = true;
  bool loading = true;

  // String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    // context.read<UserInfoProvider>().getUserInfo(uid: uid).then((value) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<SearchProvider>().getServices();
      },
    );
    super.initState();
  }

  int currentIndex = 0;
  bool openMenu = false;

  @override
  Widget build(BuildContext context) {
    // FlutterFireAuthServices().signOut(context);

    print('${SharedPrefs.prefs.getString('token')}.....');
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });

              if (currentIndex == 0) {
                context.read<SearchProvider>().serviceType = ServiceType.need_to;
                context.read<SearchProvider>().getServices();
              } else {
                context.read<SearchProvider>().serviceType = ServiceType.provided_to;
                context.read<SearchProvider>().getServices();
              }
            },
            currentIndex: currentIndex,
            backgroundColor: Colors.black,
            selectedItemColor: purple,
            unselectedItemColor: white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'طلبات'),
              BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'عروض'),
            ]),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: purple,
          elevation: 0.0,
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  openMenu = !openMenu;
                });
              },
              child: const Icon(Icons.filter_alt),
            )
          ],
          // leading: InkWell(
          //     onTap: () {

          //     },
          //     child: const Icon(Icons.message)),
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: darkPurple,
                filled: true,
                hintText: 'ابحث هنا',
              ),
              onChanged: (value) {
                context.read<SearchProvider>().name = value;
                context.read<SearchProvider>().getServices();
              },
            ),
          ),
        ),
        body: PopScope(
          canPop: !openMenu,
          onPopInvoked: (didPop) {
            setState(() {
              openMenu = false;
            });
          },
          child: Stack(
            children: [
              Consumer<SearchProvider>(builder: (context, provider, child) {
                if (provider.dataState == DataState.done) {
                  List<ServiceModel> posts = provider.result!.content;
                  return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, i) {
                        return ServiceCard(
                          service: posts[i],
                        );
                      });
                }
                if (provider.dataState == DataState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: purple),
                  );
                }
                return const SizedBox.shrink();
              }),
              if (openMenu)
                Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          color: purple,
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'اختر المدينة',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 1,
                                child: DropDownCustom(
                                  categories: cities,
                                  selectedItem: context.watch<SearchProvider>().location,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      context.read<SearchProvider>().location = newValue!;
                                      context.read<SearchProvider>().getServices();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'اختر التصنيف',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: CategoryDropdown(
                                  selectedCategory: context.watch<SearchProvider>().selectedCategory,
                                  onChanged: (Category? newValue) {
                                    setState(() {
                                      context.read<SearchProvider>().selectedCategory = newValue;
                                      context.read<SearchProvider>().getServices();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'اختر النوع',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TypesDropdown(
                                  selectedType: context.watch<SearchProvider>().selectedType,
                                  onChanged: (TypeModel? newValue) {
                                    setState(() {
                                      context.read<SearchProvider>().selectedType = newValue;
                                      context.read<SearchProvider>().getServices();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButtonCustom(
                            text: 'الغاء الفلتر',
                            color: Colors.red,
                            textColor: dark,
                            onPressed: () {
                              setState(() {
                                openMenu = false;
                                context.read<SearchProvider>().clear();
                                controller.clear();
                                context.read<SearchProvider>().getServices();
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ))
            ],
          ),
        )
        // : const Center(child: CircularProgressIndicator(color: purple)),
        );
  }
}

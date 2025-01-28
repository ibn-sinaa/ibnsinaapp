part of 'routes_generator_imports.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case AppRoutes.splash:
      return AppPageRoute(
        builder: (context) => BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(
            locator<AppRepository>(),
            locator<UserRepository>(),
          ),
          child: const SplashScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.intro:
      final introData = arguments as List<IntroModel>;
      return AppPageRoute(
        builder: (context) => IntroScreen(
          introData: introData,
        ),
        settings: settings,
      );
    case AppRoutes.signIn:
      return AppPageRoute(
        builder: (context) => BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(
            locator<AuthRepository>(),
            locator<UserRepository>(),
          ),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.signUp:
      return AppPageRoute(
        builder: (context) => BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(
            locator<AuthRepository>(),
          ),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.main:
      return AppPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<SearchCubit>(
              create: (context) => SearchCubit(
                locator<ProductsRepository>(),
              ),
            ),
            BlocProvider<HomeSliderCubit>(
              create: (context) => HomeSliderCubit(
                locator<ProductsRepository>(),
              )..getHomeSliders(),
            ),
            BlocProvider<HomeProductsCubit>(
              create: (context) => HomeProductsCubit(
                locator<ProductsRepository>(),
              ),
            ),
            BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit(
                locator<ProductsRepository>(),
              ),
            ),
            BlocProvider<MyOrdersCubit>(
              create: (context) => MyOrdersCubit(
                locator<OrdersRepository>(),
              )..getProductOrders(),
            ),
          ],
          child: const MainScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.termsAndConditions:
      final apiToken = arguments as String?;
      return AppPageRoute(
        builder: (context) => BlocProvider<PageCubit>(
          create: (context) => PageCubit(
            locator<AppRepository>(),
            apiToken,
          )..getTerms(),
          child: const TermsAndConditionsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.aboutApp:
      return AppPageRoute(
        builder: (context) => BlocProvider<PageCubit>(
          create: (context) => PageCubit(
            locator<AppRepository>(),
          )..getAboutApp(),
          child: const AboutAppaScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.privacyPolicy:
      return AppPageRoute(
        builder: (context) => BlocProvider<PageCubit>(
          create: (context) => PageCubit(
            locator<AppRepository>(),
          )..getPolicy(),
          child: const PrivacyPolicyScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.ourBranches:
      return AppPageRoute(
        builder: (context) => const OurBranchesScreen(),
        settings: settings,
      );
    case AppRoutes.contactUs:
      return AppPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<ContactUsCubit>(
              create: (context) => ContactUsCubit(
                locator<AppRepository>(),
                locator<UserRepository>(),
              )..getUserData(),
            ),
            BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(
                locator<AppRepository>(),
              ),
            ),
          ],
          child: const ContactUsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.myProfile:
      return AppPageRoute(
        builder: (context) => const MyProfileScreen(),
        settings: settings,
      );
    case AppRoutes.changePassword:
      return AppPageRoute(
        builder: (context) => BlocProvider<ChangePasswordCubit>(
          create: (context) => ChangePasswordCubit(
            locator<ProfileRepository>(),
          ),
          child: const ChangePasswordScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.profileInfo:
      return AppPageRoute(
        builder: (context) => BlocProvider<MyProfileCubit>(
          create: (context) => MyProfileCubit(
            locator<ProfileRepository>(),
            context.read<UserCubit>(),
          )..getMyProfile(),
          child: const ProfileInfoScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.category:
      final args = arguments as Map<String, dynamic>;
      return AppPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<SearchCubit>(
              create: (context) => SearchCubit(
                locator<ProductsRepository>(),
                args['id'],
              ),
            ),
            BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit(
                locator<ProductsRepository>(),
                args['id'],
              )..getCategories(),
            ),
            BlocProvider<ProductsCubit>(
              create: (context) => ProductsCubit(
                locator<ProductsRepository>(),
              ),
            ),
          ],
          child: CategoryScreen(
            name: args['name'],
            categoryId: args['id'],
          ),
        ),
        settings: settings,
      );
    case AppRoutes.productDetails:
      final args = arguments as Map<String, dynamic>;
      return AppPageRoute(
        builder: (context) => BlocProvider<ProductDetailsCubit>(
          create: (context) => ProductDetailsCubit(
            args['productId'],
            locator<ProductsRepository>(),
          )..getProductDetails(),
          child: ProductDetailsScreen(
            title: args['title'],
          ),
        ),
        settings: settings,
      );
    case AppRoutes.yourOrderDetails:
      final options = arguments as List<OptionModel>;

      return AppPageRoute(
        builder: (context) => YourOrderDetailsScreen(
          options: options,
        ),
        settings: settings,
      );
    case AppRoutes.productOrderDetails:
      final id = arguments as int;

      return AppPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              OrderDetailsCubit(locator<OrdersRepository>(), id)
                ..getProductOrderDetails(),
          child: const ProductOrderDetailsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.sendQuotationRequest:
      return AppPageRoute(
        builder: (context) => BlocProvider<SendQuotationRequestCubit>(
          create: (context) => SendQuotationRequestCubit(
            locator<QuotationsRepository>(),
          ),
          child: const SendQuotationRequestScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.quotaionRequests:
      return AppPageRoute(
        builder: (context) => BlocProvider<QuotationRequestCubit>(
          create: (context) => QuotationRequestCubit(
            locator<QuotationsRepository>(),
          )..getQuotationRequests(),
          child: const QuotationRequestsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.quotaionRequestDetails:
      final id = arguments as int;
      return AppPageRoute(
        builder: (context) => BlocProvider<QuotationRequestCubit>(
          create: (context) => QuotationRequestCubit(
            locator<QuotationsRepository>(),
            id,
          )..getQuotationRequestDetails(),
          child: const QuotationRequestDetailsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.notifications:
      return AppPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => NotificationsCubit(
            locator<ProfileRepository>(),
          )..getNotifications(),
          child: const NotificationsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.imageViewer:
      return AppPageRoute(
        builder: (context) => ImageViewerScreen(
          imageModel: arguments as ImageModel,
        ),
        settings: settings,
      );
    case AppRoutes.payment:
      final url = (arguments as Map<String, dynamic>)['url'] as String;
      final orderType = arguments['orderType'] as OrderType;
      final routeName = arguments['routeName'] as String?;

      return AppPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => PaymentCubit(
            locator<OrdersRepository>(),
            locator<UserRepository>(),
          ),
          child: PaymentScreen(
            url: url,
            orderType: orderType,
            routeName: routeName,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.paperOrderDetails:
      final id = settings.arguments as int;
      return AppPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              OrderDetailsCubit(locator<OrdersRepository>(), id)
                ..getPaperOrderDetails(),
          child: const PaperOrderDetailsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.paperPrintingOrders:
      return AppPageRoute(
        builder: (context) => BlocProvider<MyOrdersCubit>(
          create: (context) => MyOrdersCubit(
            locator<OrdersRepository>(),
          )..getPaperOrders(),
          child: const MyOrdersScreen(
            orderType: OrderType.paper,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.paperPrinting:
      return AppPageRoute(
        builder: (context) => BlocProvider<PaperPrintingCubit>(
          create: (context) => PaperPrintingCubit(
            locator<OrdersRepository>(),
          )..getInitialData(),
          child: const PaperPrintingScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.paperCompletion:
      return AppPageRoute(
        builder: (context) => BlocProvider<HideBottomSheetCubit>(
          create: (context) => HideBottomSheetCubit(),
          child: PaperCompletionScreen(
            paperState: settings.arguments as PaperPrintingState,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.mediaCompletion:
      return AppPageRoute(
        builder: (context) => BlocProvider<HideBottomSheetCubit>(
          create: (context) => HideBottomSheetCubit(),
          child: MediaCompletionScreen(
            mediaState: settings.arguments as MediaPrintingState,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.productCompletion:
      return AppPageRoute(
        builder: (context) => BlocProvider<HideBottomSheetCubit>(
          create: (context) => HideBottomSheetCubit(),
          child: ProductCompletionScreen(
            cartState: settings.arguments as CartState,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.mediaPrintingOrders:
      return AppPageRoute(
        builder: (context) => BlocProvider<MyOrdersCubit>(
          create: (context) => MyOrdersCubit(
            locator<OrdersRepository>(),
          )..getMediaOrders(),
          child: const MyOrdersScreen(
            orderType: OrderType.media,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.mediaOrderDetails:
      final id = settings.arguments as int;
      return AppPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              OrderDetailsCubit(locator<OrdersRepository>(), id)
                ..getMediaOrderDetails(),
          child: const MediaOrderDetailsScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.mediaPrinting:
      return AppPageRoute(
        builder: (context) => BlocProvider<MediaPrintingCubit>(
          create: (context) =>
              MediaPrintingCubit(locator<OrdersRepository>())..getInitialData(),
          child: const MediaPrintingScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.pdfViewer:
      return AppPageRoute(
        builder: (context) => PdfViewerScreen(
          filePath: arguments as String,
        ),
        settings: settings,
      );
    case AppRoutes.map:
      final location = settings.arguments as LocationModel;
      return AppPageRoute(
        builder: (context) => MapScreen(location: location),
      );
    default:
      return AppPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(AppStrings.undefinedRoute.tr()),
            ),
          );
        },
        settings: settings,
      );
  }
}

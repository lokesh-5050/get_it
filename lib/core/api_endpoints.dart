class ApiEndpoints {

  static const String baseUrl = "https://sanjay-tiwari-backend.vercel.app/api";

  static const userApis = "/user";
    static const String login = "/$userApis/login";
    static const String verifyOtp = "/$userApis/verify";
    static const String register = "/$userApis/register";
    static const String myProfile = "/$userApis/profile";
    static const String getAllCategory = "/$userApis/categories";
    static const String getAllSubCategory = "/$userApis/subcategories";
    static const String getTodayDeals = "/$userApis/today-deals";
    static const String getNewArrivals = "/$userApis/new-arrivals";


    static const String getProductsByMainCategory = "/$userApis/products/mainCategory";
    static const String getProductById = "/$userApis/products";

    static const String getCart = "/$userApis/cart/get";

    static const String addToCart = "/$userApis/cart/add";

    static const String deleteFromCart = "/$userApis/cart/delete";








}
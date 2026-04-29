class ApiEndPoints {
  ApiEndPoints._();
  static const String baseUrl =
      "https://admin.bookstore.bfcpublications.com/api";

  //image url
  static const String imageUrlCategory =
      "https://bookstoreassets.s3.ap-southeast-1.amazonaws.com/category/";

  static const String imageUrlproducts =
      "https://bookstoreassets.s3.ap-southeast-1.amazonaws.com/products/";

  static const String userImage =
      "https://bookstoreassets.s3.ap-southeast-1.amazonaws.com/user_image/";

  //PDF agreement
  static const String pdfAgreement =
      "https://bfcgroup.in/assets/asf_agreementMail/";

  //PDF asf
  static const String pdfASF = "https://bfcgroup.in/assets/asf_authorMail/";

  //Banners
  static const String banners = "/banners";
}

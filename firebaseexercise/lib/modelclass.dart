class Productsdetails {
  String? response;
  List<MenuItems>? menuItems;
  String? pageTitle;
  Website? website;

  Productsdetails(
      {this.response, this.menuItems, this.pageTitle, this.website});

  Productsdetails.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['menu_items'] != null) {
      menuItems = [];
      json['menu_items'].forEach((v) {
        menuItems!.add(new MenuItems.fromJson(v));
      });
    }
    pageTitle = json['page_title'];
    website =
        json['website'] != null ? new Website.fromJson(json['website']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.menuItems != null) {
      data['menu_items'] = this.menuItems!.map((v) => v.toJson()).toList();
    }
    data['page_title'] = this.pageTitle;
    if (this.website != null) {
      data['website'] = this.website!.toJson();
    }
    return data;
  }
}

class MenuItems {
  String? name;
  String? sliderTitle;
  String? sliderDesc;
  String? isActive;
  String? sliderImage;
  List<Products>? products;

  MenuItems(
      {this.name,
      this.sliderTitle,
      this.sliderDesc,
      this.isActive,
      this.sliderImage,
      this.products});

  MenuItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sliderTitle = json['slider_title'];
    sliderDesc = json['slider_desc'];
    isActive = json['is_active'];
    sliderImage = json['slider_image'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slider_title'] = this.sliderTitle;
    data['slider_desc'] = this.sliderDesc;
    data['is_active'] = this.isActive;
    data['slider_image'] = this.sliderImage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? name;
  String? desc;
  String? amount;
  String? productType;
  String? isActive;
  String? image;
  String? currency;

  Products(
      {this.id,
      this.name,
      this.desc,
      this.amount,
      this.productType,
      this.isActive,
      this.image,
      this.currency});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    amount = json['amount'];
    productType = json['product_type'];
    isActive = json['is_active'];
    image = json['image'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['amount'] = this.amount;
    data['product_type'] = this.productType;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    data['currency'] = this.currency;
    return data;
  }
}

class Website {
  String? id;
  String? restaurantId;
  String? eventId;
  String? aboutUs;
  String? sliderTitle;
  String? sliderDesc;
  String? phone;
  String? mobile;
  String? email;
  String? address;
  String? copyright;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? pinterestLink;
  String? linkedinLink;
  String? image;
  String? isPdfMenu;
  String? pdfMenu;

  Website(
      {this.id,
      this.restaurantId,
      this.eventId,
      this.aboutUs,
      this.sliderTitle,
      this.sliderDesc,
      this.phone,
      this.mobile,
      this.email,
      this.address,
      this.copyright,
      this.facebookLink,
      this.instagramLink,
      this.twitterLink,
      this.pinterestLink,
      this.linkedinLink,
      this.image,
      this.isPdfMenu,
      this.pdfMenu});

  Website.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    eventId = json['event_id'];
    aboutUs = json['about_us'];
    sliderTitle = json['slider_title'];
    sliderDesc = json['slider_desc'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    copyright = json['copyright'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    pinterestLink = json['pinterest_link'];
    linkedinLink = json['linkedin_link'];
    image = json['image'];
    isPdfMenu = json['is_pdf_menu'];
    pdfMenu = json['pdf_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['event_id'] = this.eventId;
    data['about_us'] = this.aboutUs;
    data['slider_title'] = this.sliderTitle;
    data['slider_desc'] = this.sliderDesc;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['copyright'] = this.copyright;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['pinterest_link'] = this.pinterestLink;
    data['linkedin_link'] = this.linkedinLink;
    data['image'] = this.image;
    data['is_pdf_menu'] = this.isPdfMenu;
    data['pdf_menu'] = this.pdfMenu;
    return data;
  }
}

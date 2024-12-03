class FaqResponse {
  bool? success;
  String? message;
  Data? data;
  String? error;

  FaqResponse({this.success, this.message, this.data, this.error});

  FaqResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class Data {
  int? currentPage;
  List<FaqItemData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FaqItemData>[];
      json['data'].forEach((v) {
        data!.add(FaqItemData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FaqItemData {
  String? id;
  String? question;
  String? answer;
  int? priority;
  int? isActive;
  Null? misc;
  List<Categories>? categories;

  FaqItemData(
      {this.id,
      this.question,
      this.answer,
      this.priority,
      this.isActive,
      this.misc,
      this.categories});

  FaqItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    priority = json['priority'];
    isActive = json['is_active'];
    misc = json['misc'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  String? id;
  String? categoryName;
  String? slug;
  Pivot? pivot;

  Categories({this.id, this.categoryName, this.slug, this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    slug = json['slug'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  String? categoriazableType;
  String? categoriazableId;
  String? categoryId;

  Pivot({this.categoriazableType, this.categoriazableId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoriazableType = json['categoriazable_type'];
    categoriazableId = json['categoriazable_id'];
    categoryId = json['category_id'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}

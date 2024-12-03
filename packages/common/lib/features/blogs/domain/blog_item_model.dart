class BlogPostListResponse {
  bool? success;
  String? message;
  Data? data;
  String? error;

  BlogPostListResponse({this.success, this.message, this.data, this.error});

  BlogPostListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  int? currentPage;
  List<BlogItemData>? data;
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
      data = <BlogItemData>[];
      json['data'].forEach((v) {
        data!.add(BlogItemData.fromJson(v));
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class BlogItemData {
  String? id;
  String? title;
  String? description;
  String? slug;
  String? content;
  String? publishDate;
  int? isFeatureBlog;
  int? readingTime;
  String? imageUrl;
  dynamic imageDimension;
  int? likes;
  int? views;
  dynamic misc;
  int? isPublished;
  int? priority;
  List<Categories>? categories;

  BlogItemData(
      {this.id,
      this.title,
      this.description,
      this.slug,
      this.content,
      this.publishDate,
      this.isFeatureBlog,
      this.readingTime,
      this.imageUrl,
      this.imageDimension,
      this.likes,
      this.views,
      this.misc,
      this.isPublished,
      this.priority,
      this.categories});

  BlogItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    content = json['content'];
    publishDate = json['publish_date'];
    isFeatureBlog = json['is_feature_blog'];
    readingTime = json['reading_time'];
    imageUrl = json['image_url'];
    imageDimension = json['image_dimension'];
    likes = json['likes'];
    views = json['views'];
    misc = json['misc'];
    isPublished = json['is_published'];
    priority = json['priority'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['slug'] = slug;
    data['content'] = content;
    data['publish_date'] = publishDate;
    data['is_feature_blog'] = isFeatureBlog;
    data['reading_time'] = readingTime;
    data['image_url'] = imageUrl;
    data['image_dimension'] = imageDimension;
    data['likes'] = likes;
    data['views'] = views;
    data['misc'] = misc;
    data['is_published'] = isPublished;
    data['priority'] = priority;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['slug'] = slug;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoriazable_type'] = categoriazableType;
    data['categoriazable_id'] = categoriazableId;
    data['category_id'] = categoryId;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class BlogVideoTypeItem {
  final String keyName;
  final String displayName;

  BlogVideoTypeItem({required this.keyName, required this.displayName});
}


class BlogItemDetailResponse {
  bool? success;
  String? message;
  BlogItemData? data;
  String? error;

  BlogItemDetailResponse({this.success, this.message, this.data, this.error});

  BlogItemDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BlogItemData.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}
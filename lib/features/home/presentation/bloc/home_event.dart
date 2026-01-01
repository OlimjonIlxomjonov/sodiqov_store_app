class HomeEvent {
  HomeEvent();
}

class CategoryEvent extends HomeEvent {}

class ProductsEvent extends HomeEvent {
  final int page;

  ProductsEvent(this.page);
}

class ProductsBySlugEvent extends HomeEvent {
  final String slug;

  ProductsBySlugEvent(this.slug);
}

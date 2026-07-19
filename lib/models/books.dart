/// Represents a book entity used throughout the bookstore application.
///
/// Stores the core information required to display book details,
/// including title, author, pricing information, cover image asset,
/// and description.
class Book {
  final String title;
  final String author;
  final String price;
  final String coverAsset;
  final String description;

  const Book({
    required this.title,
    required this.author,
    required this.price,
    required this.coverAsset,
    required this.description,
  });
}

/// Sample book collection used as application data source.
///
/// This static dataset provides sample content for displaying books
/// in the bookstore interface during development and testing.
final List<Book> sampleBooks = [
  Book(
    title: 'بوف کور',
    author: 'صادق هدایت',
    price: '195,000 تومان',
    coverAsset: 'assets/images/book1.jpg',
    description:
    'یکی از شاخص ترین آثار ادبیات معاصر فارسی که با فضایی سوررئال و تاریک، به کاوش در ذهن راوی میپردازد.',
  ),
  Book(
    title: 'کیمیاگر',
    author: 'پائولو کوئیلو',
    price: '245,000 تومان',
    coverAsset: 'assets/images/book2.jpg',
    description:
    'داستان چوپانی جوان که برای یافتن گنج به سفری نمادین میرود و درس های زندگی میاموزد.',
  ),
  Book(
    title: 'جنایت و مکافات',
    author: 'داستایوفسکی',
    price: '499,000 تومان',
    coverAsset: 'assets/images/book3.jpg',
    description:
    'رمانی روانشناختی درباره گناه، عذاب وجدان و رستگاری در سنپترزبورگ قرن نوزدهم.',
  ),
  Book(
    title: 'خرمگس',
    author: 'اتل لیلیان وینیچ',
    price: '607,000 تومان',
    coverAsset: 'assets/images/book4.jpg',
    description: 'داستانی از عشق، انقلاب و فداکاری در ایتالیای قرن نوزدهم.',
  ),
  Book(
    title: 'شازده کوچولو',
    author: 'آنتوان دو سنت‌اگزوپری',
    price: '200,000 تومان',
    coverAsset: 'assets/images/book5.jpg',
    description: 'داستانی ساده و عمیق درباره دوستی، عشق و معنای زندگی.',
  ),
  Book(
    title: '۱۹۸۴',
    author: 'جورج اورول',
    price: '384,000 تومان',
    coverAsset: 'assets/images/book6.jpg',
    description:
    'رمانی دیستوپیایی درباره یک حکومت توتالیتر که بر تمام جنبه های زندگی مردم نظارت دارد.',
  ),
];
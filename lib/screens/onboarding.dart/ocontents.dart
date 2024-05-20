class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "احجز موعدك في مستوصف تداوي",
    image: "images/on1.png",
    desc: "بكل سهولة احجز موعدك خلال دقائق ",
  ),
  OnboardingContents(
    title: "ابحث عن عيادة أو دكتور",
    image: "images/on2.png",
    desc: "يمكنك البحث عن العيادة التي تريدها او دكتورك المفضل",
  ),
  OnboardingContents(
    title: "اختر التاريخ والوقت المناسبان",
    image: "images/on3.png",
    desc: "يمكنك وبكل سهولة اختيار التاريخ والوقت المناسبان لجدول مواعيدك",
  ),
];

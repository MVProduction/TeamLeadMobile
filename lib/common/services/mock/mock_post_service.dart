import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/post_service.dart';

/// Тестовый сервис для работы с постами
class MockPostService extends PostService {
  /// Все посты
  final _allPosts = [
    ServicePostData(
        1,
        "Зюзя Петрович",
        "Супер идея",
        DateTime(2020, 3, 11),
        "Собираю команду что бы создать приложение создающее приложение в целях создать приложение тем кому нужно приложение...",
        33,
        false),
    ServicePostData(
        2,
        "Галина Зильбермановна",
        "Приложение для снижения веса",
        DateTime(2020, 3, 14),
        "Ищу людей для создания мобильного приложения для контроля над весом. Ничего не знаю. Ничего не умею но хочу. Ищу тех кто умеет и знает и хочет. Пока за бесплатное...",
        12,
        false),
    ServicePostData(
        3,
        "Tegra",
        "Ищем художников и программистов",
        DateTime(2020, 3, 21),
        "Мы - небольшая группа начинающих разработчиков. Ищем в нашу команду художников и программистов С# на Unity. Опыт приветствуется, но не обязателен. Мой телеграмм  P01000",
        2,
        false),
    ServicePostData(
        4,
        "Klifford",
        "Сценарист в Команду!",
        DateTime(2020, 3, 23),
        "Мы - молодая, недавно сформированная команда, состоящая из Программиста, 3д-художника и Композитора.  Похвастаться завершенными проектами не можем. Тем не менее, каждый из нас имеет немалый опыт работы за плечами.",
        40,
        false),
    ServicePostData(
        5,
        "Hzpriezz",
        "Набираю людей в команду - Unity, Mobile",
        DateTime(2020, 3, 24),
        "Всех с наступившим 2020, рад что вы дожили и можете прочитать мой сабж. Кто я? - продюсер, лид гейм дизайнер. Что хочу? - добрать людей и развить команду Unity",
        26,
        true),
    ServicePostData(
        6,
        "Elis",
        "[Аркадия] Набор в команду [18+, 3D Unreal, Симулятор]",
        DateTime(2020, 3, 13),
        "Доброе, в данный момент ведётся разработка проекта на Unreal Engine. Симулятор с функционалом 18+ Начальный план это реализовать симулятор старшей школы. Школа + общежитие (мужское и женское) Далее уже постепенно наращивать функционал и сделать небольшой город примерно на 30 локаций. При этом чтобы в каждой локации был свой интересный и уникальный функционал. Каждый персонаж в игре был уникальным и с ним можно было полноценно взаимодействовать.",
        16,
        true),
    ServicePostData(
        7,
        "Alexander210483",
        "Groovy Movie Ищем сценариста.(Тема закрыта)",
        DateTime(2020, 3, 9),
        "Это история о начинающем продюсере, у которого есть мечта - снять захватывающее кино. В руки Криса попадает сценарий, с действительно интересной историей. Но, как вы догадываетесь, есть одно НО. Чтобы снять качественный полнометражный фильм нужна немалая сумма денег. Вот с этого момента и начинается история Кристофера Блэйка - человека, стремящегося за своей мечтой.",
        21,
        false),
    ServicePostData(
        8,
        "EGSP",
        "Ищу художника/аниматора 2d",
        DateTime(2020, 3, 2),
        "Игроку предстоит уничтожать брутальных роботов, имея под рукой целый склад вооружения, ради покорения нового мира! Создание собственных ботов, улучшение экипировки, применение различных способностей - механики, вносящие большое разнообразие в игровую среду.",
        54,
        false),
    ServicePostData(
        9,
        "pytachok",
        "Всем привет! Ищу художника/аниматора 2d для работы над играми. Сейчас в процессе разработки игра на Unity, под мобилы и браузеры.",
        DateTime(2020, 3, 1),
        "Игроку предстоит уничтожать брутальных роботов, имея под рукой целый склад вооружения, ради покорения нового мира! Создание собственных ботов, улучшение экипировки, применение различных способностей - механики, вносящие большое разнообразие в игровую среду.",
        45,
        false),
    ServicePostData(
        10,
        "pytachok",
        "Ищу художника в стиле фоллаут1",
        DateTime(2020, 3, 7),
        "Делаю игру аля fallout1-2 для андроид. Уже есть играбельный прототип. Понимаю что нельзя использовать графику от фолыча1 бетезда засудит нахрен.",
        23,
        false)
  ];

  /// Возвращает следующий id поста
  int get nextId => _allPosts.last.id + 1;

  /// Загружает посты из общего списка начиная с [firstId] в количестве [count]
  @override
  Future<List<ServicePostData>> loadPosts(int firstId, int count) async {
    if (firstId >= _allPosts.length) {
      return [];
    }

    var cnt = count;
    if (firstId + count > _allPosts.length) {
      cnt = _allPosts.length - firstId;
    }

    print("loadPosts: $firstId ${firstId + cnt}");
    return _allPosts.getRange(firstId, firstId + cnt).toList();
  }

  /// Возвращает избранное
  @override
  Future<List<ServicePostData>> loadUserFavoritePosts(String userName) async {
    return _allPosts.where((x) => x.isFavorite).toList();
  }

  /// Загружает посты пользователя
  @override
  Future<List<ServicePostData>> loadUserPosts(String userName) async {
    return _allPosts.where((x) => x.userName == userName).toList();
  }

  /// Добавляет в избранное
  @override
  Future addPostToFavorite(int postId) async {
    final post =
        _allPosts.firstWhere((x) => x.id == postId, orElse: () => null);
    post?.isFavorite = true;
  }

  /// Удаляет из избранного
  @override
  Future removePostFromFavorite(int postId) async {
    final post =
        _allPosts.firstWhere((x) => x.id == postId, orElse: () => null);
    post?.isFavorite = false;
  }

  /// Загружает пост
  @override
  Future<ServicePostData> loadPost(int postId) async {
    return _allPosts.firstWhere((x) => x.id == postId, orElse: () => null);
  }

  /// Создаёт пост
  @override
  Future createPost(String user, String title, String text) async {
    _allPosts.add(
        ServicePostData(nextId, user, title, DateTime.now(), text, 0, false));
  }

    /// Редактирует пост
  @override
  Future editPost(int postId, String title, String text) async {
    final post = await loadPost(postId);    
    post.title = title;
    post.text = text;
  }
}

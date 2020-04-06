# Домашнее задание

## Общее
Все материалы лекций лежат в 2020-spring/lectures

Раздел **cделать** нужно сдавать через pull request в этот репозиторий.
Делаешь fork, в папке 2020-spring создаешь папку со своим именем. В нее кладешь папку, названную номером домашнего задания.
Коммитишь, пушишь, создаешь pr. Я буду оставлять комментарии (ласковее чем Мартынов) и мерджить, если все ок.

Раздел **почитать** сдается через устные ответы на лекциях. Каждое занятие я буду случайно спрашивать вопросы с прошлого раза.
Особо принуждать к ответу не стану, но героя-одиночки, который будет отдуваться за всех, тоже не будет.

В папке Questions можно отыскать вопросы с реальных собесов джунов и пару тестовых (для собственного развития).
Чувствуй себя свободно добавлять туда свои вопросы/ответы через pr. 
Любая активность помимо домашек приветствуется, я готов помогать, советовать, ревьювить твои тестовые в компании.

По любым вопросам обращайся в личку в телеграмм @M0rtyMerr

## 29 февраля, ДЗ №1
#### Сделать:
Реализовать структуру данных Бинарное дерево. Что должно уметь:
 * добавлять элемент
 * удалять элемент
 * искать элемент
 * выполнять балансировку
 * работать с разными типами данных
 
#### Прочитать:
 * Protocol Oriented Programming
 * Closures
 * Automatic Reference Counting (ARC)
 * Copy-on-write

#### Материалы
 * [Swift.org](https://swift.org)/[swiftbook.ru](https://swiftbook.ru/content/languageguide) - документация по Swift с подробными примерами
 * [iOS-Developer-Roadmap](https://github.com/BohdanOrlov/iOS-Developer-Roadmap) - что должен знать junior/middle/senior ios разработчик. Вопросы и ссылки на статьи
 
 ## 3 Марта, ДЗ №2
 #### Запись лекции
 [Проверка домашки](https://vk.com/video-176491001_456239028)
 [Делаем приложение](https://vk.com/video-176491001_456239029)
 #### Сделать: 
 Создать приложение, выводящее таблицу сущностей, полученных из сети. Это уже реализовано на лекции, не стесняйтесь сверяться с проектом [RickAndMorty](https://github.com/SPBSTU-Mobile-development-courses/ios/tree/master/2020-spring/lectures/7.03/RickAndMorty).
 Главное, проделайте все сами, а не просто копируйте.  
 Можно использовать любое апи отсюда: https://github.com/public-apis/public-apis
 Я, например, взял это - https://rickandmortyapi.com/. можете использовать его же.
 
 Проверьте, что в API:
 * есть пагинация (вам возвращают ссылку на следующую страницу сущностей или номер следующей страницы)
 * есть картинки (сущность содержит ссылку на картинку/аватар сущности)
 
 Приложение должно:
 * выводить таблицу, где каждая ядейка содержит информацию об одной сущности (например, имя и картинка)
 * при скроле до конца таблицы загружать новую порцию сущностей
 * при клике на ячейку открывать детальный экран с информацией о выбранной сущности (UINavigationController в гугле)
 
 #### Прочитать
 * Что такое SOLID?
 * Зачем нужны strong, weak, unowned ссылки?
 * Чем асинхронность отличается от многопоточности?
 * Что такое GCD? Расскажите про виды очередей?
 
 #### Материалы
 * [Стиль кода](https://github.com/raywenderlich/swift-style-guide)
 * [Автоматическая проверка стиля кода](https://github.com/realm/SwiftLint/blob/master/Rules.md) - научимся в следующий раз
 * [Туториалы по iOS](https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2)
 * [Что такое POP? Доклад Александра Зимина](https://youtu.be/71AS4rMrAVk)

 ## 12 марта, ДЗ №3
 #### Запись лекции
 [Верстка, Линтер](https://vk.com/video-176491001_456239031) 
 #### Сделать
 * Добавить зависимость через [CocoaPods](https://cocoapods.org/). Как минимум линтер, но можешь использовать что-то интереснее.
 * Добавить линтер. Я сделал для тебя [конфиг файл с нужными правилами](https://github.com/SPBSTU-Mobile-development-courses/ios/blob/master/2020-spring/.swiftlint.yml). Его нужно положить в корень своего проекта. Можно спросить, зачем то или иное правило нужно
 * Добавить [констрейнты (autolayout)](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html), приложение должно нормально выглядеть на всех айфонах
 
 #### Прочитать
 * Что такое deadlock/livelock? Приведи пример, как добиться в iOS
 * Что такое KISS и DRY?
 * Перечислите все способы работы с optional в Swift?
 * В чем разница Dependency Injection и Dependency Inversion? Пример?
 * Что такое method dispatch? Какиой бывают в свифте?

 #### Материалы
 * [Autolayout](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)
 * [Как сверстано лента VK](https://habr.com/ru/company/vk/blog/481626/)
 
 ## 29 марта, ДЗ №4
 #### Запись лекции
 [Realm, кэш](https://vk.com/video-176491001_456239032)
 [Устройство на работу](https://vk.com/video-176491001_456239033)
 
 #### Сделать
 * Добавить поддержку оффлайн режима в приложение. Сохранить в базу загружаемые с API сущности и показывать их, если нет подключения. Можно использовать Realm/CoreData/SQLite
 * Добавить в приложение [pull-to-refresh](https://developer.apple.com/design/human-interface-guidelines/ios/controls/refresh-content-controls/)
 * (опционально) добавить в приложение индикатор загрузки следующей страницы данных с API. Долистали до низу таблицы -> показали индикатор активности -> отправили запрос -> дождались ответа -> спрятали индикатор активности
 * (опционально) подписаться на [мой подкаст](https://soundcloud.com/kuluarnyiy)
 
 #### Прочитать
 * (не успели в прошлый раз) В чем разница Dependency Injection и Dependency Inversion? Пример?
 * (не успели в прошлый раз) Что такое method dispatch? Какиой бывают в свифте?
 * Расшифровать и объяснить аббревиатуры CRUD и ACID
 * Функции высшего порядка: что это, зачем нужно, приведи пример в Swift
 * Что такое view.frame и view.bounds? Чем отличаются?
 
 #### Материалы
 [Map, filter, reduce](https://www.appcoda.com/higher-order-functions-swift/)
 [Про собесы от гуру](https://youtu.be/z1uTOrDqRfU)
 [Интересный видос про autolayout](https://developer.apple.com/videos/play/wwdc2018/220)
 
 ## 4 апреля, ДЗ №5 (на две недели)
 #### Запись лекции
 
 #### Сделать
 * Придумать и реализовать анимацию. Если идей нет, то сделай квадрат с тенью, бесконечно двигающийся по треугольной траектории
 * Реализовать поиск по таблице сущностей (по имени/тэгам). Обновление таблицы должно быть анимировано. Нужно считать поисковый запрос, получить отфильтрованный массив сущностей и найти его diff с изначальным. Затем к diff применить анимацию insert/delete/reload. Для поиска diff лучше использовать фреймворк
 
 #### Прочитать
 * (неправильно в прошлый раз) Что такое method dispatch? Какие виды есть в Swift? Назвать отличия
 * (неправильно в прошлый раз) Frame vs bounds? Когда bounds.origin не (0,0)?
 * Что такое CALayer? Зачем нужен? Отличие от UIView?
 * Что такое Explicit/implicit анимация?
 * Что такое layer model/presentation? В каких ситуациях у layer model/presentation разные значения?
 * Кто получает событие первым UIView или GestureRecognizer на нем?
 * Как рисовать на CPU, а как на GPU?
 
 #### Материалы
 [Diffable datasource, поможет в поиске](https://wwdcbysundell.com/2019/diffable-data-sources-first-look/)
 [Легко найти diff двух массивов](https://github.com/onmyway133/DeepDiff)
 [Про анимации от Apple](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/CreatingBasicAnimations/CreatingBasicAnimations.html)
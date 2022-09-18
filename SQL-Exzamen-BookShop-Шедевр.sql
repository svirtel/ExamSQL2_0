##1 Информация о задании
-- Экзаменационное задание  (выдано 24.08.2022)
-- Курс: Теория баз данных
/* 
1. Описание 
База данных Книжный магазин (BookShop) содержит информацию
о товаре и сделках сети книжных магазинов.
Книги, продаваемые в магазинах представлены в виде таблицы
Книги (Books), в которой собрана основная информация,
такая как: название, количество страниц, цена и дата
публикации. Также для каждой книги хранится ее автор
и тематика. При этом список всех авторов представлен таблицей
Авторы (Authors), а все доступные тематики содержатся
в таблице Тематики (Themes).
Для хранения всех проведенных в магазинах сделок (продаж
книг) используется таблица Продажи (Sales), в которой
описано что, где, когда, кем и за сколько было продано.
Сеть книжных магазинов представлена несколькими филиалами,
которые расположены в разных странах. Для хранения
данной информации присутствуют таблицы Магази-
ны (Shops) и Страны (Countries).

2. Таблицы
Как часть задания представлено детальное описание структуры каждой
таблицы базы данных Книжный магазин (BookShop), которую нужно создать. 
Требования к таблицам отображены как часть данного скрипта
"SQL-Exzamen-BookShop.sql" при создании таблиц. 
Требования к таблицам отображены также в файле с самим заданием 
"DT_Ekzamen_1530599128_Книжный-магазин.pdf". 
Перечисление таблиц базы данных Книжный магазин (BookShop): 
1) Авторы (Authors); 2) Книги (Books); 3) Страны (Countries);
4) Продажи (Sales); 5) Магазины (Shops); 6) Тематики (Themes). 

3. Структура базы данных
Может быть получена с использованием функции "Reverse Engineer..."

4. Задание
Необходимо написать следующие запросы к базе данных «Книжный магазин»:
1. Показать все книги, количество страниц в которых больше 500, но меньше 650.
2. Показать все книги, в которых первая буква названия либо «А», либо «З».
3. Показать все книги жанра «Детектив», количество проданных книг более 30 экземпляров.
4. Показать все книги, в названии которых есть слово «Microsoft», но нет слова «Windows».
5. Показать все книги (название, тематика, полное имя автора в одной ячейке), цена одной страницы которых меньше 65 копеек.
6. Показать все книги, название которых состоит из 4 слов.
7. Показать информацию о продажах в следующем виде:
- Название книги, но, чтобы оно не содержало букву «А».
- Тематика, но, чтобы не «Программирование».
- Автор, но, чтобы не «Герберт Шилдт».
- Цена, но, чтобы в диапазоне от 10 до 20 гривен.
- Количество продаж, но не менее 8 книг.
- Название магазина, который продал книгу, но он не должен быть в Украине или России.
8. Показать следующую информацию в два столбца (числа в правом столбце приведены в качестве примера):
- Количество авторов: 14
- Количество книг: 47
- Средняя цена продажи: 85.43 грн.
- Среднее количество страниц: 650.6.
9. Показать тематики книг и сумму страниц всех книг по каждой из них.
10. Показать количество всех книг и сумму страниц этих книг по каждому из авторов.
11. Показать книгу тематики «Программирование» с наибольшим количеством страниц.
12. Показать среднее количество страниц по каждой тематике, которое не превышает 400.
13. Показать сумму страниц по каждой тематике, учитывая только книги с количеством страниц более 400, и чтобы
тематики были «Программирование», «Администрирование» и «Дизайн».
14. Показать информацию о работе магазинов: что, где, кем, когда и в каком количестве было продано.
15. Показать самый прибыльный магазин. 

*/ 

##2 Создание базы данных
CREATE database BookShop; 
USE BookShop; 

##3 Создание таблиц
#3.1 Создание таблицы 3) Страны (Countries)
CREATE TABLE Countries (ID int auto_increment not null primary key, 
Name varchar(50) not null check(Name <> N'') unique); 

#3.2 Создание таблицы 1) Авторы (Authors)
CREATE TABLE Authors (ID int auto_increment not null primary key,
Name varchar(275) not null check(Name <> N''),
Surname varchar(275) not null check(Surname <> N''),
CountryId int not null,
Foreign key (CountryID) References Countries (id)); 

#3.3 Создание таблицы 5) Магазины (Shops)
Create table Shops (ID int auto_increment not null primary key,
Name varchar(275) not null check(Name <> N''),
Countryid int not null,
Foreign key (CountryID) References Countries(id)); 

#3.4 Создание таблицы 6) Тематики (Themes)
Create table Themes (Id int auto_increment not null primary key,
Name varchar(275) not null check(Name <> N'') unique); 

#3.5 Создание таблицы 2) Книги (Books)
Create table Books (Id int auto_increment not null primary key,
Name varchar(575) not null check(Name <> N''),
Pages int not null check(Pages > 0),
Price decimal(10,2) not null check(Price >= 0), 
PublishDate date not null check(PublishDate <= sysdate()),
AuthorId int not null,
Foreign key (AuthorId) References Authors(Id),
ThemeId int not null,
Foreign key(ThemeId) References Themes(Id)); 

 #3.6 Создание таблицы 4) Продажи (Sales)
 Create table Sales (Id int auto_increment not null primary key,
 Price decimal(10,2) not null check(Price >= 0), # Все цены продаж указаны в гривнах 
 Quantity int not null check(Quantity > 0),
 SaleDate date not null check(SaleDate <= sysdate()) default (sysdate()),
 BookId int not null,
 Foreign key (BookId) References Books(Id),
 ShopId int not null,
 Foreign key(ShopId) References Shops(Id)); 


##4 Добавление данных 
#4.1 Добавление стран
Insert into Countries values (1, "Украина"), (2, "Россия"), (3, "Казахстан"); 
Select * from Countries order by id; 

#4.2 Добавление авторов
Insert into Authors Values (1, "Денис", "Бравко", 1), (2, 'Петро', 'Рыбик', 1), (3, 'Александр', 'Дымов', 1), (4, 'Герберт', 'Шилдт', 1), 
(5, "Дмитрий", "Ермак", 2), (6, 'Прокофий', 'Раевский', 2), (7, 'Артем', 'Дубов', 2), (8, 'Данияр', 'Илантьев', 2), 
(9, "Даулет", "Еркилов", 3), (10, 'Палуан', 'Рысмухамбетов', 3), (11, 'Арман', 'Дандаев', 3), (12, 'Думан', 'Итымбаев', 3); 
Select * from Authors; 

#4.3 Добавление магазинов
Insert into Shops values (1, "КосмоКнига - Созвездие Рыбы", 1), (2, "КосмоКнига - Созвездие Змееносец", 1), (3, "КосмоКнига - Млечный Путь", 2),
(4, "КосмоКнига - Андромеда", 2), (5, "КосмоКнига - Сверхскопление Девы", 3), (6, "КосмоКнига - Сверхскопление Гидры-Центавра", 3); 
Select * from Shops; 

#4.4 Добавление тематик
Insert into Themes values (1, 'Детективы'), (2, 'Программирование'), (3, 'Администрирование'), (4, 'Дизайн'); 
Select * from Themes order by Id; 

#4.5 Добавление книг
Insert into Books values(1, 'Вырванная страница', 400, 0.15, '2020-09-19', 4, 1), (2, 'Азбука Преступления', 500, 0.15, '2021-09-19', 4, 1), 
(3, 'Advanced Unknown', 550, 0.65, '2020-09-19', 4, 1), (4, 'Знак мельхиора', 650, 0.65, '2021-09-19', 4, 1),
(5, '3 маршрута', 780, 0.75, '2020-09-19', 4, 1);  
Insert into Books values(6, 'Hard and Soft Microsoft, Part 1', 400, 105.15, '2012-09-18', 1, 2), (7, 'Hard and Soft Microsoft, Part 2', 380, 205.15, '2014-09-18', 1, 2), 
(8, 'Microsoft Windows для девелоперов', 670, 305.15, '2014-06-18', 2, 2), (9, 'Microsoft Windows для архитекторов', 576, 305.15, '2016-06-18', 2, 2),
(10, 'Windows для программистов, Теория', 340, 266, '2016-01-18', 3, 2), (11, 'Windows для программистов, Практические задачи', 298, 165, '2018-12-18', 3, 2);
Insert into Books values (12, 'Основы PC', 311, 15, '2019-03-08', 5, 3), (13, 'ААА-администрирование', 400, 5, '2020-05-24', 6, 3), 
(14, 'Все задачи админа', 501, 5, '2021-08-31', 9, 3);
Insert into Books values(15, 'Выбор комьютерной дизайн-программы', 234, 350, '2021-07-07', 7, 4), (16, 'Лучший дизайн на PC', 400, 250, '2022-01-15', 8, 4),
(17, 'Программная графика', 495, 99, '2022-02-02', 10, 4), (18, 'Графика и дизайн', 112, 55, '2021-10-12', 11, 4), 
(19, 'Картинная перспектива картинки', 195, 44, '2021-11-13', 12, 4);
Select * from Books; 

#4.6 Добавление продаж 
Insert into Sales values(1, 0.15, 30, '2022-03-01', 1, 1), (2, 0.15, 31, '2022-03-02', 2, 2), (3, 0.65, 32, '2022-03-03', 3, 3), (4, 0.65, 28, '2022-04-04', 4, 4), 
(5, 0.75, 29, '2022-05-05', 5, 5), (6, 105.15, 6, '2022-06-06', 6, 6), (7, 205.15, 7, '2022-07-07', 7, 1), (8, 305.15, 8, '2022-08-08', 8, 2), 
(9, 305.15, 9, '2022-09-09', 9, 3), (10, 266, 10, '2022-05-02', 10, 4),(11, 165, 11, '2022-03-02', 11, 5), (12, 15, 12, '2022-04-02', 12, 6),
(13, 5, 4, '2022-05-02', 13, 1), (14, 5, 14, '2022-06-02', 14, 2),(15, 230, 15, '2022-07-02', 15, 3), (16, 250, 16, '2022-08-02', 16, 4),
(17, 99, 17, '2022-09-02', 17, 5),(18, 55, 18, '2022-04-04', 18, 6),(19, 44, 19, '2022-05-04', 19, 1); 
Select * from Sales; 


##5 Запросы
#1. Показать все книги, количество страниц в которых больше 500, но меньше 650.
SELECT Name as NamewithPagesIncluding501to649 FROM Books WHERE Pages > 500 AND  Pages < 650;

#2. Показать все книги, в которых первая буква названия либо «А», либо «З».
SELECT Name З_или_A_ПерваяБукваНазвания FROM Books WHERE (Name LIKE 'З%') OR (Name LIKE 'А%') OR (Name LIKE 'A%');

#3. Показать все книги жанра «Детектив», количество проданных книг более 30 экземпляров.
SELECT B.Name Более30ДетективныхКниг FROM Books B
JOIN Sales S on S.BookId = B.Id 
JOIN Themes T on T.Id = B.ThemeId 
WHERE T.Name = 'Детективы' AND S.Quantity > 30; 

#4. Показать все книги, в названии которых есть слово «Microsoft», но нет слова «Windows».
SELECT Name FROM Books WHERE NOT (Name REGEXP  'Windows') AND Name like '%Microsoft%';

#5. Показать все книги (название, тематика, полное имя автора в одной ячейке), цена одной страницы которых меньше 65 копеек.
SELECT CONCAT(' " ', B.Name, ' " ', ' , ', ' " ', T.Name, ' " ', ' , ', ' " ',(SELECT concat(A.SurName, " " , A.Name)), ' " ') as КнигиСЦенойСтраницыМеньше65Kопеек
FROM Books B 
JOIN Themes T on T.Id = B.ThemeId 
JOIN Authors A on A.Id = B.AuthorId 
WHERE B.Price / B.Pages < 0.65; 

#6. Показать все книги, название которых состоит из 4 слов.
select * from Books 
where Name like '% % % %' and not Name like '% % % % %';

#7. Показать информацию о продажах в следующем виде:
-- Название книги, но, чтобы оно не содержало букву «А».
-- Тематика, но, чтобы не «Программирование».
-- Автор, но, чтобы не «Герберт Шилдт».
-- Цена, но, чтобы в диапазоне от 10 до 20 гривен.
-- Количество продаж, но не менее 8 книг.
-- Название магазина, который продал книгу, но он не должен быть в Украине или России.
select * from Books
join Themes on Themes.Id = Books.ThemeId
join Authors on Authors.Id = Books.AuthorId
join Sales on Sales.BookId = Books.Id
join Shops on Shops.Id = Sales.ShopId
join Countries on Countries.Id = Shops.CountryId
where not Books.name like '%А%'
and not Books.name like '%A%'
and not Themes.name = "Программирование"
and not Authors.name = "Герберт"
and Books.price between 10 and 1800
and Quantity >= 8
and not Countries.name = "Украина" or "Россия";

#8. Показать следующую информацию в два столбца (числа в правом столбце приведены в качестве примера):
-- Количество авторов: 14
-- Количество книг: 47
-- Средняя цена продажи: 85.43 грн.
-- Среднее количество страниц: 650.6.
SELECT 'Количество авторов:' as Наименование , COUNT(*) as Значение, 'чел. ' as "Единица измерения" FROM Authors
UNION
(SELECT 'Количество книг:', COUNT(*), 'наименований' FROM Books)
UNION
(SELECT 'Средняя цена продажи:', AVG(Sales.Quantity * Sales.Price), 'грн.' FROM Sales)
UNION
(SELECT 'Среднее количество страниц:', AVG(Books.Pages),'стр.' FROM Books);
Select * from Sales; 

#9. Показать тематики книг и сумму страниц всех книг по каждой из них.
SELECT T.Name as Тематика,  SUM(B.Pages) as 'Сумма страниц всех книг по каждой тематике' FROM Books B 
JOIN Themes T on B.ThemeId = T.Id 
GROUP by T.Name;

#10. Показать количество всех книг и сумму страниц этих книг по каждому из авторов.
select Concat(A.Surname, ' ', A.name) as 'Авторы книг', count(B.Id) as 'Количество разных книг одного автора, шт.',
sum(B.Pages) as 'Сумма страниц разных книг одного автора, стр.' from Books B
join Authors A on A.Id = B.AuthorId
group by A.name;

#11. Показать книгу тематики «Программирование» с наибольшим количеством страниц. 
SELECT T.Name as 'Тематика книги', B.Name as 'Название книги', B.Pages as 'Количество страниц в книге с наибольшим количеством страниц, стр.' from Books B
Join Themes T on T.Id = B.ThemeId 
where T.Name = 'Программирование' 
and B.Pages = (SELECT MAX(B.Pages) from Books B 
Join Themes on T.Id = B.ThemeId
where T.Name = 'Программирование');  

#12. Показать среднее количество страниц по каждой тематике, которое не превышает 400.
select T.name, avg(B.Pages) from Books B
join Themes T on T.Id = B.ThemeId
group by T.name
having avg(B.Pages) <= 400; 

#13. Показать сумму страниц по каждой тематике, учитывая только книги с количеством страниц более 400, и чтобы
#    тематики были «Программирование», «Администрирование » и «Дизайн».
SELECT T.Name as 'Тематика книги', SUM(B.Pages) as 'Cумма страниц по каждой тематике, учитывая только книги с количеством страниц более 400, 
и чтобы тематики были «Программирование», «Администрирование » и «Дизайн»', 'стр.' FROM Books B
JOIN Themes T on T.Id = B.ThemeId 
WHERE B.Pages > 400 and T.id IN ('2','3','4')
GROUP by B.ThemeId; 

#14. Показать информацию о работе магазинов: что, где, кем, когда и в каком количестве было продано.
SELECT S.Name as 'Название магазина, где была совершена покупка', C.Name as 'Магазин находится в стране', Sales.SaleDate , B.Name as 'Название книги',
Sales.Quantity as 'Количество книг в одной продаже, шт.' FROM Sales 
JOIN Shops S on S.Id = Sales.ShopId 
JOIN Books B on B.Id = Sales.BookId 
JOIN Countries C on C.Id = S.CountryId 
ORDER by Sales.ShopId;

#15. Показать самый прибыльный магазин.
#15.1 Для проверки
# Select * from Sales; 
# Select Shops.name, SUM(Price * Quantity) as "Прибыль" from Shops join Sales on Sales.ShopId = Shops.Id GROUP by Shops.id; 

#15.2 Скрипт выбора самого прибыльного магазина
WITH TotalShopSum AS (
	SELECT SUM(Sales.Price * Sales.Quantity) as Purchase, Shops.Name FROM Sales 
	JOIN Shops on Shops.Id = Sales.ShopId 
	JOIN Books on Books.Id = Sales.BookId 
	GROUP by Shops.Name 
)
SELECT TotalShopSum.Name 'Название самого прибыльного магазина', Purchase FROM TotalShopSum
WHERE TotalShopSum.Purchase = (SELECT MAX(TotalShopSum.Purchase) FROM TotalShopSum);


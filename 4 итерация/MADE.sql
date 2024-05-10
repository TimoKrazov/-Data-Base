--1.Просмотр аниме с высоким рейтингом(Фильтр + рейтинг)
SELECT name_anime, age_limit, number_of_episodes, average_rating  FROM anime
WHERE average_rating >= 7.5

--2.Просмотр количества аниме по возрастному рейтингу (Фильтр)
SELECT age_limit, COUNT(*) AS age FROM anime
GROUP BY age_limit;

--3.Показывает, сколько пользователь просмотрел аниме (Сбор статистики + рейтинг)
SELECT login, COUNT(name_anime) AS numbers_view_anime FROM connection_anime_user
GROUP BY login

--4.Выводит аниме, у которых много отзывов и хороший рейтинг. (Фильтр)
SELECT name_anime, COUNT(id_reviews) AS quantity_reviews, AVG(rating) AS average_rating  FROM rating_reviews
GROUP BY name_anime
HAVING COUNT(id_reviews) >= 3 AND  AVG(rating) > 8

--5. Просмотр, Какие студии озвучили то или иное аниме (Фильтр)
SELECT name_anime, name_studio FROM connection_anime_voice_over_studio
ORDER BY name_anime, name_studio

--6. Проверка соблюдения возрастного ограничения с возрастом зрителей. (Обнаружение наршителей сайта)

SELECT connection_anime_user.login, users.age_users, connection_anime_user.name_anime, anime.age_limit FROM connection_anime_user
INNER JOIN anime ON connection_anime_user.name_anime = anime.name_anime
INNER JOIN users ON connection_anime_user.login = users.login
WHERE age_users < CAST(REPLACE(age_limit,'+','') AS INT)

--7. Статистика среди гендеров (Сбор статистики)
SELECT name_anime, 
        (SELECT COUNT(*) FROM connection_anime_user
        INNER JOIN users ON connection_anime_user.login = users.login
        WHERE users.gender = 'male' AND anime.name_anime = connection_anime_user.name_anime) AS view_male,
        (SELECT COUNT(*) FROM connection_anime_user
        INNER JOIN users ON connection_anime_user.login = users.login
        WHERE users.gender = 'female' AND anime.name_anime = connection_anime_user.name_anime) AS view_female,
        (SELECT COUNT(*) FROM connection_anime_user
        INNER JOIN users ON connection_anime_user.login = users.login
        WHERE users.gender = 'not defined' AND anime.name_anime = connection_anime_user.name_anime) AS view_not_defined
FROM anime


--8. Вывод постов и превью для ознакомления (описание)
SELECT anime.name_anime, poster.poster_image_link, presentation.text_presentation FROM anime
LEFT JOIN poster ON anime.name_anime = poster.name_anime
LEFT JOIN presentation ON anime.name_anime = presentation.name_anime
ORDER BY name_anime

--9. Популярность по просмотрам (топ5-рейтинг)
SELECT name_anime, COUNT(login) AS views FROM connection_anime_user
GROUP BY name_anime
ORDER By views DESC LIMIT 5

--10 Просмотр, сколько жанр содержит аниме (фильтр)
SELECT name_genre, COUNT(name_anime) AS numbers_anime FROM connection_anime_genre
GROUP BY name_genre

--11 Просмотр, какие жанры содержит аниме (описание)
SELECT name_anime, name_genre FROM connection_anime_genre
ORDER BY name_anime, name_genre

--12 Просмотр, какие аниме принадлежат данному жанру (фильтр)
SELECT name_genre, name_anime FROM connection_anime_genre
ORDER BY name_genre, name_anime

--представление

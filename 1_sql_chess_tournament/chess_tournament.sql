-- Тестовое задание проектирования базы данных шахматного турнира

-- Содержание:
-- 1. Удаление таблиц перед стартом
-- 2. Создание таблиц
-- 3. Заполнение данными
-- 4. Запрос возвращающий победителей текущего года, которые победили два или более раз.

-- 1. Удаление таблиц перед стартом
DROP TABLE IF EXISTS tournaments, players, tournaments_players_relationship;

-- 2. Создание таблиц
CREATE TABLE tournaments
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    date DATE NOT NULL
);

CREATE TABLE players
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE tournaments_players_relationship
(
    id_player INT NOT NULL,
    id_tournament INT NOT NULL,
    is_winner BOOLEAN DEFAULT FALSE
);

-- 3. Заполнение данными
INSERT INTO players (name)
VALUES ('Luke Gregory'),
       ('Manraj Lawrence'),
       ('Nyla Dunkley'),
       ('Jaye Baldwin'),
       ('Rianne Hays'),
       ('Sue Mooney'),
       ('Tudor Lester'),
       ('Anton Lawson'),
       ('Tyriq Metcalfe'),
       ('Brandon Munoz')
;

INSERT INTO tournaments (name, date)
VALUES
       ('T1', '2017-01-05'),
       ('T2', '2017-10-24'),
       ('T3', '2017-12-14'),
       ('T4', '2018-06-02'),
       ('T5', '2018-08-10'),
       ('T6', '2018-11-28'),
       ('T7', '2018-12-07'),
       ('T8', '2019-02-28'),
       ('T9', '2019-04-23'),
       ('T10', '2019-04-26'),
       ('T11', '2019-06-09'),
       ('T12', '2019-12-05'),
       ('T13', '2020-02-05'),
       ('T14', '2020-04-08'),
       ('T15', '2020-10-09'),
       ('T16', '2017-02-02'),
       ('T17', '2017-03-29'),
       ('T18', '2018-01-23'),
       ('T19', '2018-05-17'),
       ('T20', '2018-09-05'),
       ('T20', '2018-11-05'),
       ('T21', '2019-02-11'),
       ('T22', '2019-03-15'),
       ('T23', '2019-03-26'),
       ('T24', '2019-05-01'),
       ('T25', '2019-06-23'),
       ('T26', '2019-07-31'),
       ('T27', '2020-03-17'),
       ('T28', '2020-09-30'),
       ('T29', '2020-11-23'),
       ('T30', '2020-09-01')
;

INSERT INTO tournaments_players_relationship (id_player, id_tournament, is_winner)
VALUES (1, 2, FALSE),
       (1, 10, TRUE),
       (1, 13, FALSE),
       (1, 14, TRUE),
       (1, 16, FALSE),
       (1, 19, FALSE),
       (1, 22, FALSE),
       (1, 25, FALSE),
       (1, 31, TRUE),
       (2, 4, FALSE),
       (2, 8, FALSE),
       (2, 11, TRUE),
       (2, 12, FALSE),
       (2, 16, TRUE),
       (2, 19, FALSE),
       (2, 21, TRUE),
       (2, 29, FALSE),
       (3, 2, TRUE),
       (3, 7, FALSE),
       (3, 8, FALSE),
       (3, 13, FALSE),
       (3, 17, FALSE),
       (3, 22, FALSE),
       (4, 1, FALSE),
       (4, 12, FALSE),
       (4, 13, FALSE),
       (4, 14, FALSE),
       (4, 16, FALSE),
       (4, 23, FALSE),
       (4, 28, FALSE),
       (4, 29, FALSE),
       (4, 31, FALSE),
       (5, 3, FALSE),
       (5, 8, FALSE),
       (5, 9, TRUE),
       (5, 10, FALSE),
       (5, 12, TRUE),
       (5, 15, TRUE),
       (5, 18, TRUE),
       (5, 21, FALSE),
       (5, 24, FALSE),
       (5, 26, FALSE),
       (5, 27, FALSE),
       (6, 5, TRUE),
       (6, 11, FALSE),
       (6, 13, FALSE),
       (6, 16, FALSE),
       (6, 20, FALSE),
       (6, 21, FALSE),
       (7, 2, FALSE),
       (7, 10, FALSE),
       (7, 11, FALSE),
       (7, 15, FALSE),
       (7, 19, FALSE),
       (7, 21, FALSE),
       (7, 28, FALSE),
       (7, 31, FALSE),
       (8, 1, FALSE),
       (8, 2, FALSE),
       (8, 3, TRUE),
       (8, 20, FALSE),
       (8, 22, FALSE),
       (8, 24, FALSE),
       (9, 1, FALSE),
       (9, 12, FALSE),
       (9, 14, FALSE),
       (9, 18, FALSE),
       (9, 20, TRUE),
       (9, 22, FALSE),
       (9, 24, FALSE),
       (9, 29, FALSE),
       (9, 30, FALSE),
       (10, 3, FALSE),
       (10, 4, FALSE),
       (10, 5, FALSE),
       (10, 7, FALSE),
       (10, 13, TRUE),
       (10, 17, FALSE),
       (10, 20, FALSE),
       (10, 24, FALSE),
       (10, 25, FALSE),
       (10, 28, TRUE),
       (10, 30, TRUE)
;

-- 4. Запрос должен возвращать победителей текущего года, которые победили два или более раз.
-- Поля: Имя участника, Количество побед, Количество посещенных турниров.
SELECT players.name,
       count(r.id_player)    visits,
       sum(r.is_winner::int) victories
FROM tournaments_players_relationship r
         JOIN players
              ON players.id = r.id_player
         JOIN tournaments
              ON tournaments.id = r.id_tournament
                  AND EXTRACT(year FROM tournaments.date) = date_part('year', CURRENT_DATE)
                  -- Вариант:
                  -- AND tournaments.date >= '2020-01-01'
GROUP BY players.id
HAVING sum(r.is_winner::int) >= 2
;

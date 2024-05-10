

-- Создание таблицы "anime"
CREATE TABLE IF NOT EXISTS anime (
    id_name SERIAL PRIMARY KEY,
    name_anime VARCHAR(256) UNIQUE NOT NULL ,
    number_of_episodes INTEGER NOT NULL,
    age_limit VARCHAR(256) NOT NULL,
    average_rating DECIMAL(3,1) DEFAULT NULL CHECK (average_rating >= 0 AND average_rating <= 10)
);

-- Создание таблицы "users"
CREATE TABLE IF NOT EXISTS users (
    id_users SERIAL PRIMARY KEY,
    login VARCHAR(256) UNIQUE NOT NULL,
    password VARCHAR(256) NOT NULL,
    gender VARCHAR(256) DEFAULT 'not defined' CHECK (gender = 'male' OR gender = 'female' OR gender = 'not defined'),
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    age_users INTEGER NOT NULL
);

-- Создание таблицы "connection_anime_user"
CREATE TABLE IF NOT EXISTS connection_anime_user (
    id_connection SERIAL PRIMARY KEY,
    login VARCHAR(256) REFERENCES users(login) ON DELETE CASCADE,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE
);

-- Создание таблицы "presentation"
CREATE TABLE IF NOT EXISTS presentation (
    id_presentation SERIAL PRIMARY KEY,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE,
    text_presentation VARCHAR(10000) UNIQUE
);

-- Создание таблицы "poster"
CREATE TABLE IF NOT EXISTS poster (
    id_poster SERIAL PRIMARY KEY,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE,
    poster_image_link VARCHAR(1000) UNIQUE
);

-- Создание таблицы "voice_over_studio"
CREATE TABLE IF NOT EXISTS voice_over_studio (
    id_studio SERIAL PRIMARY KEY,
    name_studio VARCHAR(256) UNIQUE NOT NULL
);

-- Создание таблицы "connection_anime_voice_over_studio"
CREATE TABLE IF NOT EXISTS connection_anime_voice_over_studio (
    id_connection SERIAL PRIMARY KEY,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE,
    name_studio VARCHAR(256) REFERENCES voice_over_studio(name_studio) ON DELETE CASCADE
);

-- Создание таблицы "genre"
CREATE TABLE IF NOT EXISTS genre (
    id_genre SERIAL PRIMARY KEY,
    name_genre VARCHAR(256) UNIQUE NOT NULL,
    description_genre VARCHAR(10000) NOT NULL
);

-- Создание таблицы "connection_anime_genre"
CREATE TABLE IF NOT EXISTS connection_anime_genre (
    id_connection SERIAL PRIMARY KEY,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE,
    name_genre VARCHAR(256) REFERENCES genre(name_genre)
);



-- Создание таблицы "rating_reviews"
CREATE TABLE IF NOT EXISTS rating_reviews (
    id_reviews SERIAL PRIMARY KEY,
    login VARCHAR(256) REFERENCES users(login) ON DELETE CASCADE,
    name_anime VARCHAR(256) REFERENCES anime(name_anime) ON DELETE CASCADE,
    rating INTEGER DEFAULT 0 CHECK (rating >= 0 AND rating <= 10),
    reviews VARCHAR(256) DEFAULT 'no reviews' NOT NULL,
    date_review DATE NOT NULL
);
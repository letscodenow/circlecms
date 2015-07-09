-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Хост: localhost:3306
-- Время создания: Июл 09 2015 г., 20:38
-- Версия сервера: 5.5.38
-- Версия PHP: 5.5.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `circlecms`
--
CREATE DATABASE IF NOT EXISTS `circlecms` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `circlecms`;

-- --------------------------------------------------------

--
-- Структура таблицы `media`
--

CREATE TABLE IF NOT EXISTS `media` (
`id` int(10) unsigned NOT NULL,
  `media_name` varchar(200) NOT NULL,
  `media_file` varchar(250) NOT NULL,
  `media_type` enum('image','video') NOT NULL DEFAULT 'image',
  `author_id` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
`id` mediumint(8) unsigned NOT NULL,
  `title` varchar(150) NOT NULL,
  `content_md` text NOT NULL,
  `content_html` text NOT NULL,
  `author_id` tinyint(3) unsigned NOT NULL,
  `likes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `status` enum('1','0') NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `title`, `content_md`, `content_html`, `author_id`, `likes`, `status`, `created_at`) VALUES
(1, 'We Don’t Need More Designers Who Can Code', 'A lot has been made of the need for designers who can code. A quick google search for “[should designers learn to code](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=should%20designers%20learn%20to%20code)” yields 25 million results.\n\nTo be straight from the outset, I don’t completely disagree with the premise. However, I think the statement, “we need designers who can code” misrepresents the underlying issue.\n\nAs the head of a product design team, who can also write code (front and back end), I understand the value of the combined skill set. The ability to prototype, the ability to converse cross-discipline, and the ability to understand capabilities and tweak implementations. But I also know where the boundaries lie. I am not a developer and I wouldn’t want my code underlying a production application at scale.\n\n[{cut}]\n\nSaying designers should code creates a sense that we should all be pushing commits to production environments. Or that design teams and development teams are somehow destined to merge into one team of superhuman, full-stack internet monsters.\n\nLet’s get real here. Design and development (both front end and back end) are highly specialized professions. Each takes years and countless hours to master. To expect that someone is going to become an expert in more than one is foolhardy.\n\n>**_Here’s what we really need:_** designers who can design the hell out of things and developers who can develop the hell out of things. And we need them all to work together seamlessly.\n\nThis requires one key element: empathy.\n\nWhat we should be saying is that we need more designers who know _about_ code.\n\nThe reason designers should know about code, is the same reason developers should know _about_ design. Not to become designers, but to empathize with them. To be able to speak their language, and to understand design considerations and thought processes. To know just enough to be dangerous, as they say.\n\nThis is the sort of thing that breaks down silos, opens up conversations and leads to great work. But the key is that it also does not impede the ability of people to become true experts in their area of focus.\n\nWhen someone says they want “designers who can code”, what I hear them saying is that they want a Swiss Army knife. The screwdriver, scissors, knife, toothpick and saw. The problem is that a Swiss Army knife doesn’t do _anything_ particularly well. You aren’t going to see a carpenter driving screws with that little nub of a screwdriver, or a seamstress using those tiny scissors to cut fabric. The Swiss Army knife has tools that work on the most basic level, but they would never be considered replacements for the real thing. Worse still, because it tries to do so much, it’s not even that great at being a knife.\n\n>Professionals need specialized tools. Likewise, professional teams need specialized team members.\n\nI don’t want my designers spending all their time keeping up with the latest cross-browser CSS solutions or learning how to use javascript closures. In the same way that I wouldn’t want our developers spending all their time diving into color theory.\n\nI want my designers staying up on mobile interface standards and the latest usability best practices. I want them studying our users and identifying unmet needs. I want them focused on the work that is going to make our product the best that it can be. And yes, part of that work means learning about code, so they can be effective, empathetic members of the larger product team.\n\nNow, implicit in learning about code or about design is getting your hands dirty. So this does mean that developers should be able to look critically at design concepts from a user-centered perspective, and that designers should be able to understand the basic underpinnings of how their design will be implemented. If they can also throw together a rough prototype, bonus. But we need to rid ourselves of the idea (and pressure) that designers should be coders, or that developers should be designers.\n\nConvergence has its place, but this is not it.\n\nIf you empower your team to focus on their strengths as well as do some work to gain empathy for their teammates, then you don’t need Swiss Army knives. Instead, you have a toolbox full of experts that now work better together.\n\nThat’s what we really need.', '<p>A lot has been made of the need for designers who can code. A quick google search for “<a href="https://www.google.com/webhp?sourceid=chrome-instant&amp;ion=1&amp;espv=2&amp;ie=UTF-8#q=should%20designers%20learn%20to%20code">should designers learn to code</a>” yields 25 million results.</p>\n<p>To be straight from the outset, I don’t completely disagree with the premise. However, I think the statement, “we need designers who can code” misrepresents the underlying issue.</p>\n<p>As the head of a product design team, who can also write code (front and back end), I understand the value of the combined skill set. The ability to prototype, the ability to converse cross-discipline, and the ability to understand capabilities and tweak implementations. But I also know where the boundaries lie. I am not a developer and I wouldn’t want my code underlying a production application at scale.</p>\n<p>[{cut}]</p>\n<p>Saying designers should code creates a sense that we should all be pushing commits to production environments. Or that design teams and development teams are somehow destined to merge into one team of superhuman, full-stack internet monsters.</p>\n<p>Let’s get real here. Design and development (both front end and back end) are highly specialized professions. Each takes years and countless hours to master. To expect that someone is going to become an expert in more than one is foolhardy.</p>\n<blockquote>\n<p><strong><em>Here’s what we really need:</em></strong> designers who can design the hell out of things and developers who can develop the hell out of things. And we need them all to work together seamlessly.</p>\n</blockquote>\n<p>This requires one key element: empathy.</p>\n<p>What we should be saying is that we need more designers who know <em>about</em> code.</p>\n<p>The reason designers should know about code, is the same reason developers should know <em>about</em> design. Not to become designers, but to empathize with them. To be able to speak their language, and to understand design considerations and thought processes. To know just enough to be dangerous, as they say.</p>\n<p>This is the sort of thing that breaks down silos, opens up conversations and leads to great work. But the key is that it also does not impede the ability of people to become true experts in their area of focus.</p>\n<p>When someone says they want “designers who can code”, what I hear them saying is that they want a Swiss Army knife. The screwdriver, scissors, knife, toothpick and saw. The problem is that a Swiss Army knife doesn’t do <em>anything</em> particularly well. You aren’t going to see a carpenter driving screws with that little nub of a screwdriver, or a seamstress using those tiny scissors to cut fabric. The Swiss Army knife has tools that work on the most basic level, but they would never be considered replacements for the real thing. Worse still, because it tries to do so much, it’s not even that great at being a knife.</p>\n<blockquote>\n<p>Professionals need specialized tools. Likewise, professional teams need specialized team members.</p>\n</blockquote>\n<p>I don’t want my designers spending all their time keeping up with the latest cross-browser CSS solutions or learning how to use javascript closures. In the same way that I wouldn’t want our developers spending all their time diving into color theory.</p>\n<p>I want my designers staying up on mobile interface standards and the latest usability best practices. I want them studying our users and identifying unmet needs. I want them focused on the work that is going to make our product the best that it can be. And yes, part of that work means learning about code, so they can be effective, empathetic members of the larger product team.</p>\n<p>Now, implicit in learning about code or about design is getting your hands dirty. So this does mean that developers should be able to look critically at design concepts from a user-centered perspective, and that designers should be able to understand the basic underpinnings of how their design will be implemented. If they can also throw together a rough prototype, bonus. But we need to rid ourselves of the idea (and pressure) that designers should be coders, or that developers should be designers.</p>\n<p>Convergence has its place, but this is not it.</p>\n<p>If you empower your team to focus on their strengths as well as do some work to gain empathy for their teammates, then you don’t need Swiss Army knives. Instead, you have a toolbox full of experts that now work better together.</p>\n<p>That’s what we really need.</p>', 1, 0, '1', '2015-07-09 17:59:28');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` tinyint(3) unsigned NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` enum('administrator','editor') NOT NULL DEFAULT 'editor',
  `status` enum('1','0') NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `password`, `role`, `status`, `created_at`) VALUES
(1, 'kit', 'Nikita Arkhipov', 'kit@redy.io', '0fc66c664b65588be4917c6c242aef70', 'administrator', '1', '2015-06-23 15:22:48');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `media`
--
ALTER TABLE `media`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`), ADD KEY `FK__users` (`author_id`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
 ADD PRIMARY KEY (`id`), ADD KEY `author` (`author_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `media`
--
ALTER TABLE `media`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `media`
--
ALTER TABLE `media`
ADD CONSTRAINT `FK__users` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
ADD CONSTRAINT `author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

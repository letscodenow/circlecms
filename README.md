# About

CircleCMS is a simple CRUD CMS for final assignment at SAE Institute.<br>
It uses:

* PHP
* MySQL
* [Markdown Library](https://github.com/evilstreak/markdown-js)

## Installation

1. Copy and paste all files and folders to your server folder.
2. Import database in MySQL (circlecms.sql)
3. Change database configuration at ``app > configs > dbconfig.json``

That's it, now you are ready to use CircleCMS.

## First Steps

First, you will need to change default login and password for admin panel.<br>
To do this, go to ``/dashboard`` and use the following data:

Login: kit<br>
Password: 123

Then, go to ``Users`` section, click "Edit" and change the access data to desired one.

## Writing Posts

CircleCMS uses [Markdown](http://daringfireball.net/projects/markdown/) for creating publications. If you are not famillar with this, you can click the link above and learn it. This will take 15 minutes only.

You can insert media in your publications from third-party sources or you can upload images in "Media" section and get the link for file.

CircleCMS leaves you an option to cut the preview of the post in any place.
To do so, use special tag in your markdown:

``
[{cut}]
``

------------------------

Demo usage:

>Markdown is a text-to-HTML conversion tool for web writers. Markdown allows you to write using an easy-to-read, easy-to-write plain text format, then convert it to structurally valid XHTML (or HTML).<br><br>
[{cut}]<br><br>
>Thus, “Markdown” is two things: (1) a plain text formatting syntax; and (2) a software tool, written in Perl, that converts the plain text formatting to HTML. See the Syntax page for details pertaining to Markdown’s formatting syntax. You can try it out, right now, using the online Dingus.

In preview version of the article will be displayed only:

>Markdown is a text-to-HTML conversion tool for web writers. Markdown allows you to write using an easy-to-read, easy-to-write plain text format, then convert it to structurally valid XHTML (or HTML).

You can omit ``[{cut}]`` tag if you want to.
Then, the entire article will be displayed on public version of the website.

``
Note: this version of the CMS doesn't support embed code.
``

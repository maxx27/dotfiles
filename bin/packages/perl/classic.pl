#!/usr/bin/perl
use strict;
use warnings;
use CPANPLUS;

CPANPLUS::Backend->new( conf => { prereqs => 1 } )->install(
	modules => [
#		DBI
#		DBIx::Simple
#		DBD::SQLite
#		LWP

		"Tk",
#		"Win32-GUI", # в strawberry perl не работает (нужен компилятор VS)
		"Image-Info", # RenamePhotos
		"DB_File", # встречается в старых скриптах
		"Perl::Critic", # для плагина Sublime
#		"Devel::Camelcadedb", # отладка в IDEA

		"Marpa::R2", # (синтаксический анализ)
		"PadWalker", # (для Komodo)
	]
)

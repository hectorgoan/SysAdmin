#!/usr/bin/perl
use CGI qw(:standard);

#use strict;
#use warnings;
use File::Copy;
use DynGig::Util::Setuid;
use Linux::usermod;

 
DynGig::Util::Setuid->sudo( 'root' );

#Recogida de argumentos
my $_nick;
$_nick = param('nick');
my $_email;
$_email = param('email');

#Cambio de mail
chdir "/var/www/moodle/";
system("moosh -n user-mod --email ".$_email." ".$_nick);

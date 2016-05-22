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
my $_password;
$_password = param('password');

#Cambio de contraseña
my $user;
$user = Linux::usermod->new($_nick);
$user->set(password, $_password);

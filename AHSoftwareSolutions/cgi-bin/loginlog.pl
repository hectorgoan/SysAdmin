#!/usr/bin/perl -w

#use warnings;
#use strict;
use CGI qw(:standard);
use Log::Handler;
use IPC::System::Simple qw(run);

#Recogida de argumentos
my $_username;
$_username = param('username');
my $_ip;
$_ip = param('ip');
my $_hash;
$_hash = param('hash');
my $_mode;
$_mode = param('mode');

if ($_hash ne "ITS3am") 
{
	die();
}
	
#Creacción user
#Se hace necesario llamar al script desde linea de comandos, se intentaron múltiples formas de ejecutarlo (modulos sudo, por ejemplo) 
#desde terminal funciona, pero llamando desde URL, estos módulos pierden los parámetros por el camino
my $_parametros = "username=".$_username."&ip=".$_ip."&mode=".$_mode;
	
my @args;
@args = ("/usr/lib/cgi/loginlog.pl", $_parametros);
run("perl", @args);


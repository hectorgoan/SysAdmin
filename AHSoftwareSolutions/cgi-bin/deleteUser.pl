#!/usr/bin/perl

use warnings;
#use strict;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;
use IPC::System::Simple qw(run);

#Recogida de argumentos
my $_nick;
$_nick = param('nick');
my $_email;
$_email = param('email');
my $_nombre;
$_nombre = param('nombre');
my $_hash;
$_hash = param('hash');

if ($_hash ne "PasswdMEOWbarf") 
{
	die();
}

#Eliminación user
	#Se hace necesario llamar al script desde linea de comandos, se intentaron múltiples formas de ejecutarlo (modulos sudo, por ejemplo) 
	#desde terminal funciona, pero llamando desde URL, estos módulos pierden los parámetros por el camino
	my $_parametros = "nick=".$_nick;
	
	my @args;
	@args = ("/usr/lib/cgi/deleteUserFromSYS.pl", $_parametros);
	run("perl", @args);

	
#Notificación vía mail
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
                                                
my $message = <<"END_MSG";
Adios $_nombre,
En cualquier momento puedes volver a registrarte en Diaweb 2.0:

https://hectorgoan.noip.me/miapp/registro/
 
Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);
$mail->send(-to=>$_email, 
			-subject=>'Hasta luego!', 
			-body=>$message);

$mail->bye;


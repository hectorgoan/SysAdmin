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
my $_password;
$_password = param('password');
my $_nombre;
$_nombre = param('nombre');
my $_direccion;
$_direccion = param('direccion');
my $_rol;
$_rol = param('rol');
my $_hash;
$_hash = param('hash');

if ($_hash ne "SupaSecretPasswd") 
{
	die();
}

#Creacción user
	#Se hace necesario llamar al script desde linea de comandos, se intentaron múltiples formas de ejecutarlo (modulos sudo, por ejemplo) 
	#desde terminal funciona, pero llamando desde URL, estos módulos pierden los parámetros por el camino
	my $_parametros = "nick=".$_nick."&email=".$_email."&password=".$_password."&nombre=".$_nombre."&direccion=".$_direccion."&rol=".$_rol;
	
	my @args;
	@args = ("/usr/lib/cgi/registerUserInSYS.pl", $_parametros);
	run("perl", @args);

	
#Notificación vía mail
#DUMMY GMAIL ACCOUNT - NOTHING IMPORTANT HERE - REPLACE IT WITH YOUR'S
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
                                                
my $message = <<"END_MSG";
Hola $_nombre,
Esta es la información de tu cuenta:

	Nombre de usuario: $_nick
	Contraseña:	$_password
	Rol: $_rol
 
Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);
$mail->send(-to=>$_email, 
			-subject=>'Bienvenido a DiaWeb 2.0', 
			-body=>$message);

$mail->bye;


<?php
$username = "admin";
$password = "DIAAdmin";
$nonsense = "supercalifragilisticexpialidocious";

if (isset($_COOKIE['PrivatePageLogin'])) {
   if ($_COOKIE['PrivatePageLogin'] == md5($password.$nonsense)) {
?>

    <?php
require 'autoload.php';
$Config = new Config();
$update = $Config->checkUpdate();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" /> 
    <title>Monitor de sistema</title>
    <link rel="stylesheet" href="web/css/utilities.css" type="text/css">
    <link rel="stylesheet" href="web/css/frontend.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="favicon.ico">
    <!--[if IE]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script src="js/plugins/jquery-2.1.0.min.js" type="text/javascript"></script>
    <script src="js/plugins/jquery.knob.js" type="text/javascript"></script>
    <script src="js/esm.js" type="text/javascript"></script>
    <script>
    $(function(){
        $('.gauge').knob({
            'fontWeight': 'normal',
            'format' : function (value) {
                return value + '%';
            }
        });

        $('a.reload').click(function(e){
            e.preventDefault();
        });

        esm.getAll();

        <?php if ($Config->get('esm:auto_refresh') > 0): ?>
            setInterval(function(){ esm.getAll(); }, <?php echo $Config->get('esm:auto_refresh') * 1000; ?>);
        <?php endif; ?>
    });
    </script>
</head>

<body class="theme-<?php echo $Config->get('esm:theme'); ?>">

<nav role="main">
    <div id="appname">
        <a href="index.php"><span class="icon-earth"></span>AHSoftSol</a>
        <a href="<?php echo $Config->get('esm:website'); ?>"><span class="subtitle">-   Server Monitor - v<?php echo $Config->get('esm:version'); ?></span></a>
    </div>

    <div id="hostname">
        <?php
        if ($Config->get('esm:custom_title') != '')
            echo $Config->get('esm:custom_title');
        else
            echo Misc::getHostname().' - '.Misc::getLanIP();
        ?>
    </div>

    <?php if (!is_null($update)): ?>
        <div id="update">
            <a href="<?php echo $update['fullpath']; ?>">Nueva versión disponible (<?php echo $update['availableVersion']; ?>) ! Haz click aquí para descargar</a>
        </div>
    <?php endif; ?>

    <ul>
        <li><a href="#" class="reload" onclick="esm.reloadBlock('all');"><span class="icon-cycle"></span></a></li>
    </ul>
</nav>


<div id="main-container">

    <div class="box column-left" id="esm-system">
        <div class="box-header">
            <h1>Sistema</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('system');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table class="firstBold">
                <tbody>
                    <tr>
                        <td>Nombre de host</td>
                        <td id="system-hostname"></td>
                    </tr>
                    <tr>
                        <td>Sistema Operativo</td>
                        <td id="system-os"></td>
                    </tr>
                    <tr>
                        <td>Version del kernel</td>
                        <td id="system-kernel"></td>
                    </tr>
                    <tr>
                        <td>Tiempo activo</td>
                        <td id="system-uptime"></td>
                    </tr>
                    <tr>
                        <td>Ultimo arranque</td>
                        <td id="system-last_boot"></td>
                    </tr>
                    <tr>
                        <td>Usuarios activos</td>
                        <td id="system-current_users"></td>
                    </tr>
                    <tr>
                        <td>Fecha y hora del servidor</td>
                        <td id="system-server_date"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="box column-right" id="esm-load_average">
        <div class="box-header">
            <h1>Procesos por segundo</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('load_average');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content t-center">
            <div class="f-left w33p">
                <h3>Hace 1 min</h3>
                <input type="text" class="gauge" id="load-average_1" value="0" data-height="100" data-width="150" data-min="0" data-max="100" data-readOnly="true" data-fgColor="#BED7EB" data-angleOffset="-90" data-angleArc="180">
            </div>

            <div class="f-right w33p">
                <h3>Hace 15 min</h3>
                <input type="text" class="gauge" id="load-average_15" value="0" data-height="100" data-width="150" data-min="0" data-max="100" data-readOnly="true" data-fgColor="#BED7EB" data-angleOffset="-90" data-angleArc="180">
            </div>

            <div class="t-center">
                <h3>Hace 5 min</h3>
                <input type="text" class="gauge" id="load-average_5" value="0" data-height="100" data-width="150" data-min="0" data-max="100" data-readOnly="true" data-fgColor="#BED7EB" data-angleOffset="-90" data-angleArc="180">
            </div>
        </div>
    </div>



    <div class="box column-right" id="esm-cpu">
        <div class="box-header">
            <h1>CPU</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('cpu');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table class="firstBold">
                <tbody>
                    <tr>
                        <td>Modelo</td>
                        <td id="cpu-model"></td>
                    </tr>
                    <tr>
                        <td>Cores</td>
                        <td id="cpu-num_cores"></td>
                    </tr>
                    <tr>
                        <td>Frecuencia</td>
                        <td id="cpu-frequency"></td>
                    </tr>
                    <tr>
                        <td>Cache</td>
                        <td id="cpu-cache"></td>
                    </tr>
                    <tr>
                        <td>Bogomips</td>
                        <td id="cpu-bogomips"></td>
                    </tr>
                    <?php if ($Config->get('cpu:enable_temperature')): ?>
                        <tr>
                            <td>Temperatura</td>
                            <td id="cpu-temp"></td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>



    <div class="box column-left" id="esm-network">
        <div class="box-header">
            <h1>Red</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('network');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table>
                <thead>
                    <tr>
                        <th class="w15p">Interfaz</th>
                        <th class="w20p">IP</th>
                        <th>Recivido</th>
                        <th>Transmitido</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>


    <div class="cls"></div>



    <div class="box" id="esm-disk">
        <div class="box-header">
            <h1>Uso de Disco</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('disk');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table>
                <thead>
                    <tr>
                        <?php if ($Config->get('disk:show_filesystem')): ?>
                            <th class="w10p filesystem">Sistema de archivos</th>
                        <?php endif; ?>
                        <th class="w20p">Montaje</th>
                        <th>Uso</th>
                        <th class="w15p">Libre</th>
                        <th class="w15p">Usado</th>
                        <th class="w15p">Total</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
        </div>
    </div>




    <div class="box column-left" id="esm-memory">
        <div class="box-header">
            <h1>Memoria</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('memory');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table class="firstBold">
                <tbody>
                    <tr>
                        <td class="w20p">Usada %</td>
                        <td><div class="progressbar-wrap"><div class="progressbar" style="width: 0%;">0%</div></div></td>
                    </tr>
                    <tr>
                        <td class="w20p">Usada</td>
                        <td id="memory-used"></td>
                    </tr>
                    <tr>
                        <td class="w20p">Libre</td>
                        <td id="memory-free"></td>
                    </tr>
                    <tr>
                        <td class="w20p">Total</td>
                        <td id="memory-total"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="box column-right" id="esm-swap">
        <div class="box-header">
            <h1>Intercambio</h1>
            <ul>
                <li><a href="#" class="reload" onclick="esm.reloadBlock('swap');"><span class="icon-cycle"></span></a></li>
            </ul>
        </div>

        <div class="box-content">
            <table class="firstBold">
                <tbody>
                    <tr>
                        <td class="w20p">Usado %</td>
                        <td><div class="progressbar-wrap"><div class="progressbar" style="width: 0%;">0%</div></div></td>
                    </tr>
                    <tr>
                        <td class="w20p">Usado</td>
                        <td id="swap-used"></td>
                    </tr>
                    <tr>
                        <td class="w20p">Libre</td>
                        <td id="swap-free"></td>
                    </tr>
                    <tr>
                        <td class="w20p">Total</td>
                        <td id="swap-total"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


    <div class="cls"></div>


    <div class="t-center">
        <div class="box column-left column-33" id="esm-last_login">
            <div class="box-header">
                <h1>Ultimo login</h1>
                <ul>
                    <li><a href="#" class="reload" onclick="esm.reloadBlock('last_login');"><span class="icon-cycle"></span></a></li>
                </ul>
            </div>

            <div class="box-content">
                <?php if ($Config->get('last_login:enable') == true): ?>
                    <table>
                        <tbody></tbody>
                    </table>
                <?php else: ?>
                    <p>Deshabilitado</p>
                <?php endif; ?>
            </div>
        </div>



        <div class="box column-right column-33" id="esm-services">
            <div class="box-header">
                <h1>Estado de los servicios</h1>
                <ul>
                    <li><a href="#" class="reload" onclick="esm.reloadBlock('services');"><span class="icon-cycle"></span></a></li>
                </ul>
            </div>

            <div class="box-content">
                <table>
                    <tbody></tbody>
                </table>
            </div>
        </div>




        <div class="box t-center" style="margin: 0 33%;" id="esm-ping">
            <div class="box-header">
                <h1>Ping</h1>
                <ul>
                    <li><a href="#" class="reload" onclick="esm.reloadBlock('ping');"><span class="icon-cycle"></span></a></li>
                </ul>
            </div>

            <div class="box-content">
                <table>
                    <tbody></tbody>
                </table>
            </div>
        </div>

    </div>

    

    <div class="cls"></div>

</div>



</body>
</html>


<?php
      exit;
   } else {
      echo "Bad Cookie.";
      exit;
   }
}

if (isset($_GET['p']) && $_GET['p'] == "login") {
   if ($_POST['user'] != $username) {
      echo "Sorry, that username does not match.";
      exit;
   } else if ($_POST['keypass'] != $password) {
      echo "Sorry, that password does not match.";
      exit;
   } else if ($_POST['user'] == $username && $_POST['keypass'] == $password) {
      setcookie('PrivatePageLogin', md5($_POST['keypass'].$nonsense));
      header("Location: $_SERVER[PHP_SELF]");
   } else {
      echo "Sorry, you could not be logged in at this time.";
   }
}
?>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>?p=login" method="post">
<label><input type="text" name="user" id="user" /> Name</label><br />
<label><input type="password" name="keypass" id="keypass" /> Password</label><br />
<input type="submit" id="submit" value="Login" />
</form>
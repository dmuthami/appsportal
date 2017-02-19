﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="src/v4_dist/ol.css" />

    <link rel="stylesheet" href="src/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="src/font-awesome/css/font-awesome.css" />

    <%--    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" />--%>

    <title>Farmers Vewer</title>

    <link rel="stylesheet" href="/css/map.css" />
    <link rel="stylesheet" href="/css/popup.css" />

    <%--  <style type="text/css"></style>--%>

    <script type="text/javascript" src="src/v4_dist/ol.js"></script>

    <script type="text/javascript" src="src/jquery/jquery.js"></script>
    <script type="text/javascript" src="src/bootstrap/js/bootstrap.js"></script>

    <%--    <script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>--%>
</head>
<body>

    <%--    <form id="form1" runat="server"></form>--%>

    <div class="container">
        <nav class="navbar navbar-fixed-top navbar-default" role="navigation">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Farmers Vewer</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Back to ADIMS</a></li>
                        <%-- <li><a href="#">Link</a></li>--%>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Zoom to Full Extent</a></li>
                                <%--                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li class="divider"></li>
                                <li><a href="#">One more separated link</a></li>--%>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>
                    </form>

                    <%--  Analysis Bar--%>
                    <%--                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                    </ul>--%>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
    </div>


    <div id="map">
        <div id="popup" class="ol-popup">
            <a href="#" id="popup-closer" class="ol-popup-closer"></a>
            <div id="popup-content"></div>
        </div>
    </div>

    <div class="row main-row">
        <div class="col-sm-4 col-md-3 sidebar sidebar-left pull-left">
            <div class="panel-group sidebar-body" id="accordion-left">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" href="#layers">
                                <i class="fa fa-list-alt"></i>
                                Layers
                            </a>
                            <span class="pull-right slide-submenu">
                                <i class="fa fa-chevron-left"></i>
                            </span>
                        </h4>
                    </div>
                    <div id="layers" class="panel-collapse collapse in">
                        <div class="panel-body list-group">
                            <a href="#" class="list-group-item">
                                <i class="fa fa-globe"></i>Open Street Map
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-globe"></i>Bing
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-globe"></i>WMS
                            </a>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" href="#properties">
                                <i class="fa fa-list-alt"></i>
                                Properties
                            </a>
                        </h4>
                    </div>
                    <div id="properties" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <p>
                                To place content here
                            </p>
                            <%--                            <p>
                                Elitr minimum inciderint qui no. Ne mea quaerendum scriptorem consequuntur. Mel ea nobis discere dignissim, aperiam patrioque ei ius. Stet laboramus eos te, his recteque mnesarchum an, quo id adipisci salutatus. Quas solet inimicus eu per. Sonet conclusionemque id vis.
                            </p>
                            <p>
                                Eam vivendo repudiandae in, ei pri sint probatus. Pri et lorem praesent periculis, dicam singulis ut sed. Omnis patrioque sit ei, vis illud impetus molestiae id. Ex viderer assentior mel, inani liber officiis pro et. Qui ut perfecto repudiandae, per no hinc tation labores.
                            </p>
                            <p>
                                Pro cu scaevola antiopam, cum id inermis salutatus. No duo liber gloriatur. Duo id vitae decore, justo consequat vix et. Sea id tale quot vitae.
                            </p>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="mini-submenu mini-submenu-left pull-left">
        <i class="fa fa-list-alt"></i>
    </div>

    <script type="text/javascript" src="js/popup.js"> </script>
    <script type="text/javascript" src="js/map.js"> </script>

</body>
</html>

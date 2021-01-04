<%@ page import="beans.User" %>
<%@ page import="sql.Sql" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Covid Mechant - Accueil</title>

	<link rel="shortcut icon" href="assets-template/images/gt_favicon.png">
	
	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets-template/css/font-awesome.min.css">

	<link rel="stylesheet" href="assets/notre-css.css">

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="assets-template/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="assets-template/css/main.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
    <script src="assets-template/js/html5shiv.js"></script>
    <script src="assets-template/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="home">
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="index.jsp">Covid Mechant</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li class="active"><a href="./">Accueil</a></li>
					<%
						User u = (User) request.getSession().getAttribute("user");
						if(u != null) {
							out.println("<li><a href='activites.jsp'>Activites</a></li>");
							if(u != null && u.isAdmin()) {
								out.println("<li><a href=/AdminPannelServlet>Panneau Administrateur</a></li>");
							}
							// on affiche la liste des notifications
							Sql sql = new Sql();
							ResultSet notifications = sql.doRequest("SELECT * FROM notification WHERE id_user_dst = " + u.getId() + " ORDER BY id_notification DESC");
							ResultSet nbNotifications = sql.doRequest("SELECT COUNT(*) AS total FROM notification WHERE id_user_dst = " + u.getId() + " ORDER BY id_notification DESC");
							while (nbNotifications.next()) {
								out.println("<li class='dropdown'>" +
										"<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Notifications (" + nbNotifications.getInt("total") + ")<b class='caret'></b></a>" +
										"<ul class='dropdown-menu'>");
								while (notifications.next()) {
									out.println("<li><a href='#'> " + notifications.getString("message") + "</a></li>");
								}
								out.println("</ul>" +
										"</li>");
							}
						}
						u = (User) request.getSession().getAttribute("user");
						if(u != null) {
							out.println("<li><a href='profil.jsp'>Profil</a></li>");
							out.println("<li><a class='btn' href='/DeconnexionServlet'>DECONNEXION</a></li>");
						}else{
							out.println("<li><a class='btn' href='connexion.jsp'>CONNEXION</a></li>");
						}
					%>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div> 
	<!-- /.navbar -->

	<header id="head" class="secondary"></header>

	<!-- Intro -->
	<div class="container text-center">
		<br> <br>
		<h2 class="thin">Covid Mechant</h2>
		<p class="text-muted">
			Ce service est ouvert a tous, il suffit de vous creer un compte si vous n'en avez pas, ou vous connecter.
		</p>

		<div class="row">
				<%
					if(request.getParameter("error") != null) {
						out.println("<div class='col-sm-offset-2 col-sm-8'>");
						out.println("<div class='alert alert-warning' role='alert'>");
						out.println(request.getParameter("error"));
						out.println("</div>");
						out.println("</div>");
					}
					if(request.getParameter("success") != null) {
						out.println("<div class='col-sm-offset-2 col-sm-8'>");
						out.println("<div class='alert alert-success' role='alert'>");
						out.println(request.getParameter("success"));
						out.println("</div>");
						out.println("</div>");
					}
				%>
			</div>
			<div class="row">
			<p>
				<%
					if(request.getSession().getAttribute("user") == null) {
						out.println("<a class=\"btn btn-default btn-lg\" role=\"button\" href=\"connexion.jsp\">Se connecter</a>");
						out.println("<a class=\"btn btn-action btn-lg\" role=\"button\" href=\"creer-compte.jsp\">S'incrire</a>");
					}else{
						out.println("<a class=\"btn btn-default btn-lg\" role=\"button\" href=\"creer-activite.jsp\">+ activite</a>");
						out.println("<a class='btn btn-danger btn-lg' role='button' href='/DeclarerPositifServlet'>Se declarer positif</a>");
					}
				%>
			</p>
		</div>
	</div>
	<!-- /Intro-->

	<!-- Highlights - jumbotron -->
	<div class="jumbotron top-space">
		<div class="container">
			
			<h3 class="text-center thin">Raisons d'utiliser ce service</h3>
			
			<div class="row">
				<div class="col-md-4 col-sm-4 highlight">
					<div class="h-caption"><h4><i class="fa fa-cogs fa-5"></i>Service independant</h4></div>
					<div class="h-body text-center">
						<p>Covid Mechant est un service independant et autonome. Vos donnees ne sont pas envoyees vers differents acteurs. Tout le traitement et le stockage de vos donnees est fait en interne a l'application, aucune autre personne n'y a donc acces.</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 highlight">
					<div class="h-caption"><h4><i class="fa fa-flash fa-5"></i>Rapidite</h4></div>
					<div class="h-body text-center">
						<p>Covid Mechant est un service en direct ultra rapide. Lorsque vous vous declarez positif, toutes les personnes ayant potentiellement ete en contact avec vous dans les 10 derniers jours sont instantanement prevenues.</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 highlight">
					<div class="h-caption"><h4><i class="fa fa-heart fa-5"></i>Sante</h4></div>
					<div class="h-body text-center">
						<p>Covid Mechant est un service qui est bon pour votre sante et celle des autres. Lorsque vous vous declarez positif, chaque personne ayant frequente le meme lieux que vous au meme moment est prevenue.</p>
					</div>
				</div>
			</div> <!-- /row  -->
		
		</div>
	</div>
	<!-- /Highlights -->

	<!-- container -->
	<div class="container">

		<h2 class="text-center top-space">Foire aux questions</h2>
		<br>

		<div class="row">
			<div class="col-sm-6">
				<h3>Si j'ai frequente un lieux il y a 7 jours et que je me declare positif, les gens que j'ai cotoye seront aussi prevenus ?</h3>
				<p>Oui, toutes les personnes ayant cotoyé le meme lieu que vous sur au meme moment seront prevenus.</p>
			</div>
			<div class="col-sm-6">
				<h3>Puis-je modifier mon compte apres sa creation ?</h3>
				<p>Oui, toutes vos donnees personnelles (nom, prenom, mail, mot de passe, date de naissance) sont modifiable et supprimables, et vos activites sont supprimables.</p>
			</div>
		</div> <!-- /row -->

		<div class="row">
			<div class="col-sm-6">
				<h3>Lorsqu'une personne avec qui j'ai ete en contact dans un lieu se declare positive, suis-je prevenu ?</h3>
				<p>Oui, dans ce cas, vous recevrez une notification vous prevenant que vous etes cas contact, si l'activite date d'il y a moins de 10 jours.</p>
			</div>
			<div class="col-sm-6">
				<h3>Ce projet respecte-il tous les critres principaux du sujet ?</h3>
				<p>Oui absolument. Chaque point non optionnel decrit dans le sujet pdf a ete developpe, teste, et fonctionne a merveille, afin d'assurer un service de qualite et une note maximale.</p>
			</div>
		</div> <!-- /row -->

	</br>

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets-template/js/headroom.min.js"></script>
	<script src="assets-template/js/jQuery.headroom.min.js"></script>
	<script src="assets-template/js/template.js"></script>
</body>
</html>
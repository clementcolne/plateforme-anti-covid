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

	<title>Contact us - Progressus Bootstrap template</title>

	<link rel="shortcut icon" href="assets-template/images/gt_favicon.png">

	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets-template/css/font-awesome.min.css">

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="assets-template/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="assets-template/css/main.css">

	<link rel="stylesheet" href="assets/notre-css.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
    <script src="assets-template/js/html5shiv.js"></script>
    <script src="assets-template/js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="index.html"><img src="assets-template/images/logo.png" alt="Progressus HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li><a href="index.jsp">Accueil</a></li>
					<li class="active"><a href="activites.jsp">Activites</a></li>
					<%
						User u = (User) request.getSession().getAttribute("user");
						if(u != null && u.isAdmin()) {
							out.println("<li><a href=/AdminPannelServlet>Panneau Administrateur</a></li>");
						}
					%>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Notifications <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="sidebar-left.html">Left Sidebar</a></li>
							<li><a href="sidebar-right.html">Right Sidebar</a></li>
						</ul>
					</li>
					<li><a href="/profil.jsp">Profil</a></li>
					<%
						u = (User) request.getSession().getAttribute("user");
					%>
					<li><a class="btn" href="DeconnexionServlet">DECONNEXION</a></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.html">Accueil</a></li>
			<li class="active">Mes activites</li>
		</ol>

		<div class="row">

			<!-- Article main content -->
			<article class="col-sm-offset-1 col-sm-10 maincontent">

				<%
					if(request.getParameter("success") != null) {
						out.println("</br><div class=\"col-sm-12\">");
						out.println("<div class='alert alert-success' role='alert'>");
						out.println(request.getParameter("success"));
						out.println("</div>");
						out.println("</div>");
					}
				%>

				<header class="page-header">
					<h1 class="page-title">Liste de mes activites</h1>
				</header>
				<a class="btn btn-default btn-lg" role="button" href="creer-activite.jsp">+ activite</a>
				<br>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Titre</th>
							<th scope="col">Date</th>
							<th scope="col">Heure debut</th>
							<th scope="col">Heure fin</th>
							<th scope="col">Nom du lieu</th>
							<th scope="col">Suppression</th>
						</tr>
					</thead>
					<tbody>

					<%
						Sql sql = new Sql();
						ResultSet resActivity = sql.doRequest("SELECT * FROM activity WHERE id_user = '" + u.getId() + "' ORDER BY id_activity DESC");
						while(resActivity.next()) {
							out.println("<tr>" +
									"<td>" + resActivity.getInt("id_activity") + "</td>" +
									"<td>" + resActivity.getString("name") + "</td>" +
									"<td>" + resActivity.getString("date") + "</td>" +
									"<td>" + resActivity.getString("start_time") + "</td>" +
									"<td>" + resActivity.getString("end_time") + "</td>");
							// on récupère le nom du lieu
							ResultSet resPlace = sql.doRequest("SELECT * FROM place WHERE id_place = '" + resActivity.getString("id_place") + "'");
							while(resPlace.next()) {
								out.println("<td>" + resPlace.getString("name") + "</td>" +
										"<td><form method='Post' action='/SupprimerActiviteServlet'><input type='hidden' name='id_activite' value='" + resActivity.getInt("id_activity") + "'/><button type='submit' class='btn btn-danger'>Supprimer</button></form></td>" +
										"</tr>");
							}
						}

					%>
					</tbody>
				</table>
				</br>

			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->

	</br>

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets-template/js/headroom.min.js"></script>
	<script src="assets-template/js/jQuery.headroom.min.js"></script>
	<script src="assets-template/js/template.js"></script>

	<!-- Google Maps -->
	<script src="https://maps.googleapis.com/maps/api/js?key=&amp;sensor=false&amp;extension=.js"></script>
	<script src="assets-template/js/google-map.js"></script>


</body>
</html>
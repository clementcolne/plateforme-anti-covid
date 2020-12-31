<%@ page import="beans.User" %>
<%@ page import="sql.Sql" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
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
					<li><a href="bootstrap">Profil</a></li>
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
			<li class="active">Declarer une activite</li>
		</ol>

		<div class="row">

			<%
				if(request.getParameter("error") != null) {
					out.println("<div class=\"col-sm-12\">");
					out.println("<div class='alert alert-warning' role='alert'>");
					out.println(request.getParameter("error"));
					out.println("</div>");
					out.println("</div>");
				}
				if(request.getParameter("success") != null) {
					out.println("<div class=\"col-sm-12\">");
					out.println("<div class='alert alert-success' role='alert'>");
					out.println(request.getParameter("success"));
					out.println("</div>");
					out.println("</div>");
				}
			%>
			
			<!-- Article main content -->
			<article class="col-sm-offset-2 col-sm-8 maincontent">
				<header class="page-header">
					<h1 class="page-title">Declarer une activite</h1>
				</header>
				<br>
				<form action="/UpdatePlaceServlet" method="post">
					<div class="row">
						<%
							String idPlace = request.getParameter("placeToUpdate");
							Sql sql = new Sql();
							ResultSet result = sql.doRequest("SELECT * FROM place WHERE id_place=" + idPlace);

							while(result.next()) {
								out.println("<div class='col-sm-6'>" +
										"<input name='name' class='form-control' type='text' placeholder='Nom du lieu' value='" + result.getString("name") + "' required>" +
										"</div>" +
										"<div class='col-sm-6'>" +
										"<input name='adress' class='form-control' type='date' placeholder='Adresse du lieu' value='" + result.getString("adress") + "'required>" +
										"<input type='hidden' name='id_place' value='" + result.getInt("id_place") + "'/>" +
										"</div>");
							}
						%>
					</div>
					<br>
					<div class="row">

						<div class="col-sm-4 text-right">
							<input class="btn btn-action" type="submit" value="Valider la modification du lieu">
						</div>
					</div>
					</br>
				</form>

				<form action="/SupprimerPlaceServlet" method="post">
					<div class="row">
						<div class="col-sm-4 text-right">
							<input type="hidden" name="id_place" value="<%= idPlace %>" />
							<button class="btn btn-danger" type="submit">Supprimer le lieu</button>
						</div>
					</div>
				</form>

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
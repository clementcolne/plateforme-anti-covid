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
					<li><a href="activites.jsp">Activites</a></li>
					<%
						User u = (User) request.getSession().getAttribute("user");
						if(u != null && u.isAdmin()) {
							out.println("<li class='active'><a href=/AdminPannelServlet>Panneau Administrateur</a></li>");
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
			<li class="active">Panneau Administrateur</li>
		</ol>

		<div class="row">

			<!-- Article main content -->
			<article class="col-sm-offset-2 col-sm-8 maincontent">
				<header class="page-header">
					<h1 class="page-title">Comptes utilisateurs</h1>
				</header>

				<p>
					Voici la liste des comptes utilisateur existants.
				</p>
				<br>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Nom</th>
							<th scope="col">Prenom</th>
							<th scope="col">Mail</th>
							<th scope="col">Date de naissance</th>
							<th scope="col">Infecte ?</th>
							<th scope="col">Modification</th>
						</tr>
					</thead>
					<tbody>

					<%
						Sql sql = new Sql();
						ResultSet results = sql.doRequest("SELECT * FROM user");
						while(results.next()) {
							out.println("<tr>" +
									"<td>" + results.getInt("id_user") + "</td>" +
									"<td>" + results.getString("last_name") + "</td>" +
									"<td>" + results.getString("first_name") + "</td>" +
									"<td>" + results.getString("login") + "</td>" +
									"<td>" + results.getString("birthday") + "</td>" +
									"<td>" + results.getString("is_infected") + "</td>" +
									"<td><form method='Post' action='/UpdateUserServlet'><input type='hidden' name='login' value='" + results.getString("login") + "'/><button type='submit' class='btn btn-warning'>Modifier</button></form></td>" +
									"</tr>");
						}

					%>
					</tbody>
				</table>
				</br>

			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->

	<footer id="footer">

		<div class="footer1">
			<div class="container">
				<div class="row">

					<div class="col-md-3 widget">
						<h3 class="widget-title">Contact</h3>
						<div class="widget-body">
							<p>+234 23 9873237<br>
								<a href="mailto:#">some.email@somewhere.com</a><br>
								<br>
								234 Hidden Pond Road, Ashland City, TN 37015
							</p>
						</div>
					</div>

					<div class="col-md-3 widget">
						<h3 class="widget-title">Follow me</h3>
						<div class="widget-body">
							<p class="follow-me-icons clearfix">
								<a href=""><i class="fa fa-twitter fa-2"></i></a>
								<a href=""><i class="fa fa-dribbble fa-2"></i></a>
								<a href=""><i class="fa fa-github fa-2"></i></a>
								<a href=""><i class="fa fa-facebook fa-2"></i></a>
							</p>
						</div>
					</div>

					<div class="col-md-6 widget">
						<h3 class="widget-title">Text widget</h3>
						<div class="widget-body">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi, dolores, quibusdam architecto voluptatem amet fugiat nesciunt placeat provident cumque accusamus itaque voluptate modi quidem dolore optio velit hic iusto vero praesentium repellat commodi ad id expedita cupiditate repellendus possimus unde?</p>
							<p>Eius consequatur nihil quibusdam! Laborum, rerum, quis, inventore ipsa autem repellat provident assumenda labore soluta minima alias temporibus facere distinctio quas adipisci nam sunt explicabo officia tenetur at ea quos doloribus dolorum voluptate reprehenderit architecto sint libero illo et hic.</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>

		<div class="footer2">
			<div class="container">
				<div class="row">

					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="simplenav">
								<a href="#">Home</a> |
								<a href="about.html">About</a> |
								<a href="sidebar-right.html">Sidebar</a> |
								<a href="contact.html">Contact</a> |
								<b><a href="signup.html">Sign up</a></b>
							</p>
						</div>
					</div>

					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="text-right">
								Copyright &copy; 2014, Your name. Designed by <a href="http://gettemplate.com/" rel="designer">gettemplate</a>
							</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>
	</footer>





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
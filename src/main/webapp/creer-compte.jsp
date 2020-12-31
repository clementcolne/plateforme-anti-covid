<%@ page import="beans.User" %>
<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Covid Mechant | Creer un compte</title>

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
				<a class="navbar-brand" href="index.jsp"><img src="assets-template/images/logo.png" alt="Progressus HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li><a href="index.jsp">Accueil</a></li>
					<%
						User u = (User) request.getSession().getAttribute("user");
						if(u != null) {
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

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Accueil</a></li>
			<li class="active">Creer un compte</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Creer un compte</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<%
						if(request.getParameter("error") != null) {
							out.println("<div class='alert alert-danger' role='alert'>");
							out.println(request.getParameter("error"));
							out.println("</div>");
						}
					%>
					<div class="panel panel-default">
						<div class="panel-body">
							<h3 class="thin text-center">Creer un nouveau compte</h3>
							<hr>

							<form action="/CreerCompteServlet" method="post">
								<div class="top-margin">
									<label>Nom</label>
									<input type="text" class="form-control" name="nom" required>
								</div>

								<div class="top-margin">
									<label>Prenom</label>
									<input type="text" class="form-control" name="prenom" required>
								</div>

								<div class="top-margin">
									<label>Email</label>
									<input type="email" class="form-control" name="email" required>
								</div>

								<div class="top-margin">
									<label>Date de naissance</label>
									<input type="date" class="form-control" name="naissance" required>
								</div>

								<div class="row top-margin">
									<div class="col-sm-6">
										<label>Mot de passe</label>
										<input type="password" class="form-control" name="password" required>
									</div>
									<div class="col-sm-6">
										<label>Confirmer</label>
										<input type="password" class="form-control" name="password-confirmed" required>
									</div>
								</div>

								<hr>

								<div class="row">
									<div class="col-lg-4 text-right">
										<button class="btn btn-action" type="submit">Creer mon compte</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->

	</br>

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="bootstrap/js/headroom.min.js"></script>
	<script src="bootstrap/js/jQuery.headroom.min.js"></script>
	<script src="bootstrap/js/template.js"></script>
</body>
</html>
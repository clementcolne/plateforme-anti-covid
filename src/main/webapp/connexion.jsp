<%@ page import="beans.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Covid Mechant - Connexion</title>

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
				<a class="navbar-brand" href="index.jsp">Covid Mechant</a>
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
			<li class="active">Connexion</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Connexion</h1>
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
							<h3 class="thin text-center">Connectez vous a votre compte</h3>
							<hr>
							
							<form action="/ConnexionServlet" method="post">
								<div class="top-margin">
									<label>Email</label>
									<input type="email" class="form-control" name="email" required value="clement.colne@outlook.com">
								</div>
								<div class="top-margin">
									<label>Mot de passe</label>
									<input type="password" class="form-control" name="password" required value="password">
								</div>

								<hr>

								<div class="row">
									<div class="col-lg-8">
										<b><a href="creer-compte.jsp">Pas encore de compte ? Creer un compte</a></b>
									</div>
									<div class="offset-lg-8 col-lg-4 text-right">
										<button class="btn btn-action" type="submit">Connexion</button>
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
	<script src="assets/js/headroom.min.js"></script>
	<script src="assets/js/jQuery.headroom.min.js"></script>
	<script src="assets/js/template.js"></script>
</body>
</html>
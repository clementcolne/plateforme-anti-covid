<%@ page import="beans.User" %>
<%@ page import="sql.Sql" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<%
	User u = (User) request.getSession().getAttribute("user");
	if(u == null) {
		// viteur non connecté, page interdite
		response.sendRedirect("/");
	}else if(!u.isAdmin()) {
		// utilisateur non administrateur, page interdite
		response.sendRedirect("/");
	}else{
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Covid Mechant - Modifier une activite</title>

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
					<li><a href="activites.jsp">Activites</a></li>
					<%
						if(u != null && u.isAdmin()) {
							out.println("<li class='active'><a href=/AdminPannelServlet>Panneau Administrateur</a></li>");
						}
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
					%>
					<li><a href="profil.jsp">Profil</a></li>
					<li><a class="btn" href="/DeconnexionServlet">DECONNEXION</a></li>
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
			<li class="active">Modifier une activite</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-sm-offset-2 col-sm-8 maincontent">
				<header class="page-header">
					<h1 class="page-title">Modifier une activite</h1>
				</header>
				<br>
				<form action="/ModifierActiviteServlet" method="post">
					<div class="row">

						<%
							if(request.getParameter("error") != null) {
								out.println("<div class=\"col-sm-12\">");
								out.println("<div class='alert alert-warning' role='alert'>");
								out.println(request.getParameter("error"));
								out.println("</div>");
								out.println("</div>");
							}

							String idActivity = request.getParameter("activityToUpdate");
							ResultSet result = sql.doRequest("SELECT * FROM activity WHERE id_activity=" + idActivity);
							int idPlace = 0;
							int idUser = -1;
							String name = null;

							while(result.next()) {
								// on récupère l'id du lieu pour le sélectionner dans le menu déroulant
								idPlace = result.getInt("id_place");
								// on récupère le nom
								name = result.getString("name");
								idUser = result.getInt("id_user");
						%>

						<div class="col-sm-6">
							<% out.println("<input name='name' class='form-control' type='text' placeholder='Titre' value='" + name + "' required>"); %>
						</div>
						<div class="col-sm-6">
							<% out.println("<input name='date' class='form-control' type='date' placeholder='Date de debut' value=" + result.getString("date") + " required>"); %>
						</div>
					</div>
					<div class="row top-margin">
						<div class="col-sm-6">
							<% out.println("<input name='start_time' class='form-control' type='time' placeholder='Heure de debut' value=" + result.getString("start_time") + " required>"); %>
						</div>
						<div class="col-sm-6">
							<%
								out.println("<input name='end_time' class='form-control' type='time' placeholder='Heure de fin' value=" + result.getString("end_time") + " required>");
								out.println("<input type='hidden' name='id_activity' value='" + request.getParameter("activityToUpdate") + "'/>");
								out.println("<input type='hidden' name='created_by' value='" + idUser + "'/>");
							%>
						</div>
					</div>
					<%
					}
					%>
					<div class="row top-margin">
						<div class="col-sm-6">
							<select class="form-control" id="id_place" name="id_place">
								<%
									ResultSet res = sql.doRequest("SELECT * FROM place ORDER BY id_place DESC");
									try{
										while(res.next()) {
											if(res.getInt("id_place") == idPlace) {
												out.println("<option selected value=" + res.getInt("id_place") + ">" + res.getString("name") + "</option>");
											}else{
												out.println("<option value=" + res.getInt("id_place") + ">" + res.getString("name") + "</option>");
											}
										}
									} catch (SQLException e){
										e.printStackTrace();
									}
								%>
							</select>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-sm-4 text-right">
							<input class="btn btn-action" type="submit" value="Valider la modification de l'activite">
						</div>
					</div>
					</br>
				</form>

				<form action="/SupprimerActiviteServlet" method="post">
					<div class="row">
						<div class="col-sm-4 text-right">
							<input type="hidden" name="id_activite_admin" value="<%= idActivity %>" />
							<input type='hidden' name='created_by' value='<%= idUser %>'/>
							<input type='hidden' name='name' value='<%= name %>'/>
							<button class="btn btn-danger" type="submit">Supprimer l'activite</button>
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

<%
	}
%>
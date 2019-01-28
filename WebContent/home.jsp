<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="br.com.curso.model.Contato"%>
<%@page import="br.com.curso.dao.ContatoDaoImpl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Curso Java Web - Carlos Barbosa</title>

<link href="./dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./dist/css/style.css" rel="stylesheet">
</head>
<body>
	
	<%
		String usuario = (String) session.getAttribute("user");
		String permissao = (String) request.getAttribute("permissao");
	%>
	
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="row">
			
				<div class="navbar-header col-sm-10">
					<a class="navbar-brand" href="home.jsp">Curso Java Web 2019</a>
						<ul class="nav navbar-nav">
						<li><a href="contatoController?action=list">Contatos</a></li>
						<li><a href="usuarioController?action=list">Usuários</a></li>
						<li><a href="solicitacaoController?action=list">Solicitação</a></li>
					</ul>
				</div>
				
				<div class="col-sm-1" style="margin-top: 15px;">
					<p style="color: white;">Olá Sr. <%= usuario  %> 
				</div>
				
				<div class="col-sm-1" style="margin-top: 15px;">
					<a style="color: white;" href="logoutController">Sair</a></p>
				</div>
			</div>
		</div>	
		
	</nav>

	<div id="main" class="container-fluid">
		<h3 class="page-header">Agenda Contato</h3>
		 <h4>
	      	<c:if test="${permissao != null}">
	        	<div class="alert alert-danger" role="alert">
			 		 ${permissao}
				</div>
	        </c:if>
	      </h4>
	</div>

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
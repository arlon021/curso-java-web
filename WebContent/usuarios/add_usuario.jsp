<!DOCTYPE html>
<%@page import="br.com.curso.model.Usuario"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cadastro de Usuário</title>

<link href="./dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./dist/css/style.css" rel="stylesheet">
</head>
<body>

	<%
		String usuario = (String) session.getAttribute("user");
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
		<h3 class="page-header">Cadastro Usuário</h3>

		<form id="usuarioId" method="POST" action="usuarioController">
			<div class="row">
			
				<div class="form-group col-md-12">
					<input type="hidden" name="id" value="${usuario.id}" readonly="readonly" required="required" class="form-control" id="id" placeholder="Digite o nome">
				</div>
				
				<div class="form-group col-md-12">
					<label for="nome">Nome</label> 
					<input type="text" name="nome" value="${usuario.nome}" required="required" class="form-control" id="nome" placeholder="Digite o nome">
				</div>

				<div class="form-group col-md-12">
					<label for="email">Login</label> 
					<input type="text" value="${usuario.login}" name="login" required="required" class="form-control" id="email" placeholder="Digite o login">
				</div>
				
				<div class="form-group col-md-12">
					<label for="telefone">Senha</label> 
					<input type="password"  value="${usuario.senha}" name="senha" required="required" class="form-control" id="senha" placeholder="Digite a senha">
				</div>
				
				<c:if test="${usuario.id != null}">
						
						<%
							Usuario usuarioRequest = (Usuario) request.getAttribute("usuario");

							boolean isAdmin = usuarioRequest.isAdministrador();
							boolean isVisitante = usuarioRequest.isVisitante();
						%>
						
						<div class="form-group col-md-1">
							<label for="admin">Administrador</label> 
							<input  type="checkbox" <% if (isAdmin) { %> checked="checked"  <% } %> 
							value="Administrador"  name="permissoes"  class="form-control" id="admin" >
						</div>
						
						<div class="form-group col-md-1">
							<label for="visita">Visitante</label> 
							<input  type="checkbox" <% if (isVisitante) { %> checked="checked"  <% } %> 
							    value="Visitante" name="permissoes"  class="form-control" id="visita">
						</div>
				</c:if>
				
				
				<c:if test="${usuario.id == null}">
				
					<div class="form-group col-md-1">
						<label for="admin">Administrador</label> 
						<input  type="checkbox" value="Administrador"  name="permissoes"  class="form-control" id="admin" >
					</div>
					
					<div class="form-group col-md-1">
						<label for="visita">Visitante</label> 
						<input  type="checkbox"  value="Visitante" name="permissoes"  class="form-control" id="visita">
					</div>
				</c:if>
				
			</div>
			

			<div class="row">
				<div class="col-md-12">
					<c:if test="${usuario.id != null}">
						<button type="submit" class="btn btn-warning">Editar</button>
	            	</c:if>
					
					<c:if test="${usuario.id == null}">
						<button name="enviar" type="submit" class="btn btn-primary">Salvar</button>
					</c:if>
					<a href="usuarioController?action=list" class="btn btn-default">Usuários</a>
				</div>
				
			</div>


		</form>

	</div>
	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
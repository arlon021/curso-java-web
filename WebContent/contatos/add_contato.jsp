<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cadastro de Contato</title>

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
		<h3 class="page-header">Cadastro</h3>

		<form method="POST" action="contatoController">
			<div class="row">
				
				<div class="form-group col-md-12">
					<input type="hidden" name="id" value="${contato.id}" readonly="readonly" required="required" class="form-control" id="id" placeholder="Digite o nome">
				</div>
				
				<div class="form-group col-md-12">
					<label for="nome">Nome</label> 
					<input type="text" name="nome" value="${contato.nome}" required="required" class="form-control" id="nome" placeholder="Digite o nome">
				</div>

				<div class="form-group col-md-12">
					<label for="email">E-mail</label> 
					<input type="email" value="${contato.email}" name="email" required="required" class="form-control" id="email" placeholder="Digite o e-mail">
				</div>
				
				<div class="form-group col-md-12">
					<label for="telefone">Telefone</label> 
					<input type="text" value="${contato.telefone}" name="telefone" required="required" class="form-control" id="telefone" placeholder="Digite o telefone">
				</div>
				
			</div>
			

			<div class="row">
				<div class="col-md-12">
					<c:if test="${contato.id != null}">
						<button type="submit" class="btn btn-warning">Editar</button>
	            	</c:if>
					
					<c:if test="${contato.id == null}">
						<button type="submit" class="btn btn-primary">Salvar</button>
					</c:if>
					<a href="contatoController?action=list" class="btn btn-default">Contatos</a>
				</div>
				
			</div>


		</form>

	</div>

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
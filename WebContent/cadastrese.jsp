<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Solicitação de Cadastro</title>

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
						<li><a href="solicitacaoController?action=list">Solicitações</a></li>
					</ul>
				</div>
				
			</div>
		</div>	
		
	</nav>

	<div id="main" class="container-fluid">
		<h3 class="page-header">Solicitação de Cadastro</h3>

		<form method="POST" action="solicitacaoController">
			<div class="row">
				
				<div class="form-group col-md-12">
					<input type="hidden" name="id" value="${solicitacao.id}" readonly="readonly" required="required" class="form-control" id="id" placeholder="Digite o nome">
				</div>
				
				<div class="form-group col-md-12">
					<label for="nome">Nome</label> 
					<input type="text" name="nome" value="${solicitacao.nome}" required="required" class="form-control" id="nome" placeholder="Digite o nome">
				</div>

				<div class="form-group col-md-12">
					<label for="login">Login</label> 
					<input type="login" value="${solicitacao.login}" name="login" required="required" class="form-control" id="login" placeholder="Digite o login">
				</div>
				
				<div class="form-group col-md-12">
					<label for="senha">Senha</label> 
					<input type="password" value="${solicitacao.senha}" name="senha" required="required" class="form-control" id="senha" placeholder="Digite a senha">
				</div>
				
			</div>
			

			<div class="row">
				<div class="col-md-12">
					<button type="submit" class="btn btn-primary">Salvar</button>
				</div>
				
			</div>


		</form>

	</div>

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
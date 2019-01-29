<!DOCTYPE html>
<%@page import="br.com.curso.business.*"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="br.com.curso.model.Contato" %>
<%@page import="br.com.curso.model.Usuario" %>
<%@page import="br.com.curso.dao.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		UsuarioBusiness businessUsuario = new UsuarioBusiness();
		ContatoBusiness businessContato = new ContatoBusiness();
		String usuario = (String) session.getAttribute("user");
		Usuario usuarioSessao = businessUsuario.findByLogin(usuario);
	%>
	
	
	
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="row">
			
				<div class="navbar-header col-sm-10">
					<a class="navbar-brand" href="home.jsp">Curso Java Web 2019</a>
						<ul class="nav navbar-nav">
						<li><a href="contatoController?action=list">Contatos</a></li>
						
						<c:if test="<%= usuarioSessao.isAdministrador() %>">
							<li><a href="usuarioController?action=list">Usuários</a></li>						
						</c:if>
						
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
		<h3 class="page-header">Cadastro de Contatos</h3>

		<div align="center">
			<%
				
				Collection<Contato> contatos = businessContato.listAll();
			%>
	
		</div>
		<caption>
            	<h4>
            		<c:if test="${cadastro != null}">
            			<div class="alert alert-success" role="alert">
						  ${cadastro}
						</div>
            		</c:if>
            	</h4>
            	
            	<h4>
            		<c:if test="${editado != null}">
            			<div class="alert alert-success" role="alert">
						  ${editado}
						</div>
            		</c:if>
            	</h4>
            	
            	<h4>
            		<c:if test="${remover != null}">
            			<div class="alert alert-danger" role="alert">
						  ${remover}
						</div>
            		</c:if>
            	</h4>
         </caption>

		<table class="table table-striped">
			<thead>
				<tr>
					<th>Id</th>
					<th>Nome</th>
					<th>E-mail</th>
					<th>Telefone</th>
				</tr>
			</thead>
			<c:forEach var="c" items="<%=contatos %>">
			
					<tr>
						<td>${c.id == null ? '' : c.id}</td>
						<td>${c.nome == null ? '' : c.nome}</td>
						<td>${c.email == null ? '' : c.email}</td>
						<td>${c.telefone == null ? '' : c.telefone}</td>
						<td>
							<td>
                        		<a href="contatoController?id=${c.id}&action=editar" class="btn btn-primary">Editar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        		<a href="contatoController?id=${c.id}&action=delete" class="btn btn-danger">Deletar</a>                     
                    		</td>
						</td>
					</tr>
			
			</c:forEach>
				
		</table>
		
		</div>
			<div class="col-md-12">
				<a href="contatoController?action=novo" class="btn btn-primary">Cadastro</a>
			</div>
		</div>
	<div class="row">

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
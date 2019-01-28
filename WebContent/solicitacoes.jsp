<!DOCTYPE html>
<%@page import="br.com.curso.dao.SolicitacaoDaoImpl"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="br.com.curso.model.Solicitacao" %>
<%@page import="br.com.curso.model.Usuario" %>
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
		<h3 class="page-header">Solicitações Realizadas</h3>

		<div align="center">
			<%
				SolicitacaoDaoImpl dao = new SolicitacaoDaoImpl();
				Collection<Solicitacao> solicitacoes = dao.listAll();
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
					<th>Permissão</th>
					<th>Status</th>
					<th>Situação</th>
				</tr>
			</thead>
			<c:forEach var="s" items="<%=solicitacoes%>">
			
					<tr>
						<td>${s.id == null ? '' : s.id}</td>
						<td>${s.nome == null ? '' : s.nome}</td>
						<td>${s.login == null ? '' : s.login}</td>
						<td>${s.visitante ? 'Visitante' : '' }</td>
						<td>${s.ativo ? 'Ativo' : 'Inativo'}</td>
						<td>${s.situacao ? 'Rejeitada' : 'Pendente'}</td>
						<td>
							<td>
                        		<a href="solicitacaoController?id=${s.id}&action=aceitar" class="btn btn-primary">Aceitar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        		<a href="solicitacaoController?id=${s.id}&action=rejeitar" class="btn btn-warning">Rejeitar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        		<a href="solicitacaoController?id=${s.id}&action=deletar" class="btn btn-danger">Deletar</a>                     
                    		</td>
						</td>
					</tr>
			
			</c:forEach>
				
		</table>

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
</body>
</html>
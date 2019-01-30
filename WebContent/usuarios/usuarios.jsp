<!DOCTYPE html>
<%@page import="br.com.curso.business.UsuarioBusiness"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="br.com.curso.model.Usuario" %>
<%@page import="br.com.curso.dao.UsuarioDaoImpl" %>
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
		UsuarioBusiness business = new UsuarioBusiness();
		String usuario = (String) session.getAttribute("user");
		Usuario usuarioSessao = business.findByLogin(usuario);
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
		<h3 class="page-header">Cadastro de Usuários</h3>

		<div align="center">
			<%
				Collection<Usuario> usuarios = business.listAll();
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
					<th>Login</th>
					<th>Status</th>
					<th>Permissões</th>
				</tr>
			</thead>
			<c:forEach var="u" items="<%=usuarios %>">
			
					<tr>
						<td>${u.id == null ? '' : u.id}</td>
						<td>${u.nome == null ? '' : u.nome}</td>
						<td>${u.login == null ? '' : u.login}</td>
						<td>${u.ativo ? 'Ativo' : 'Inativo'}</td>
						<td>${u.administrador ? 'Administrador' : ''}  ${u.visitante ? 'Visitante' : ''}</td>
						<td>
							<td>
                        		<a href="usuarioController?id=${u.id}&action=editar" class="btn btn-primary">Editar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        		<button value="Excluir" onclick="setaDadosModal(${u.id});" type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">
								 Excluir
								</button> 
                        		<a href="usuarioController?id=${u.id}&action=ativar_desativar" 
                        			class="${u.ativo ? "btn btn-warning" : "btn btn-success" }">${u.ativo ? 'Desativar' : 'Ativar'}</a>                     
                    		</td>
						</td>
					</tr>
			
			</c:forEach>
				
		</table>
		
		</div>
			<div class="col-md-12">
				<a href="usuarioController?action=novo" class="btn btn-primary">Cadastro</a>
			</div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Excluir Usuário</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        Deseja excluir o usuário selecionado ?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <a id="removerUsuario" class="btn btn-danger">Deletar</a>
		      </div>
		    </div>
		  </div>
		</div>

	<script src="./dist/js/jquery.min.js"></script>
	<script src="./dist/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
	function setaDadosModal(valor) {
		var remove = 'usuarioController?id='+valor+'&action=delete';
	    document.getElementById('removerUsuario').href = remove;
	}
	
	
	
	</script>
	
</body>
</html>
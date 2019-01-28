<!doctype html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.HashMap"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Login</title>

    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dist/css/signin.css" rel="stylesheet">
  </head>

  <body class="text-center">
  	
  	<%
  		HashMap erro = (HashMap)request.getAttribute("erro");
    	String negado = (String)request.getAttribute("acessoNegado");
    	String ateLogo = (String)request.getAttribute("ateLogo");
    	String inativo = (String)request.getAttribute("inativo");
    	String solicitacao = (String)request.getAttribute("solicitacao");
  	%>
  	
    <form class="form-signin" action="loginController" method="POST">
    
      <h4>
      	<c:if test="${ateLogo != null}">
        	<div class="alert alert-info" role="alert">
		 		 ${ateLogo}
			</div>
        </c:if>
      </h4>
      
       	<c:if test="${solicitacao != null}">
        	<div class="alert alert-success" role="alert">
		 		 ${solicitacao}
			</div>
        </c:if>
      </h4>
      <h1 class="h3 mb-3 font-weight-normal">Agenda Contato</h1>
      
      <div>
	      <label for="login" class="sr-only">Login</label>
	      <input name="login" type="text" id="login" class="form-control" placeholder="Login" autofocus>
      </div>
      
      <div style="margin-top: 10px;">
	      <label for="senha" class="sr-only">Senha</label>
	      <input name="senha" type="password" id="senha" class="form-control" placeholder="Senha" >
	     
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
      <br/>
      <a href="solicitacaoController">Cadastre-se aqui</a>
      <h4>
      	<c:if test="${erro.erro != null}">
        	<div class="alert alert-danger" role="alert">
		 		 ${erro.erro}
			</div>
        </c:if>
      </h4>
      <h4>
      	<c:if test="${erro.login != null}">
        	<div class="alert alert-danger" role="alert">
		 		 ${erro.login}
			</div>
        </c:if>
      </h4>
      
      <h4>
      	<c:if test="${erro.senha != null}">
        	<div class="alert alert-danger" role="alert">
		 		 ${erro.senha}
			</div>
        </c:if>
      </h4>
      <h4>
      	<c:if test="${erro.inativo != null}">
        	<div class="alert alert-danger" role="alert">
		 		 ${erro.inativo}
			</div>
        </c:if>
      </h4> 
      
    </form>
  </body>
</html>


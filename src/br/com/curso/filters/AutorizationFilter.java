package br.com.curso.filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class AutorizationFilter
 */
@WebFilter(filterName="/autorizationFilter", urlPatterns = {"/usuarioController?action=list"})
public class AutorizationFilter implements Filter {
	
	

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		System.out.println("chamando o filtro de autorização");
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		HttpSession session = httpRequest.getSession();
		String usuario = session.getAttribute("user").toString();
		
		if(!usuario.equals("Carlos Barbosa")) {
			RequestDispatcher rd = httpRequest.getRequestDispatcher("home.jsp");
			httpRequest.setAttribute("permissao","Prezado Sr. " + usuario + " vc não possui permissao para acessar esse recurso");
			rd.forward(httpRequest, httpResponse);
		}else {
			
			RequestDispatcher rd = httpRequest.getRequestDispatcher("/usuarios/usuarios.jsp");
			rd.forward(httpRequest, httpResponse);
		}
		
	}


}

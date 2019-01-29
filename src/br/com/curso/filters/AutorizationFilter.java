package br.com.curso.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.curso.dao.UsuarioDaoImpl;
import br.com.curso.model.Usuario;

/**
 * Servlet Filter implementation class AutorizationFilter
 */
//@WebFilter(filterName="/autorizationFilter", urlPatterns = {"/usuarioController"})
public class AutorizationFilter implements Filter {
	
	private UsuarioDaoImpl dao;
	
	public AutorizationFilter() {
		this.dao = new UsuarioDaoImpl();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		String action = httpRequest.getParameter("action");
		
		if(action.equals("list")) {			
			HttpSession session = httpRequest.getSession();
			Usuario usuario = this.dao.findByLogin(session.getAttribute("user").toString());
			
			if(!usuario.isAdministrador()) {
				RequestDispatcher rd = httpRequest.getRequestDispatcher("home.jsp");
				httpRequest.setAttribute("permissao","Prezado Sr. " + usuario.getNome() + " vc não possui permissao para acessar esse recurso");
				rd.forward(httpRequest, httpResponse);
			}else {
				
				RequestDispatcher rd = httpRequest.getRequestDispatcher("/usuarios/usuarios.jsp");
				rd.forward(httpRequest, httpResponse);
			}
		}
		
	}


}

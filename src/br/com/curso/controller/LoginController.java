package br.com.curso.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.curso.dao.UsuarioDaoImpl;
import br.com.curso.model.Usuario;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/loginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UsuarioDaoImpl dao;

	public LoginController() {
		this.dao = new UsuarioDaoImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		Map<String, String> erro = new HashMap<String, String>();

		if (login == null || login.isEmpty()) {
			erro.put("login", "Informe o seu login");
		}

		if (senha == null || senha.isEmpty()) {
			erro.put("senha", "Informe a sua senha");
		}
		
		if (erro.isEmpty()) {
            Usuario user;
			try {
				user = this.dao.acess(login, senha);
			
            if (user != null) {
            	if(user.isAtivo()) {            		
            		request.getSession().setAttribute("user", user.getNome());
            		RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            		rd.forward(request, response);
            		return;
            	}else {
            		erro.put("inativo", "Usuário está desativado");
            	}
                
            } else {
                erro.put("erro", "Login e ou senha inválido");
            }  
            
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
		
		 request.setAttribute("erro", erro);
	     request.getRequestDispatcher("/login.jsp").forward(request, response);

	}
}

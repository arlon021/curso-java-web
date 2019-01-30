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
import br.com.curso.utils.Constantes;

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
		request.getRequestDispatcher(Constantes.LOGIN).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		Map<String, String> erro = new HashMap<String, String>();

		if (login == null || login.isEmpty()) {
			erro.put("login", Constantes.INFORME_LOGIN);
		}

		if (senha == null || senha.isEmpty()) {
			erro.put("senha", Constantes.INFORME_SENHA);
		}
		
		if (erro.isEmpty()) {
            Usuario user;
			try {
				user = this.dao.acess(login, senha);
			
            if (user != null) {
            	if(user.isAtivo()) {            		
            		request.getSession().setAttribute("user", user.getNome());
            		RequestDispatcher rd = request.getRequestDispatcher(Constantes.HOME);
            		rd.forward(request, response);
            		return;
            	}else {
            		erro.put("inativo", Constantes.USUÁRIO_ESTÁ_DESATIVADO);
            	}
                
            } else {
                erro.put("erro", Constantes.LOGIN_E_OU_SENHA_INVÁLIDO);
            }  
            
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
		
		 request.setAttribute("erro", erro);
	     request.getRequestDispatcher(Constantes.LOGIN).forward(request, response);

	}
}

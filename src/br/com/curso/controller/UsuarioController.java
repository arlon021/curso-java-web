package br.com.curso.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.curso.business.UsuarioBusiness;
import br.com.curso.model.Usuario;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/usuarioController")
public class UsuarioController extends HttpServlet {

	private UsuarioBusiness business;

	private static final long serialVersionUID = 1L;

	public UsuarioController() {
		this.business = new UsuarioBusiness();
	}

	public void init(ServletConfig config) throws ServletException {
		System.out.println("Iniciando servlet controlador");
	}

	public void destroy() {
		System.out.println("Removendo o servlet");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

		try {
			switch (action) {
			case "novo":
				novo(request, response);
				break;
			case "delete":
				delete(request, response);
				break;
			case "editar":
				editar(request, response);
				break;
			case "list" :
				list(request, response);
				break;
			default:
				ativar_desativar(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void ativar_desativar(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, Exception {
		
		Usuario usuario = this.business.ativarDesativar(Long.parseLong(request.getParameter("id")));
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/usuarios.jsp");
		request.setAttribute("usuario", usuario);
		rd.forward(request, response);
	}

	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/usuarios.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * Prepara formulário para cadastro de um novo contato
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void novo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/add_usuario.jsp");
		rd.forward(request, response);
	}

	/**
	 * Cadastro de um novo contato
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Usuario usuario = new Usuario();
		
		String nome = request.getParameter("nome");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String id = request.getParameter("id");
		String [] permissoes = request.getParameterValues("permissoes");
		
		if(permissoes == null) {
			usuario.setAdministrador(false);
			usuario.setVisitante(false);
			
		}else {
			for (int i = 0; i < permissoes.length; i++) {
				if(permissoes[i].equals("Administrador")) {
					usuario.setAdministrador(true);
				} else if (permissoes[i].equals("Visitante")) {
					usuario.setVisitante(true);
				}
			}
		}
			
		usuario.setLogin(login);
		usuario.setNome(nome);
		usuario.setSenha(senha);
		
		
		if(id != "") {
			usuario.setId(Long.parseLong(id));
			request.setAttribute("editado", " Usuário " + nome + " editado com sucesso");
		}else {
			request.setAttribute("cadastro", " Usuário " + nome + " cadastrado com sucesso");			
		}
		try {
			this.business.save(usuario);
		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/usuarios.jsp");
		rd.forward(request,response);

	}

	/**
	 * Metodo que remove um contato do banco de dados
	 * 
	 * @param request
	 * @param response
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	private void delete(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, Exception {
		this.business.deleteById(Long.parseLong(request.getParameter("id")));
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/usuarios.jsp");
		request.setAttribute("remover", " Usuário removido com sucesso");
		rd.forward(request, response);

	}

	/**
	 * Metodo que edita um contato
	 * 
	 * @param request
	 * @param response
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	private void editar(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, Exception {

		Usuario usuario = this.business.findById(Long.parseLong(request.getParameter("id")));
		RequestDispatcher rd = request.getRequestDispatcher("/usuarios/add_usuario.jsp");
		request.setAttribute("usuario", usuario);
		rd.forward(request, response);
	}

}

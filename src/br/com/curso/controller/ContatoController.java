package br.com.curso.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.curso.business.ContatoBusiness;
import br.com.curso.model.Contato;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/contatoController")
public class ContatoController extends HttpServlet {

	private ContatoBusiness business;

	private static final long serialVersionUID = 1L;

	public ContatoController() {
		this.business = new ContatoBusiness();
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
//				home(request, response);
				break;
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}
	
//	private void home(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
//		rd.forward(request, response);
//		
//	}

	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/contatos/contatos.jsp");
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
		RequestDispatcher rd = request.getRequestDispatcher("/contatos/add_contato.jsp");
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
		
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String telefone = request.getParameter("telefone");
		String id = request.getParameter("id");
		
			
		Contato contato = new Contato();
		contato.setEmail(email);
		contato.setNome(nome);
		contato.setTelefone(telefone);
		
		if(id != "") {
			contato.setId(Long.parseLong(id));
			request.setAttribute("editado", " Contato " + nome + " editado com sucesso");
		}else {
			request.setAttribute("cadastro", " Contato " + nome + " cadastrado com sucesso");			
		}
		try {
			this.business.save(contato);
		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("/contatos/contatos.jsp");
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
		RequestDispatcher rd = request.getRequestDispatcher("/contatos/contatos.jsp");
		request.setAttribute("remover", " Contato removido com sucesso");
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

		Contato contato = this.business.findById(Long.parseLong(request.getParameter("id")));
		RequestDispatcher rd = request.getRequestDispatcher("/contatos/add_contato.jsp");
		request.setAttribute("contato", contato);
		rd.forward(request, response);
	}

}

package br.com.curso.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.curso.business.SolicitacaoBusiness;
import br.com.curso.model.Solicitacao;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/solicitacaoController")
public class SolicitacaoController extends HttpServlet {

	private SolicitacaoBusiness business;

	private static final long serialVersionUID = 1L;

	public SolicitacaoController() {
		this.business = new SolicitacaoBusiness();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

		try {
			switch (action) {
			case "novo":
				novo(request, response);
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
		
		Solicitacao solicitacao = this.business.ativarDesativar(Long.parseLong(request.getParameter("id")));
		RequestDispatcher rd = request.getRequestDispatcher("cadastrese.jsp");
		request.setAttribute("solicitacao", solicitacao);
		rd.forward(request, response);
	}

	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("solicitacoes.jsp");
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
		RequestDispatcher rd = request.getRequestDispatcher("cadastrese.jsp");
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
		
		Solicitacao solicitacao = new Solicitacao();
		
		String nome = request.getParameter("nome");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		
		solicitacao.setVisitante(true);
		solicitacao.setLogin(login);
		solicitacao.setNome(nome);
		solicitacao.setSenha(senha);
		
		request.setAttribute("cadastro", " Solicitacao " + nome + " cadastrado com sucesso");			
		
		try {
			this.business.save(solicitacao);
		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("cadastrese.jsp");
		rd.forward(request,response);

	}
}

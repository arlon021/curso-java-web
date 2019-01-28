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

import br.com.curso.business.SolicitacaoBusiness;
import br.com.curso.model.Solicitacao;

/**
 * Servlet Filter implementation class FilterLoggin
 */
@WebFilter(filterName = "/solicitacaoFilter", urlPatterns = "/solicitacaoController")
public class SolicitacaoFilter implements Filter {

	private SolicitacaoBusiness business;

	private Solicitacao solicitacao;

	public SolicitacaoFilter() {
		this.business = new SolicitacaoBusiness();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		String nome = httpRequest.getParameter("nome");
		String login = httpRequest.getParameter("login");
		String senha = httpRequest.getParameter("senha");

		String action = httpRequest.getParameter("action");

		if (action != null) {
			if (action.equals("list")) {
				RequestDispatcher rd = httpRequest.getRequestDispatcher("solicitacoes.jsp");
				rd.forward(httpRequest, httpResponse);
			}
		}

		if (nome != null && login != null && senha != null) {

			this.solicitacao = new Solicitacao();
			this.solicitacao.setAtivo(false);
			this.solicitacao.setVisitante(true);
			this.solicitacao.setLogin(login);
			this.solicitacao.setNome(nome);
			this.solicitacao.setSenha(senha);

			try {

				this.business.save(solicitacao);

				httpRequest.setAttribute("solicitacao", "Solicitação enviada com sucesso");
				RequestDispatcher rd = httpRequest.getRequestDispatcher("login.jsp");
				rd.forward(httpRequest, httpResponse);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {

			if (!response.isCommitted()) {
				RequestDispatcher rd = httpRequest.getRequestDispatcher("cadastrese.jsp");
				rd.forward(httpRequest, httpResponse);
			}
			return;
		}

	}
}

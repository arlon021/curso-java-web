/**
 * 
 */
package br.com.curso.business;

import java.util.Collection;

import br.com.curso.dao.UsuarioDaoImpl;
import br.com.curso.model.Usuario;

/**
 * @author carlosbarbosagomesfilho
 *
 */
public class UsuarioBusiness {

	private UsuarioDaoImpl dao;

	public UsuarioBusiness() {
		this.dao = new UsuarioDaoImpl();
	}
	
	public void save(Usuario usuario) throws Exception  {
		this.dao.save(usuario);
	}
	
	public void update(Usuario usuario) throws Exception  {
		this.dao.update(usuario);
	}
	
	public Collection<Usuario> listAll() throws Exception {
		return this.dao.listAll();
	}
	
	public Usuario findById(Long id) throws Exception {
		return this.dao.findById(id);
	}
	
	public void deleteById(Long id) throws Exception {
		this.dao.deleteById(id);
	}
	
	public Usuario ativarDesativar (Long id) throws Exception {
		return this.dao.ativarDesativar(id);
	}
	
	public Usuario findByLogin(String nome) throws Exception {
		return this.dao.findByLogin(nome);
		
	}
}

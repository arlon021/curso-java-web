/**
 * 
 */
package br.com.curso.dao;

import java.util.Collection;

import br.com.curso.model.Contato;

/**
 * @author carlosbarbosagomesfilho
 *
 */
public interface IContatoDao extends GenericDao<Contato, Long> {

	public void save(Contato contato) throws Exception;
	
	public Contato findById(Long id) throws Exception;
	
	public void deleteById(Long id) throws Exception;
	
	public void update(Contato contato) throws Exception;
	
	public Collection<Contato> listAll() throws Exception;
}

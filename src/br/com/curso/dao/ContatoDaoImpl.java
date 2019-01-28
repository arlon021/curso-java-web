/**
 * 
 */
package br.com.curso.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;

import br.com.curso.model.Contato;
import br.com.curso.utils.JPAUtils;

/**
 * @author carlosbarbosagomesfilho
 *
 */
public class ContatoDaoImpl implements IContatoDao {

	EntityManagerFactory emf = JPAUtils.getEntityManagerFactory();
	EntityManager factory = null;

	public void save(Contato contato) throws Exception  {

		this.factory = emf.createEntityManager();

		try {
			factory.getTransaction().begin();
			if (contato.getId() == null) {
				factory.persist(contato);
			} else {
				factory.merge(contato);
			}
			factory.getTransaction().commit();

		} catch (Exception e) {
			e.getMessage();
			this.factory.getTransaction().rollback();
			
		} finally {
			factory.close();
		}
	}

	public Contato findById(Long id) throws Exception  {
		this.factory = emf.createEntityManager();
		Contato contato = new Contato();
		try {
			contato = factory.find(Contato.class, id);
			return contato;

		} catch (Exception e) {
			e.getMessage();
			this.factory.getTransaction().rollback();
		} finally {
			factory.close();
		}
		return null;
	}

	@Override
	public void deleteById(Long id) throws Exception {
		this.factory = emf.createEntityManager();
		Contato contato = new Contato();

		try {

			contato = factory.find(Contato.class, id);
			factory.getTransaction().begin();
			factory.remove(contato);
			factory.getTransaction().commit();

		} catch (Exception e) {
			e.getMessage();
			this.factory.getTransaction().rollback();
		} finally {
			factory.close();
		}

	}

	@Override
	public void update(Contato contato) throws Exception {
		this.factory = emf.createEntityManager();

		try {
			factory.getTransaction().begin();
			factory.merge(contato);
			factory.getTransaction().commit();

		} catch (Exception e) {
			e.getMessage();
			this.factory.getTransaction().rollback();
		} finally {
			factory.close();
		}
	}

	@Override
	public Collection<Contato> listAll() throws Exception {
		this.factory = emf.createEntityManager();
		List<Contato> contatos = new ArrayList<Contato>();
		try {
			factory.getTransaction().begin();
			TypedQuery<Contato> query = factory.createNamedQuery("Contato.findAll", Contato.class);
			contatos = query.getResultList();
			factory.getTransaction().commit();
//			
//			return this.factory.createQuery("SELECT c FROM Contato c", Contato.class).getResultList();

		} catch (Exception e) {
			e.getMessage();
			this.factory.getTransaction().rollback();
		} finally {
			factory.close();
		}

		return contatos;
	}

}

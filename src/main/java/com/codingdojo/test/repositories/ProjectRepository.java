package com.codingdojo.test.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.test.models.Project;
import com.codingdojo.test.models.User;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long> {
	List<Project> findAll();
	
	List<Project> findAllByUsers(User user);
	
	List<Project> findByUsersNotContains(User user);
}

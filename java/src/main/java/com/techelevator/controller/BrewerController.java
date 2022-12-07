package com.techelevator.controller;


import com.techelevator.dao.JdbcBreweryDao;
import com.techelevator.dao.JdbcUserDao;
import com.techelevator.model.Brewery;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@PreAuthorize("isAuthenticated()")
@CrossOrigin
public class BrewerController {

    //create userDao
    private JdbcBreweryDao breweryDao;
    private JdbcUserDao userDao;

    public BrewerController(JdbcUserDao userDao, JdbcBreweryDao breweryDao) {
        this.userDao = userDao;
        this.breweryDao = breweryDao;
    }

    //end point for authorized brewers to view their list of breweries
    @PreAuthorize("hasRole('BREWER')")
    @RequestMapping(path = "/brewer", method = RequestMethod.GET)
    public List<Brewery> getBrewer(Principal principal){
        int userId = userDao.findIdByUsername(principal.getName());

        return breweryDao.getAllBreweriesByUserId(userId);
    }
}

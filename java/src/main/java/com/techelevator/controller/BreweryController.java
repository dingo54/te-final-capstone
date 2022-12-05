package com.techelevator.controller;

import com.techelevator.dao.BreweryDao;
import com.techelevator.model.Brewery;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
public class BreweryController {
    private BreweryDao breweryDao;

    public BreweryController(BreweryDao breweryDao){
        this.breweryDao = breweryDao;
    }

    @RequestMapping(path = "/brewery", method = RequestMethod.GET)
    public List<Brewery> getAllBreweries(){
        return breweryDao.getAllBreweries();
    }
}

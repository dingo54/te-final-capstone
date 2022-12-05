package com.techelevator.controller;

import com.techelevator.dao.BreweryDao;
import com.techelevator.model.Brewery;
import org.springframework.web.bind.annotation.*;

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
    @RequestMapping(path = "/brewery", method = RequestMethod.POST)
    public Brewery addBrewery(@RequestBody Brewery brewery) {
        if (brewery != null) {
            breweryDao.addBrewery(brewery);
        }
        return brewery;
    }
}

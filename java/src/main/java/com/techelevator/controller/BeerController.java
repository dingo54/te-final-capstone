package com.techelevator.controller;

import com.techelevator.dao.BeerDao;
import com.techelevator.model.Beer;
import org.hibernate.validator.constraints.pl.REGON;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@CrossOrigin
public class BeerController {
    BeerDao beerDao;

    public BeerController(BeerDao beerDao) {
        this.beerDao = beerDao;
    }

    @RequestMapping(path = "/beer",method = RequestMethod.GET)
    public List<Beer> getAllBeers(){
        return beerDao.getListOfBeers();
    }

    @RequestMapping(path = "/beer/{breweryId}", method = RequestMethod.GET)
    public List<Beer> getAllBeersByBreweryId(@PathVariable int breweryId){
        return beerDao.getAllBeersByBreweryId(breweryId);
    }
    @RequestMapping(path = "beer",method = RequestMethod.POST)
    public Beer addBeer(@RequestBody Beer beer){
        return beerDao.addBeer(beer);
    }
    @RequestMapping(path = "beer/{beerID}",method = RequestMethod.PUT)
    public void updateBeer(@PathVariable int beerID, @RequestBody Beer beer){
        if (beerID != beer.getBeerId()){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "beer Id not found");
        }
        beerDao.updateBeer(beerID,beer);
    }

}

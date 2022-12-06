package com.techelevator.controller;

import com.techelevator.dao.BeerDao;
import com.techelevator.model.Beer;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
public class BeerController {
    BeerDao beerDao;

    @RequestMapping(path = "/beer",method = RequestMethod.GET)
    public List<Beer> getAllBeers(){
        return beerDao.getAllBeers();
    }

    @RequestMapping(path = "/beer/{breweryId}", method = RequestMethod.GET)
    public List<Beer> getAllBeersByBreweryId(@PathVariable int breweryId){
        return beerDao.getAllBeersByBreweryId(breweryId);
    }



}

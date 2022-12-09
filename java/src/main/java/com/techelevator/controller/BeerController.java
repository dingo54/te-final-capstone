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
    @RequestMapping(path = "/beer",method = RequestMethod.POST)
    public Beer addBeer(@RequestBody Beer beer){
        return beerDao.addBeer(beer);
    }

<<<<<<< HEAD
    @RequestMapping(path = "beer/{beerID}",method = RequestMethod.PUT)
=======
    @RequestMapping(path = "/beer/{beerID}",method = RequestMethod.PUT)
>>>>>>> dbd978d7867ee9e6faa90ae4f53e5ecf29d1a7db
    public void updateBeer(@PathVariable int beerID, @RequestBody Beer beer){
        if (beerID != beer.getBeerId()){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "beer Id not found");
        }
        beerDao.updateBeer(beerID,beer);
    }

    //Delete a beer
    @RequestMapping(path = "/beer/{breweryId}", method = RequestMethod.DELETE)
    public void deleteBeer(@PathVariable int breweryId) {
        beerDao.delete(breweryId);
    }

}

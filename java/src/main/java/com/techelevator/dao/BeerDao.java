package com.techelevator.dao;

import com.techelevator.model.Beer;

import java.util.List;

public interface BeerDao {
    List<Beer> getAllBeers();
    List<Beer> getAllBeersByBreweryId(int breweryId);
    Beer addBeer(Beer beer);
    boolean updateBeer(Beer beer);



}

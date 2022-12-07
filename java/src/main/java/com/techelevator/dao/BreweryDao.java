package com.techelevator.dao;


import com.techelevator.model.Brewery;

import java.util.List;

public interface BreweryDao {

    List<Brewery> getAllBreweries();
    Brewery getBreweryById(int breweryId);
    Brewery addBrewery(Brewery brewery);
    boolean updateBrewery(int breweryId, Brewery brewery);

    List<Brewery> getAllBreweriesByUserId(int userId);



}

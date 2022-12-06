package com.techelevator.dao;


import com.techelevator.model.Beer;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcBeerDao implements BeerDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcBeerDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Beer> getAllBeers() {
        List<Beer> beers = new ArrayList<>();
        String sql = "SELECT beer_id, brewery_id, name, style, price, abv, image, description\n" +
                "\tFROM public.beer;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while (result.next()){
            beers.add(mapRowToBeer(result));
        }
        return beers;
    }

    @Override
    public List<Beer> getAllBeersByBreweryId(int breweryId) {
        List<Beer> beers = new ArrayList<>();
        String sql = "SELECT beer_id, brewery_id, name, style, price, abv, image, description\n" +
                "\tFROM public.beer WHERE brewery_id = ?;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql, breweryId);
        while (result.next()){
            beers.add(mapRowToBeer(result));
        }
        return beers;
    }

    @Override
    public Beer addBeer(Beer beer) {
        return null;
    }

    @Override
    public boolean updateBeer(Beer beer) {
        return false;
    }
    public Beer mapRowToBeer(SqlRowSet rowSet){
        try {
            Beer beer = new Beer();
            beer.setBeerId(rowSet.getInt("beer_id"));
            beer.setAbv(rowSet.getDouble("abv"));
            beer.setBreweryId(rowSet.getInt("brewery_id"));
            beer.setDescription(rowSet.getString("description"));
            beer.setImage(rowSet.getString("image"));
            beer.setMoney(rowSet.getBigDecimal("price"));
            beer.setName(rowSet.getString("name"));
            beer.setStyle(rowSet.getString("style"));
            return beer;
        }catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

}

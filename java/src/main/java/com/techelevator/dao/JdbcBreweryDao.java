package com.techelevator.dao;

import com.techelevator.model.Brewery;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcBreweryDao implements BreweryDao{
    private JdbcTemplate jdbcTemplate;

    /*private String breweryName;
    private String imageURL;
    private String phoneNumber;
    private String address;*/

    public JdbcBreweryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Brewery> getAllBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description\n" +
                "\tFROM public.brewery;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while(result.next()){
            breweries.add(mapToBrewery(result));
        }
        return breweries;
    }

    @Override
    public Brewery getBreweryById(int breweryId) {
        Brewery brewery = new Brewery();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description\n" +
                "\tFROM public.brewery WHERE brewery_id = ?;";
        SqlRowSet result= jdbcTemplate.queryForRowSet(sql, breweryId);
        while(result.next()){
            brewery = mapToBrewery(result);
        }
        return brewery;
    }

    @Override
    public Brewery addBrewery(Brewery brewery) {
        Brewery newBrewery = new Brewery();
        newBrewery.setPhoneNumber(brewery.getPhoneNumber());
        newBrewery.setImageURL(brewery.getImageURL());
        newBrewery.setBreweryName(brewery.getBreweryName());
        newBrewery.setAddress(brewery.getBreweryName());
        String sql="INSERT INTO public.brewery(\n" +
                "\tbrewery_name, phone_number, address, image_url, description)\n" +
                "\tVALUES (?, ?, ?, ?) RETURNING brewery_id;";
        int breweryId = jdbcTemplate.queryForObject(sql, int.class, newBrewery.getBreweryName(),newBrewery.getPhoneNumber(),newBrewery.getAddress(),newBrewery.getImageURL(), newBrewery.getDescription());
        newBrewery.setBreweryId(breweryId);
        return newBrewery;
    }

    @Override
    public boolean updateBrewery(int breweryId, Brewery brewery) {
        String sql ="UPDATE public.brewery\n" +
                "\tSET brewery_id=?, brewery_name=?, phone_number=?, address=?, image_url=?, description=?\n" +
                "\tWHERE brewery_id =?;";
        int numberOfRowsUpdated = jdbcTemplate.update(sql, brewery.getBreweryName(),brewery.getPhoneNumber(),brewery.getAddress(),brewery.getImageURL(), brewery.getDescription(), breweryId);



        return numberOfRowsUpdated == 1;
    }
    private Brewery mapToBrewery(SqlRowSet results){
        try {
            Brewery brewery = new Brewery();
            brewery.setBreweryId(results.getInt("brewery_id"));
            brewery.setAddress(results.getString("address"));
            brewery.setBreweryName(results.getString("brewery_name"));
            brewery.setImageURL(results.getString("image_url"));
            brewery.setPhoneNumber(results.getString("phone_number"));
            brewery.setDescription(results.getString("description"));
            return brewery;
        }catch(Exception e){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }
}

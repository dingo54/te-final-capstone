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
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url\n" +
                "\tFROM public.brewery;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while(result.next()){
            breweries.add(mapToBrewery(result));
        }
        return breweries;
    }

    @Override
    public Brewery getBreweryById(int breweryId) {
        return null;
    }

    @Override
    public Brewery addBrewery(Brewery brewery) {
        return null;
    }

    @Override
    public Brewery updateBrewery(int breweryId, Brewery brewery) {
        return null;
    }
    private Brewery mapToBrewery(SqlRowSet results){
        try {
            Brewery brewery = new Brewery();
            brewery.setBreweryId(results.getInt("brewery_id"));
            brewery.setAddress(results.getString("address"));
            brewery.setBreweryName(results.getString("brewery_name"));
            brewery.setImageURL(results.getString("image_url"));
            brewery.setPhoneNumber(results.getString("phone_number"));
            return brewery;
        }catch(Exception e){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }
}

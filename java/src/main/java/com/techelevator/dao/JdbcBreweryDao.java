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

    private static List<Brewery> breweries = new ArrayList<>();
    private JdbcTemplate jdbcTemplate;
    private BreweryDao breweryDao;

    public JdbcBreweryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Brewery> getAllBreweries() {
        List<Brewery> breweries = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description\n, is_approved, owner" +
                "\tFROM public.brewery WHERE is_approved = true;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while(result.next()){
            breweries.add(mapToBrewery(result));
        }
        return breweries;
    }

    @Override
    public Brewery getBreweryById(int breweryId) {
        Brewery brewery = new Brewery();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description, is_approved, owner " +
                "FROM public.brewery WHERE brewery_id = ?;";
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
    public Brewery updateBrewery(int breweryId, Brewery brewery) {
        String sql ="UPDATE public.brewery " +
                "SET brewery_name=?, phone_number=?, address=?, image_url=?, description=? " +
                "WHERE brewery_id =?;";
        int numOfRowsUpdated = jdbcTemplate.update(sql, brewery.getBreweryName(),brewery.getPhoneNumber(),brewery.getAddress(),brewery.getImageURL(), brewery.getDescription(), breweryId);

        return getBreweryById(breweryId);
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
            brewery.setIsApproved(results.getBoolean("is_approved"));
            brewery.setOwner(results.getInt("owner"));
            return brewery;
        }catch(Exception e){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }
    @Override
    public List <Brewery> getAllBreweriesByUserId(int userId) {
        List <Brewery> brewery = new ArrayList<>();
        String sql = "SELECT brewery_id, brewery_name, phone_number, address, image_url, description, is_approved, owner\n" +
                "\tFROM public.brewery\n" +
                "\tWHERE owner = ?;";
        SqlRowSet result= jdbcTemplate.queryForRowSet(sql, userId);
        while(result.next()){
           brewery.add(mapToBrewery(result));
        }
        return brewery;
    }

    @Override
    public Brewery create(Brewery brewery, int ownerId) {
        String name = brewery.getBreweryName();
        String number = brewery.getPhoneNumber();
        String address = brewery.getAddress();
        String image = brewery.getImageURL();
        String description = brewery.getDescription();
        boolean defaultIsApproved = false;
        String sql = "INSERT INTO public.brewery( " +
                "brewery_name, phone_number, address, image_url, description, is_approved, owner) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING brewery_id;";

        int newBreweryId = jdbcTemplate.queryForObject(sql, Integer.class, name, number, address,
                    image, description, defaultIsApproved, ownerId);

        return getBreweryById(newBreweryId);
    }

    @Override
//    public boolean delete(int breweryId){return false;}
    public void delete(int breweryId) {
        Brewery target = null;
        for(Brewery brewery : breweries){
            if(brewery.getBreweryId() == breweryId) {
                target = brewery;
            }
        }
        // when using foreach we must remove the item after iterating to avoid a ConcurrentModificationException
        breweries.remove(target);
    }
}

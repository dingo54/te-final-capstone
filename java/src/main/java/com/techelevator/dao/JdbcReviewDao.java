package com.techelevator.dao;

import com.techelevator.model.Review;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcReviewDao implements ReviewDao {

    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Review> getListOfReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT review_id, beer_id, user_id, rating, review FROM public.beer_reviews;";
        SqlRowSet result = jdbcTemplate.queryForRowSet(sql);
        while (result.next()){
            reviews.add(mapRowToReview(result));
        }
        return reviews;
    }

    @Override
    public List<Review> getReviewsByBeerId(int beerId) {
        return null;
    }

    @Override
    public List<Review> getReviewsByBreweryId(int breweryId) {
        return null;
    }

    @Override
    public Review addReview(Review review) {
        return null;
    }

    @Override
    public boolean deleteReview(int reviewId) {
        return false;
    }

    public Review mapRowToReview(SqlRowSet rowSet){
        try {
            Review review = new Review();
            review.setReviewId(rowSet.getInt("review_id"));
            review.setBeerId(rowSet.getInt("beer_id"));
            review.setUserId(rowSet.getInt("user_id"));
            review.setRating(rowSet.getInt("rating"));
            review.setReview(rowSet.getString("review"));
            return review;
        }catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }
}

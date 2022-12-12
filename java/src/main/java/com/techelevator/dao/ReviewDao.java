package com.techelevator.dao;

import com.techelevator.model.Review;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

public interface ReviewDao {
    List<Review> getListOfReviews();
    List<Review> getReviewsByBeerId(int beerId);
    List<Review> getReviewsByBreweryId(int breweryId);
    Review addReview(Review review);
    boolean deleteReview(int reviewId);

}

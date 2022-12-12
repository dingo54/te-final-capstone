package com.techelevator.controller;

import com.techelevator.dao.ReviewDao;
import com.techelevator.model.Review;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
public class ReviewController {
    ReviewDao reviewDao;

    public ReviewController(ReviewDao reviewDao) {
        this.reviewDao = reviewDao;
    }

    @RequestMapping(path = "/reviews",method = RequestMethod.GET)
    public List<Review> getAllReviews() {
        return reviewDao.getListOfReviews();
    }

    /*@RequestMapping(path = "/reviews/{beerId}",method = RequestMethod.GET)
    public List<Review> getReviewsByBeerId(@PathVariable int beerId) {
        List<Review> reviews = getReviewsByBeerId(beerId);
        if(reviews!=null)
        return
    }*/
}

package com.techelevator.model;

public class Brewery {
    private int breweryId;
    private String breweryName;
    private String imageURL;
    private String phoneNumber;
    private String address;
    private String description;
    private boolean isApproved;
    private int owner;
    private String hours;
    private Integer rating = 0;

    public Brewery(){

    }

    public Brewery(String breweryName, String imageURL, String phoneNumber, String address, boolean isApproved, int owner) {
        this.breweryName = breweryName;
        this.imageURL = imageURL;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.isApproved = isApproved;
        this.owner = owner;
        this.hours = hours;
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public String getBreweryName() {
        return breweryName;
    }

    public void setBreweryName(String breweryName) {
        this.breweryName = breweryName;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean getIsApproved() {return isApproved;}

    public void setIsApproved(boolean approved) {isApproved = approved;}

    public int getOwner() { return owner; }

    public void setOwner(int owner) { this.owner = owner; }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Brewery{" +
                "breweryName='" + breweryName + '\'' +
                ", imageURL='" + imageURL + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", address='" + address + '\'' +
                '}';
    }


}

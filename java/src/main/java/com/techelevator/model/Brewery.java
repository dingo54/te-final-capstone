package com.techelevator.model;

public class Brewery {
    private int breweryId;
    private String breweryName;
    private String imageURL;
    private String phoneNumber;
    private String address;
    private String description;
    private boolean isApproved;

    public Brewery(){

    }

    public Brewery(String breweryName, String imageURL, String phoneNumber, String address) {
        this.breweryName = breweryName;
        this.imageURL = imageURL;
        this.phoneNumber = phoneNumber;
        this.address = address;
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

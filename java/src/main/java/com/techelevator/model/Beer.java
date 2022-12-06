package com.techelevator.model;

import java.math.BigDecimal;

public class Beer {
    private int beerId;
    private int breweryId;
    private String name;
    private String style;
    private BigDecimal money;
    private double abv;
    private String image;
    private String description;

    public Beer(){

    }
    public Beer(int beerId, int breweryId, String name, String style, BigDecimal money, double abv, String image, String description) {
        this.beerId = beerId;
        this.breweryId = breweryId;
        this.name = name;
        this.style = style;
        this.money = money;
        this.abv = abv;
        this.image = image;
        this.description = description;
    }

    public int getBeerId() {
        return beerId;
    }

    public void setBeerId(int beerId) {
        this.beerId = beerId;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    public double getAbv() {
        return abv;
    }

    public void setAbv(double abv) {
        this.abv = abv;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

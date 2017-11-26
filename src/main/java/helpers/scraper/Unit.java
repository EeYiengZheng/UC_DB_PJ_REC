package main.java.helpers.scraper;

public class Unit {
    private String unit;

    public Unit(String unit) {
        this.unit = unit;
    }

    public Unit() {
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Override
    public String toString() {
        return unit;
    }
}

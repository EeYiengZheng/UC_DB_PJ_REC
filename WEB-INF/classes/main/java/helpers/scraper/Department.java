package main.java.helpers.scraper;

public class Department {
    private String longName;
    private String shortName;

    public Department(String longName, String shortName) {
        this.longName = longName;
        this.shortName = shortName;
    }
    public Department() {}
    public String getLongName() {
        return longName;
    }

    public String getShortName() {
        return shortName;
    }

    public void setLongName(String longName) {
        this.longName = longName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    @Override
    public String toString() {
        return shortName;
    }
}
